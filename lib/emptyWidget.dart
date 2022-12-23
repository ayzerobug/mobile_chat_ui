import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "No message in this chat yet",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontFamily: 'Satoshi',
        ),
      ),
    );
  }
}
