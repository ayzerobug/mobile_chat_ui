import 'package:flutter/material.dart';

import '../rich_selectable_text.dart';

class TextContainer extends StatelessWidget {
  const TextContainer({
    Key? key,
    required this.text,
    required this.textStyle,
    required this.boldTextStyle,
    required this.linkTextStyle,
  }) : super(key: key);
  final String text;
  final TextStyle? textStyle;
  final TextStyle? boldTextStyle;
  final TextStyle? linkTextStyle;
  @override
  Widget build(BuildContext context) {
    return RichSelectableText(
      text: text,
      baseStyle: textStyle,
      boldStyle: boldTextStyle,
      linkStyle: linkTextStyle,
    );
    // return SelectableLinkify(
    //   onOpen: (link) async {
    //     if (!await launchUrl(Uri.parse(link.url))) {
    //       throw Exception('Could not launch ${link.url}');
    //     }
    //   },
    //   text: text,
    //   style: style,
    //   linkStyle: linkStyle,
    // );
  }
}
