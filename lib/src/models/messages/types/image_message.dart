import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../widgets/containers/message_container.dart';
import '../../../widgets/containers/text_container.dart';
import '../../../../utils/author_details_location.dart';
import '../../../../utils/themes/chat_theme.dart';
import '../../user.dart';
import 'message.dart';

class ImageMessage extends Message {
  String? caption;
  final List<String> uris;
  ImageMessage({
    required super.author,
    required super.time,
    super.stage,
    required super.id,
    required this.uris,
    this.caption,
    super.theme,
  });

  // Helper method to render individual image
  Widget _renderImage(String uri) {
    return Container(
      width: 10000,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
            image: uri.startsWith('http')
                ? CachedNetworkImageProvider(uri) as ImageProvider<Object>
                : FileImage(File(uri)) as ImageProvider<Object>,
            //  : FileImage(File(uri)),
            fit: BoxFit.cover),
      ),
    );
  }

  /// WhatsApp-style image grid layout
  Widget _buildWhatsAppStyleGrid(BuildContext context, List<String> uris) {
    const double spacing = 1.0;
    final totalUris = uris.length;
    final visibleUris = uris.take(4).toList();
    final extraCount = totalUris - 4;

    // Calculate appropriate size based on screen width
    final screenWidth = MediaQuery.of(context).size.width;
    final maxWidth =
        screenWidth * 0.65; // WhatsApp uses around 65-70% of screen width

    // Different heights for different image counts to maintain proportion
    double containerHeight;
    switch (visibleUris.length) {
      case 1:
        containerHeight = maxWidth * 0.75; // 3:4 aspect ratio for single image
        break;
      case 2:
        containerHeight = maxWidth * 0.5; // Half as tall for two images
        break;

      default:
        containerHeight = maxWidth; // Square for 3-4 images
    }

    Widget gridContent;

    switch (visibleUris.length) {
      case 1:
        // Single image - just show with rounded corners
        gridContent = ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: _renderImage(visibleUris[0]),
        );
        break;

      case 2:
        // Two images side by side
        gridContent = Row(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
                child: _renderImage(visibleUris[0]),
              ),
            ),
            const SizedBox(width: spacing),
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
                child: _renderImage(visibleUris[1]),
              ),
            ),
          ],
        );
        break;

      case 3:
        // Show three images vertically
        gridContent = Column(
          children: List.generate(3, (index) {
            return Padding(
              padding: EdgeInsets.only(bottom: index < 2 ? spacing : 0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: AspectRatio(
                  aspectRatio: 4 / 3,
                  child: _renderImage(visibleUris[index]),
                ),
              ),
            );
          }),
        );
        containerHeight =
            (maxWidth * 0.75 * 3) + (spacing * 2); // height of 3 stacked images
        break;

      case 4:
        // 2x2 grid with right spacing to mimic WhatsApp
        gridContent = Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                      ),
                      child: _renderImage(visibleUris[0]),
                    ),
                  ),
                  const SizedBox(width: spacing),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(8),
                      ),
                      child: _renderImage(visibleUris[1]),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: spacing),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                      ),
                      child: _renderImage(visibleUris[2]),
                    ),
                  ),
                  const SizedBox(width: spacing),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(8),
                      ),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          _renderImage(visibleUris[3]),
                          if (extraCount > 0)
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: 0.5),
                                borderRadius: const BorderRadius.only(
                                  bottomRight: Radius.circular(8),
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                '+$extraCount',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
        break;

      default:
        gridContent = Container(); // Fallback, should not happen with our logic
    }

    // Return the grid with constrained size
    return Container(
      constraints: BoxConstraints(
        maxWidth: maxWidth,
        maxHeight: containerHeight,
      ),
      child: gridContent,
    );
  }

  @override
  Widget builder(
      BuildContext ctx,
      bool showUserAvatar,
      bool showMessageStatus,
      bool showUsername,
      User loggedInUser,
      ChatTheme chatTheme,
      AuthorDetailsLocation authorDetailsLocation) {
    final finalMessageTheme = author.id == loggedInUser.id
        ? chatTheme.outwardMessageTheme
        : chatTheme.inwardMessageTheme;
    return MessageContainer(
      parentContext: ctx,
      message: this,
      chatTheme: chatTheme,
      showUserAvatar: showUserAvatar,
      showMessageStatus: showMessageStatus,
      showUsername: showUsername,
      user: loggedInUser,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildWhatsAppStyleGrid(ctx, uris),

          // Caption section (if exists)
          if (caption != null && caption!.trim().isNotEmpty)
            Padding(
              padding:
                  const EdgeInsets.only(top: 6, left: 20, right: 8, bottom: 6),
              child: TextContainer(
                text: caption!,
                textStyle: theme?.contentTextStyle ??
                    finalMessageTheme?.contentTextStyle,
                linkTextStyle:
                    theme?.urlTextStyle ?? finalMessageTheme?.urlTextStyle,
                boldTextStyle:
                    theme?.boldTextStyle ?? finalMessageTheme?.boldTextStyle,
              ),
            ),
        ],
      ),
      detailsLocation: authorDetailsLocation,
    );
  }
}
