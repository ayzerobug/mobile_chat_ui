import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile_chat_ui/mobile_chat_ui.dart';
import 'package:path_provider/path_provider.dart';

import '../../../widgets/containers/message_container.dart';

class AudioMessage extends Message {
  String audioPath;

  AudioMessage({
    required super.author,
    required super.time,
    required super.id,
    required this.audioPath,
    super.stage,
    super.theme,
  });

  final PlayerController playerController = PlayerController();

  @override
  Widget builder(
      BuildContext ctx,
      bool showUserAvatar,
      bool showMessageStatus,
      bool showUsername,
      User loggedInUser,
      ChatTheme chatTheme,
      AuthorDetailsLocation authorDetailsLocation) {
    return MessageContainer(
      parentContext: ctx,
      message: this,
      chatTheme: chatTheme,
      showUserAvatar: showUserAvatar,
      showMessageStatus: showMessageStatus,
      showUsername: showUsername,
      user: loggedInUser,
      detailsLocation: authorDetailsLocation,
      child: AudioMessageBuilder(
        audioUrl: audioPath,
        chatTheme: chatTheme,
        messageId: id,
        messageTheme: theme,
        chatMessageTheme: author.id == loggedInUser.id
            ? chatTheme.outwardMessageTheme
            : chatTheme.inwardMessageTheme,
      ),
    );
  }
}

class AudioMessageBuilder extends StatefulWidget {
  final String audioUrl;
  final ChatTheme chatTheme;
  final MessageTheme? messageTheme;
  final MessageTheme? chatMessageTheme;
  final String messageId;
  const AudioMessageBuilder(
      {super.key,
      required this.audioUrl,
      required this.chatTheme,
      required this.messageId,
      required this.messageTheme,
      required this.chatMessageTheme});

  @override
  State<AudioMessageBuilder> createState() => _AudioMessageBuilderState();
}

class _AudioMessageBuilderState extends State<AudioMessageBuilder> {
  final PlayerController playerController = PlayerController();
  bool isPlaying = false;

  @override
  void initState() {
    preparePlayerController();
    super.initState();
  }

  bool isReady = false;

  Future<void> preparePlayerController() async {
    try {
      final localPath = await downloadAudioToFile(widget.audioUrl);
      await playerController.preparePlayer(
        path: localPath,
        shouldExtractWaveform: true,
      );
      playerController.setFinishMode(finishMode: FinishMode.stop);
      setState(() {
        isReady = true;
      });
    } catch (e) {
      debugPrint("Audio download/prep error: $e");
    }
  }

  Future<String> downloadAudioToFile(String url) async {
    final dir = await getTemporaryDirectory();
    final filePath = '${dir.path}/chat-audio-${widget.messageId}.m4a';

    final response = await Dio().download(url, filePath);

    if (response.statusCode == 200) {
      return filePath;
    } else {
      throw Exception('Failed to download audio');
    }
  }

  @override
  void dispose() {
    playerController.dispose();
    super.dispose();
  }

  void togglePlayback() async {
    if (isPlaying) {
      await playerController.stopPlayer();
    } else {
      await playerController.startPlayer(forceRefresh: true);
    }
    setState(() => isPlaying = !isPlaying);
  }

  @override
  Widget build(BuildContext context) {
    if (!isReady) {
      return const SizedBox(
        height: 50,
        child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
      );
    }

    return Row(
      children: [
        IconButton(
          icon: Icon(
            isPlaying ? Icons.stop : Icons.play_arrow,
            color: Colors.white,
          ),
          onPressed: togglePlayback,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: AudioFileWaveforms(
            playerController: playerController,
            size: Size(MediaQuery.of(context).size.width * 0.45, 20),
            waveformType: WaveformType.fitWidth,
            enableSeekGesture: true,
            playerWaveStyle: PlayerWaveStyle(
              fixedWaveColor: widget.messageTheme?.fixedWaveColor ??
                  widget.chatMessageTheme?.fixedWaveColor ??
                  Colors.grey,
              liveWaveColor: widget.messageTheme?.fixedWaveColor ??
                  widget.chatMessageTheme?.liveWaveColor ??
                  Colors.white,
              spacing: 6,
            ),
          ),
        ),
      ],
    );
  }
}
