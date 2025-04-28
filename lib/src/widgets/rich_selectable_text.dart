import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class RichSelectableText extends StatelessWidget {
  final String text;
  final TextStyle? baseStyle;
  final TextStyle? boldStyle;
  final TextStyle? linkStyle;

  const RichSelectableText({
    Key? key,
    required this.text,
    this.baseStyle,
    this.boldStyle,
    this.linkStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SelectableText.rich(
      TextSpan(children: _parseText(text)),
      toolbarOptions: ToolbarOptions(
        copy: true,
        selectAll: true,
      ),
    );
  }

  List<TextSpan> _parseText(String input) {
    final List<TextSpan> spans = [];
    final RegExp pattern = RegExp(
      r'(\*\*(.*?)\*\*)|(https?:\/\/[^\s]+)',
      multiLine: true,
    );

    final matches = pattern.allMatches(input);
    int currentIndex = 0;

    for (final match in matches) {
      if (match.start > currentIndex) {
        spans.add(TextSpan(
          text: input.substring(currentIndex, match.start),
          style: baseStyle,
        ));
      }

      final boldText = match.group(2);
      final link = match.group(3);

      if (boldText != null) {
        spans.add(TextSpan(
          text: boldText,
          style: boldStyle ?? baseStyle?.copyWith(fontWeight: FontWeight.bold),
        ));
      } else if (link != null) {
        spans.add(TextSpan(
          text: link,
          style: linkStyle ?? baseStyle?.copyWith(color: Colors.blue),
          recognizer: TapGestureRecognizer()
            ..onTap = () async {
              final uri = Uri.parse(link);
              if (await canLaunchUrl(uri)) {
                await launchUrl(uri, mode: LaunchMode.externalApplication);
              }
            },
        ));
      }

      currentIndex = match.end;
    }

    if (currentIndex < input.length) {
      spans.add(TextSpan(
        text: input.substring(currentIndex),
        style: baseStyle,
      ));
    }

    return spans;
  }
}
