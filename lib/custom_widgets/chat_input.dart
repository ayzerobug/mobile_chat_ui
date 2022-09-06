import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/fluent.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/ph.dart';

class ChatInput extends StatelessWidget {
  const ChatInput({Key? key}) : super(key: key);
  final double iconsSpacing = 10.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 20, 5, 10),
      child: Row(
        children: [
          const Iconify(
            Fluent.attach_16_filled,
            size: 30,
            color: Colors.white,
          ),
          SizedBox(
            width: iconsSpacing,
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xff373E4E),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                  bottomLeft: Radius.circular(50),
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: const [
                  Expanded(
                    child: TextField(
                      minLines: 1,
                      maxLines: 20,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(255, 190, 190, 190),
                        ),
                        hintText: "Type message here ...",
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 12.0),
                    child: Iconify(
                      Ic.outline_emoji_emotions,
                      size: 22,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            width: iconsSpacing,
          ),
          const Iconify(
            Ph.microphone,
            size: 30,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
