import 'package:flutter/material.dart';

import '../../utils/themes/chat_theme.dart';

class MessageStatus extends StatelessWidget {
  const MessageStatus(
    this.status, {
    Key? key,
  }) : super(key: key);
  final int status;

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case 0:
        return Container();
      case 1:
        return _statusWidget(Colors.grey, 8);
      case 2:
        return _statusWidget(Colors.blue.shade900, 8);
      default:
        return Container();
    }
  }
}

Widget _statusWidget(Color color, double size) {
  return Padding(
    padding: const EdgeInsets.only(top: 2.0, right: 8),
    child: Row(
      children: [
        Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 2,
        ),
        Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
      ],
    ),
  );
}

Widget buildMessageStatus(int status, ChatTheme theme) {
  switch (status) {
    case 1:
      return MessageStatus(status);
    case 2:
      return MessageStatus(status);
    default:
      return theme.sendingFailedIcon;
  }
}
