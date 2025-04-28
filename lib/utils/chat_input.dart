import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/carbon.dart';
import 'package:iconify_flutter/icons/eva.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import 'package:image_picker/image_picker.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';

import '../src/widgets/stacked_images.dart';
import 'themes/chat_theme.dart';
import 'message.dart';
import '../src/models/user.dart';

class ChatInput extends StatefulWidget {
  const ChatInput({
    Key? key,
    this.onSend,
    required this.user,
    required this.padding,
    this.attachBtnClicked,
    this.canUseAudio = true,
    this.cursorColor,
    this.mediaSelector,
    this.imageSource = ImageSource.gallery,
    required this.theme,
  }) : super(key: key);

  final void Function(Message message)? onSend;
  final void Function()? attachBtnClicked;
  final User user;
  final EdgeInsetsGeometry padding;
  final Color? cursorColor;
  final ChatTheme theme;
  final bool canUseAudio;
  final Widget? mediaSelector;
  final ImageSource imageSource;

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  final textController = TextEditingController();
  final recorderController = RecorderController();
  final playerController = PlayerController();
  final focusNode = FocusNode();
  String? recordedFilePath;
  bool isPlaying = false;
  List<XFile> images = [];
  bool showEmoji = false;
  bool isRecording = false;

  bool get hasData =>
      textController.text.trim().isNotEmpty || images.isNotEmpty;

  final imagePicker = ImagePicker();

