import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/carbon.dart';
import 'package:iconify_flutter/icons/eva.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/ph.dart';

import '../models/messages/message.dart';
import '../models/messages/types.dart';
import '../models/user.dart';

class ChatInput extends StatefulWidget {
  const ChatInput({Key? key, this.onSend, this.user, this.padding})
      : super(key: key);

  final void Function(Message message)? onSend;
  final User? user;
  final EdgeInsetsGeometry? padding;

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  final double iconsSpacing = 10.0;

  final TextEditingController textController = TextEditingController();
  bool hasData = false;

  onSendClick() {
    Message message = TextMessage(
        author:
            widget.user ?? User(id: "0de4krd0sas-49iecxo203rji", name: 'Demo'),
        text: textController.text,
        time: "now",
        stage: 1);
    widget.onSend!(message);
    setState(() {
      textController.clear();
      hasData = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? const EdgeInsets.fromLTRB(5, 20, 5, 10),
      child: Row(
        children: [
          const Iconify(
            Eva.attach_outline,
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
                children: [
                  Expanded(
                    child: TextField(
                      controller: textController,
                      onChanged: (value) {
                        setState(() {
                          if (value != "" && value.isNotEmpty) {
                            hasData = true;
                          } else {
                            hasData = false;
                          }
                        });
                      },
                      cursorColor: const Color(0xff705cff),
                      minLines: 1,
                      maxLines: 20,
                      decoration: const InputDecoration(
                        hintStyle: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 190, 190, 190),
                        ),
                        hintText: "Type message here ...",
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 12.0),
                    child: Iconify(
                      Ic.outline_emoji_emotions,
                      size: 22,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: iconsSpacing,
          ),
          hasData
              ? InkWell(
                  onTap: onSendClick,
                  child: const Iconify(
                    Carbon.send_alt,
                    size: 30,
                    color: Colors.white,
                  ),
                )
              : const Iconify(
                  Ph.microphone,
                  size: 30,
                  color: Colors.white,
                ),
        ],
      ),
    );
  }
}
