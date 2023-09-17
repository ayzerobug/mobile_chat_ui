import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../widgets/containers/message_container.dart';
import '../../../widgets/containers/text_container.dart';
import '../../../../utils/author_details_location.dart';
import '../../../../utils/chat_theme.dart';
import '../../user.dart';
import 'message.dart';

class ImageMessage extends Message {
  String? caption;
  final String uri;
  ImageMessage(
      {required super.author,
      required super.time,
      super.stage,
      required this.uri,
      this.caption});

  @override
  Widget builder(
      BuildContext ctx,
      bool showUserAvatar,
      bool showMessageStatus,
      bool showUsername,
      User loggedInUser,
      ChatTheme theme,
      AuthorDetailsLocation authorDetailsLocation) {
    Widget returnValue = Column(
      children: [
        IntrinsicHeight(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(ctx).size.height * 0.5,
            ),
            child: ClipRRect(
              borderRadius: theme.imageBorderRadius ??
                  const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
              child: uri.toString().contains("http")
                  ? CachedNetworkImage(
                      imageUrl: uri,
                      fit: BoxFit.contain,
                    )
                  : Image.file(
                      File(uri),
                      fit: BoxFit.contain,
                    ),
            ),
          ),
        ),
        caption != null
            ? Padding(
                padding: theme.messagePadding,
                child: TextContainer(
                  text: caption!,
                  style: author.id == loggedInUser.id
                      ? theme.outwardMessageTextStyle
                      : theme.inwardMessageTextStyle,
                  linkStyle: theme.urlTextStyle,
                ),
              )
            : Container(),
      ],
    );
    return MessageContainer(
      parentContext: ctx,
      message: this,
      theme: theme,
      showUserAvatar: showUserAvatar,
      showMessageStatus: showMessageStatus,
      showUsername: showUsername,
      user: loggedInUser,
      child: returnValue,
      detailsLocation: authorDetailsLocation,
    );
  }
}
