import 'package:flutter/material.dart';

class MessageTheme {
  /// The background color for the chat widget.
  final Color? backgroundColor;

  /// The text input background color used for various elements in the chat.
  final Color? fixedWaveColor;

  final Color? liveWaveColor;

  /// The text style for inward (received) messages.
  final TextStyle? contentTextStyle;

  /// The text style for timestamps in messages.
  final TextStyle? timeTextStyle;

  /// The text style for URLs in messages.
  final TextStyle? urlTextStyle;

  /// The text style for URLs in messages.
  final TextStyle? boldTextStyle;

  /// The text style for the title in link previews.
  final TextStyle? linkPreviewTitleStyle;

  /// The text style for the text content in link previews.
  final TextStyle? linkPreviewTextStyle;

  /// The border radius for outward (sent) messages.
  final BorderRadiusGeometry? borderRadius;

  /// The border for outward (sent) messages.
  final Border? border;

  /// The padding around messages.
  final EdgeInsetsGeometry? padding;

  final EdgeInsetsGeometry? margin;

  /// The background color for inward (received) messages.
  final Color? backroundColor;

  /// The width of messages.
  final double? messageWidth;

  const MessageTheme({
    this.backgroundColor,
    this.fixedWaveColor,
    this.liveWaveColor,
    this.contentTextStyle,
    this.boldTextStyle,
    this.timeTextStyle,
    this.urlTextStyle,
    this.linkPreviewTitleStyle,
    this.linkPreviewTextStyle,
    this.borderRadius,
    this.border,
    this.padding,
    this.margin,
    this.backroundColor,
    this.messageWidth,
  });
}