  @override
  void dispose() {
    recorderController.dispose();
    playerController.dispose();
    textController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  void _handleSend() {
    Message? message;

    if (recordedFilePath != null) {
      message = AudioMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        author: widget.user,
        audioPath: recordedFilePath!,
        time: "now",
        stage: 1,
      );
    } else if (images.isNotEmpty) {
      message = ImageMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        author: widget.user,
        caption: textController.text,
        uris: images.map((e) => e.path).toList(),
        time: "now",
        stage: 1,
      );
    } else if (hasData) {
      message = TextMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        author: widget.user,
        text: textController.text,
        time: "now",
        stage: 1,
      );
    }

    if (message == null) return;

    widget.onSend?.call(message);

    focusNode.unfocus();
    setState(() {
      textController.clear();
      images.clear();
      recordedFilePath = null;
      isPlaying = false;
    });
  }

  Future<void> _handleImagePick() async {
    final result = await imagePicker.pickImage(
        source: widget.imageSource, imageQuality: 50);
    if (result != null) {
      setState(() => images.add(result));
    }
  }

  void _startRecording() async {
    if (recorderController.hasPermission ||
        await recorderController.checkPermission()) {
      await recorderController.record(
        androidEncoder: AndroidEncoder.aac,
        androidOutputFormat: AndroidOutputFormat.mpeg4,
        iosEncoder: IosEncoder.kAudioFormatMPEG4AAC,
      );
      setState(() => isRecording = true);
    }
  }

  void _stopRecording() async {
    recordedFilePath = await recorderController.stop();
    if (recordedFilePath != null) {
      playerController.preparePlayer(path: recordedFilePath!);
    }
    setState(() => isRecording = false);
  }

  void _toggleEmoji() async {
    if (showEmoji) {
      focusNode.requestFocus();
    } else {
      focusNode.unfocus();
      await Future.delayed(const Duration(milliseconds: 300));
    }

    setState(() => showEmoji = !showEmoji);
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (images.isNotEmpty)
          StackedImages(
            imageUris: images.map((e) => e.path).toList(),
            imageSize: 50,
            overlap: 2,
          ),
        if (recordedFilePath != null && !isRecording)
          Row(
            children: [
              IconButton(
                icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                onPressed: () async {
                  if (isPlaying) {
                    await playerController.pausePlayer();
                    setState(() => isPlaying = false);
                  } else {
                    await playerController.startPlayer();
                    setState(() => isPlaying = false);
                  }
                  setState(() => isPlaying = !isPlaying);
                },
              ),
              Expanded(
                child: AudioFileWaveforms(
                  size: Size(
                    MediaQuery.of(context).size.width,
                    MediaQuery.of(context).size.height * 0.05,
                  ),
                  playerController: playerController,
                  enableSeekGesture: true,
                  waveformType: WaveformType.fitWidth,
                  playerWaveStyle: PlayerWaveStyle(
                    fixedWaveColor: theme.primaryColor.withValues(alpha: 0.4),
                    liveWaveColor: theme.primaryColor,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    recordedFilePath = null;
                    isPlaying = false;
                  });
                },
              )
            ],
          ),
        if (isRecording)
          AudioWaveforms(
            enableGesture: false,
            size: Size(
              MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height * 0.05,
            ),
            recorderController: recorderController,
            waveStyle: WaveStyle(
              waveColor: theme.primaryColor,
              extendWaveform: true,
              showMiddleLine: false,
            ),
          ),
        Padding(
          padding: const EdgeInsets.fromLTRB(5, 5, 5, 10),
          child: Row(
            children: [
              widget.mediaSelector != null
                  ? InkWell(
                      child: widget.mediaSelector,
                      onTap: _handleImagePick,
                    )
                  : _buildIconBtn(Eva.attach_outline, _handleImagePick),
              const SizedBox(width: 5),
              _buildTextField(theme),
              const SizedBox(width: 5),
              (hasData || recordedFilePath != null)
                  ? _buildIconBtn(Carbon.send_alt, _handleSend)
                  : widget.canUseAudio
                      ? GestureDetector(
                          onLongPressStart: (_) => _startRecording(),
                          onLongPressEnd: (_) => _stopRecording(),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: isRecording
                                  ? [
                                      BoxShadow(
                                        color:
                                            Colors.red.withValues(alpha: 0.6),
                                        blurRadius: 12,
                                        spreadRadius: 2,
                                      )
                                    ]
                                  : [],
                            ),
                            child: Iconify(
                              MaterialSymbols.mic_outline_rounded,
                              size: 30,
                              color: widget.theme.iconColor ??
                                  widget.theme.primaryColor,
                            ),
                          ),
                        )
                      : SizedBox.shrink(),
            ],
          ),
        ),
        if (showEmoji) _buildEmojiPicker(),
      ],
    );
  }

  Widget _buildIconBtn(String icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Iconify(
        icon,
        size: 30,
        color: widget.theme.iconColor,
      ),
    );
  }

  Widget _buildTextField(ChatTheme theme) {
    final heightFactor = MediaQuery.of(context).size.height * 0.015;

    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: theme.inputBackgroundColor ?? const Color(0xff373E4E),
          borderRadius: BorderRadius.circular(50),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: textController,
                focusNode: focusNode,
                onChanged: (_) => setState(() {}),
                onTap: () => setState(() => showEmoji = false),
                cursorColor: widget.cursorColor,
                minLines: 1,
                maxLines: 20,
                decoration: InputDecoration(
                  hintText: "Type message here ...",
                  hintStyle: TextStyle(fontSize: heightFactor),
                  border: InputBorder.none,
                ),
                style: TextStyle(fontSize: heightFactor),
              ),
            ),
            InkWell(
              onTap: _toggleEmoji,
              child: Iconify(
                showEmoji ? Carbon.string_text : Ic.outline_emoji_emotions,
                size: 22,
                color: widget.theme.iconColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmojiPicker() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.35,
      child: EmojiPicker(
        textEditingController: textController,
        onEmojiSelected: (_, __) => setState(() {}),
        config: Config(
          height: 256,
          checkPlatformCompatibility: true,
          emojiViewConfig: EmojiViewConfig(
            // Issue: https://github.com/flutter/flutter/issues/28894
            emojiSizeMax:
                28 * (defaultTargetPlatform == TargetPlatform.iOS ? 1.20 : 1.0),
          ),
          viewOrderConfig: const ViewOrderConfig(
            top: EmojiPickerItem.categoryBar,
            middle: EmojiPickerItem.emojiView,
            bottom: EmojiPickerItem.searchBar,
          ),
          skinToneConfig: const SkinToneConfig(),
          categoryViewConfig: const CategoryViewConfig(),
          bottomActionBarConfig: const BottomActionBarConfig(),
          searchViewConfig: const SearchViewConfig(),
        ),
      ),
    );
  }
}
