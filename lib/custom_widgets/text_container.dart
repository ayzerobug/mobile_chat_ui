import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

class TextContainer extends StatelessWidget {
  const TextContainer(
      {Key? key,
      required this.text,
      required this.style,
      required this.linkStyle})
      : super(key: key);
  final String text;
  final TextStyle style;
  final TextStyle linkStyle;
  @override
  Widget build(BuildContext context) {
    return Linkify(
      onOpen: (link) async {
        if (await canLaunchUrl(Uri.parse(link.url))) {
          await launchUrl(Uri.parse(link.url));
        } else {
          throw 'Could not launch $link';
        }
      },
      text: text,
      style: style,
      linkStyle: linkStyle,
    );
  }
}
