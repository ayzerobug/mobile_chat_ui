import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/mdi.dart';

import '../../src/widgets/status_builder.dart';
import 'message_theme.dart';

abstract class ChatTheme {
  ChatTheme(
      {this.backgroundColor,
      this.backgroundImage,
      required this.imageBorderRadius,
      required this.userStatusColor,
      required this.primaryColor,
      required this.seenIcon,
      required this.sentIcon,
      required this.sendingFailedIcon,
      required this.usernamePadding,
      required this.bodyPadding,
      required this.timeTextStyle,
      required this.timestampTextStyle,
      required this.usernameTextStyle,
      required this.avatarTextStyle,
      required this.defaultUserColor,
      required this.userAvatarRadius,
      required this.verificationBadge,
      this.inputBackgroundColor,
      this.iconColor,
      this.inwardMessageTheme,
      this.outwardMessageTheme,
      this.actionMessageTheme});

  /// The background color for the chat widget.
  final Color? backgroundColor;

  /// The background image for the chat widget.
  final DecorationImage? backgroundImage;

  /// The color for the user's status indicator.
  final Color? userStatusColor;

  /// A widget to display a verification badge for the user.
  final Widget verificationBadge;

  /// The border radius for user images.
  final BorderRadius? imageBorderRadius;

  /// The primary color used for various elements in the chat.
  final Color primaryColor;

  /// The primary color used for various elements in the chat.
  final Color? iconColor;

  /// The text input background color used for various elements in the chat.
  final Color? inputBackgroundColor;

  /// A widget representing an icon for a sending message that failed.
  final Widget sendingFailedIcon;

  /// A widget representing an icon for a sent message.
  final Widget sentIcon;

  /// A widget representing an icon for a seen message.
  final Widget seenIcon;

  /// The text style for timestamps in messages.
  final TextStyle timeTextStyle;

  /// The text style for message timestamps.
  final TextStyle timestampTextStyle;

  /// The default color for user avatars.
  final Color defaultUserColor;

  /// The radius of user avatars.
  final double userAvatarRadius;

  /// The text style for user avatars.
  final TextStyle avatarTextStyle;

  /// The text style for usernames.
  final TextStyle usernameTextStyle;

  /// The padding around usernames.
  final EdgeInsetsGeometry usernamePadding;

  /// The padding around the chat body.
  final EdgeInsetsGeometry bodyPadding;

  final MessageTheme? inwardMessageTheme;
  final MessageTheme? outwardMessageTheme;
  final MessageTheme? actionMessageTheme;
}

class DefaultChatTheme extends ChatTheme {
  DefaultChatTheme({
    super.imageBorderRadius,
    super.backgroundColor,
    super.backgroundImage = const DecorationImage(
      image: CachedNetworkImageProvider(
          "https://i.pinimg.com/736x/85/ec/df/85ecdf1c3611ecc9b7fa85282d9526e0.jpg"),
      fit: BoxFit.cover,
    ),
    super.userStatusColor = Colors.green,
    super.verificationBadge = const Iconify(
      Ic.sharp_verified,
      color: Colors.green,
      size: 14,
    ),
    super.timestampTextStyle = const TextStyle(
      fontSize: 14,
      color: Color.fromARGB(255, 114, 114, 114),
      fontWeight: FontWeight.w500,
    ),
    super.inwardMessageTheme = const MessageTheme(
      linkPreviewTitleStyle:
          TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      linkPreviewTextStyle: TextStyle(
        color: Color.fromARGB(255, 182, 182, 182),
      ),
      contentTextStyle: TextStyle(
        color: Color.fromARGB(255, 225, 225, 225),
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
        bottomRight: Radius.circular(20),
        bottomLeft: Radius.circular(5),
      ),
      backgroundColor: Color(0xff373E4E),
      messageWidth: 0.7,
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.only(top: 20),
      urlTextStyle: TextStyle(color: Colors.blue),
    ),
    super.outwardMessageTheme = const MessageTheme(
        linkPreviewTitleStyle:
            TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        linkPreviewTextStyle:
            TextStyle(color: Color.fromARGB(255, 182, 182, 182)),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(5),
          bottomLeft: Radius.circular(20),
        ),
        contentTextStyle: TextStyle(
          color: Color.fromARGB(255, 225, 225, 225),
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        backgroundColor: Color(0xff7A8194),
        messageWidth: 0.7,
        padding: EdgeInsets.all(10.0),
        margin: EdgeInsets.only(top: 20)),
    super.actionMessageTheme = const MessageTheme(
      contentTextStyle: TextStyle(
        fontSize: 14,
        color: Color.fromARGB(255, 114, 114, 114),
        fontWeight: FontWeight.w500,
      ),
      backgroundColor: null,
      margin: EdgeInsets.only(top: 15, left: 20, right: 20),
      urlTextStyle: TextStyle(color: Colors.blue),
    ),
    super.bodyPadding =
        const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    super.usernamePadding = const EdgeInsets.all(2),
    super.seenIcon = const MessageStatus(2),
    super.sentIcon = const MessageStatus(1),
    super.sendingFailedIcon = const Iconify(
      Mdi.alert_circle_outline,
      color: Colors.red,
    ),
    super.timeTextStyle = const TextStyle(
      color: Colors.white,
      fontSize: 12,
    ),
    super.usernameTextStyle = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
    ),
    super.avatarTextStyle = const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 22,
        fontFamily: 'Satoshi'),
    super.defaultUserColor = Colors.blue,
    super.userAvatarRadius = 10.0,
    super.iconColor = Colors.white,
    super.inputBackgroundColor,
    required super.primaryColor,
  });
}
