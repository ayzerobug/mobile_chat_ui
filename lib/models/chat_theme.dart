import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/mdi.dart';

import '../custom_widgets/status_builder.dart';

abstract class ChatTheme {
  ChatTheme({
    this.backgroundColor,
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
    required this.urlTextStyle,
    required this.actionMessageTextStyle,
    required this.linkPreviewTitleStyle,
    required this.linkPreviewTextStyle,
    required this.timestampTextStyle,
    required this.inwardMessageTextStyle,
    required this.outwardMessageTextStyle,
    required this.usernameTextStyle,
    required this.avatarTextStyle,
    required this.messagePadding,
    required this.actionMessageMargin,
    required this.inwardMessageBorderRadius,
    required this.outwardMessageBorderRadius,
    required this.inwardMessageBackgroundColor,
    required this.outwardMessageBackgroundColor,
    required this.messageWidth,
    required this.audioWaveColor,
    required this.messageMargin,
    required this.defaultUserColor,
    required this.userAvatarRadius,
    required this.verificationBadge,
  });

  final Color? backgroundColor;
  final DecorationImage? backgroundImage;
  final Color? userStatusColor;
  final Widget verificationBadge;
  final BorderRadius? imageBorderRadius;
  final Color primaryColor;

  final Widget sendingFailedIcon;

  final Widget sentIcon;

  final Widget seenIcon;

  final TextStyle inwardMessageTextStyle;
  final TextStyle outwardMessageTextStyle;
  final TextStyle timeTextStyle;
  final TextStyle urlTextStyle;
  final TextStyle linkPreviewTitleStyle;
  final TextStyle linkPreviewTextStyle;
  final TextStyle timestampTextStyle;
  final Color audioWaveColor;
  final Color defaultUserColor;
  final double userAvatarRadius;

  final TextStyle avatarTextStyle;

  final BorderRadiusGeometry? outwardMessageBorderRadius;

  final BorderRadiusGeometry? inwardMessageBorderRadius;

  final TextStyle usernameTextStyle;
  final TextStyle actionMessageTextStyle;

  final EdgeInsetsGeometry messagePadding;

  final EdgeInsetsGeometry usernamePadding;

  final EdgeInsetsGeometry bodyPadding;

  final EdgeInsetsGeometry messageMargin;
  final EdgeInsetsGeometry actionMessageMargin;

  final Color inwardMessageBackgroundColor;

  final Color outwardMessageBackgroundColor;

  final double messageWidth;
}

class DefaultChatTheme extends ChatTheme {
  DefaultChatTheme(
      {super.imageBorderRadius,
      // super.backgroundColor = const Color(0xff1B202D),
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
      super.urlTextStyle = const TextStyle(
        color: Colors.blue,
      ),
      super.actionMessageTextStyle = const TextStyle(
        fontSize: 14,
        color: Color.fromARGB(255, 114, 114, 114),
        fontWeight: FontWeight.w500,
      ),
      super.linkPreviewTitleStyle =
          const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      super.linkPreviewTextStyle = const TextStyle(
        color: Color.fromARGB(255, 182, 182, 182),
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
      super.inwardMessageTextStyle = const TextStyle(
        color: Color.fromARGB(255, 225, 225, 225),
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      super.timeTextStyle = const TextStyle(
        color: Colors.white,
        fontSize: 12,
      ),
      super.outwardMessageTextStyle = const TextStyle(
        color: Color.fromARGB(255, 225, 225, 225),
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      super.audioWaveColor = const Color.fromARGB(255, 213, 213, 213),
      super.usernameTextStyle = const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
      super.avatarTextStyle = const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 22,
          fontFamily: 'Satoshi'),
      super.messagePadding = const EdgeInsets.all(10.0),
      super.inwardMessageBorderRadius = const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
        bottomRight: Radius.circular(20),
        bottomLeft: Radius.circular(5),
      ),
      super.outwardMessageBorderRadius = const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
        bottomRight: Radius.circular(5),
        bottomLeft: Radius.circular(20),
      ),
      super.primaryColor = Colors.blue,
      super.inwardMessageBackgroundColor = const Color(0xff373E4E),
      super.outwardMessageBackgroundColor = const Color(0xff7A8194),
      super.messageWidth = 0.7,
      super.messageMargin = const EdgeInsets.only(top: 20),
      super.actionMessageMargin =
          const EdgeInsets.only(top: 15, left: 20, right: 20),
      super.defaultUserColor = Colors.blue,
      super.userAvatarRadius = 10.0});
}
