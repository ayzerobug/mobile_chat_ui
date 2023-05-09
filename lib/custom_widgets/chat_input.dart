import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/carbon.dart';
import 'package:iconify_flutter/icons/eva.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:image_picker/image_picker.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';

import '../models/messages/types.dart';
import '../models/user.dart';

class ChatInput extends StatefulWidget {
  ChatInput(
      {Key? key,
      this.onSend,
      required this.user,
      required this.padding,
      this.attachBtnClicked,
      this.onFileSelected,
      this.cursorColor})
      : super(key: key);

  final void Function(TextMessage message)? onSend;
  final void Function(ImageMessage message, XFile image)? onFileSelected;
  final void Function()? attachBtnClicked;
  final User user;
  final EdgeInsetsGeometry padding;
  Color? cursorColor;

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  final TextEditingController textController = TextEditingController();
  final double iconsSpacing = 10.0;
  bool hasData = false;
  bool showEmoji = false;
  late FocusNode myFocusNode;

  void onSendClick() {
    if (hasData) {
      TextMessage message = TextMessage(
          author: widget.user,
          text: textController.text,
          time: "now",
          stage: 1);
      widget.onSend!(message);
      setState(() {
        textController.clear();
        hasData = false;
      });
    }
  }

  void handleImageSelection() async {
    XFile? result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );
    if (result != null) {
      final message = ImageMessage(
        author: widget.user,
        time: "now",
        stage: 0,
        uri: result.path,
      );
      if (widget.onFileSelected != null) {
        widget.onFileSelected!(message, result);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    myFocusNode.dispose();
  }

  void hideEmoji() {
    if (showEmoji) {
      setState(() {
        showEmoji = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (showEmoji) {
          hideEmoji();
          return false;
        }
        return true;
      },
      child: IntrinsicHeight(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 20, 5, 10),
              child: Row(
                children: [
                  InkWell(
                    onTap: handleImageSelection,
                    child: const Iconify(
                      Eva.attach_outline,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
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
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: TextField(
                              controller: textController,
                              focusNode: myFocusNode,
                              onChanged: (value) {
                                setState(() {
                                  if (value != "" && value.isNotEmpty) {
                                    hasData = true;
                                  } else {
                                    hasData = false;
                                  }
                                });
                              },
                              onTap: () {
                                setState(() {
                                  showEmoji = false;
                                });
                              },
                              cursorColor: widget.cursorColor,
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
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: showEmoji
                                ? InkWell(
                                    onTap: () {
                                      setState(() {
                                        showEmoji = false;
                                      });
                                      myFocusNode.requestFocus();
                                    },
                                    child: const Iconify(
                                      Carbon.string_text,
                                      size: 22,
                                      color: Colors.white,
                                    ),
                                  )
                                : InkWell(
                                    onTap: () async {
                                      myFocusNode.unfocus();
                                      await Future.delayed(
                                          const Duration(milliseconds: 500),
                                          () {
                                        setState(() {
                                          showEmoji = true;
                                        });
                                      });
                                    },
                                    child: const Iconify(
                                      Ic.outline_emoji_emotions,
                                      size: 22,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
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
                      : const SizedBox(),
                ],
              ),
            ),
            showEmoji
                ? SizedBox(
                    height: MediaQuery.of(context).size.height * 0.35,
                    child: EmojiPicker(
                      textEditingController: textController,
                      onEmojiSelected: (categoery, emoji) {
                        setState(() {
                          hasData = true;
                        });
                      },
                      config: const Config(
                        columns: 7,
                        emojiSizeMax: 24,
                        verticalSpacing: 0,
                        horizontalSpacing: 0,
                        gridPadding: EdgeInsets.zero,
                        initCategory: Category.RECENT,
                        bgColor: Colors.transparent,
                        indicatorColor: Color(0xff705cff),
                        iconColor: Colors.grey,
                        iconColorSelected: Color(0xff705cff),
                        backspaceColor: Color(0xff705cff),
                        skinToneDialogBgColor: Colors.white,
                        skinToneIndicatorColor: Colors.grey,
                        enableSkinTones: true,
                        showRecentsTab: true,
                        recentsLimit: 28,
                        replaceEmojiOnLimitExceed: false,
                        noRecents: Text(
                          'No Recents',
                          style: TextStyle(fontSize: 20, color: Colors.black26),
                          textAlign: TextAlign.center,
                        ),
                        loadingIndicator: SizedBox.shrink(),
                        tabIndicatorAnimDuration: kTabScrollDuration,
                        categoryIcons: CategoryIcons(),
                        buttonMode: ButtonMode.MATERIAL,
                        checkPlatformCompatibility: true,
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
