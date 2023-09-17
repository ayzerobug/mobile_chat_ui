import 'package:audio_wave/audio_wave.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ic.dart';

import '../../../widgets/containers/message_container.dart';
import '../../../../utils/author_details_location.dart';
import '../../../../utils/chat_theme.dart';
import '../../user.dart';
import 'message.dart';

class AudioMessage extends Message {
  AudioMessage({
    required super.author,
    required super.time,
    super.stage,
  });

  @override
  Widget builder(
      BuildContext ctx,
      bool showUserAvatar,
      bool showMessageStatus,
      bool showUsername,
      User loggedInUser,
      ChatTheme theme,
      AuthorDetailsLocation authorDetailsLocation) {
    Widget returnValue = Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          Iconify(
            Ic.round_play_arrow,
            color: theme.primaryColor,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: AudioWave(
              height: 30,
              width: 160,
              spacing: 5,
              alignment: 'center',
              animationLoop: 2,
              beatRate: const Duration(milliseconds: 50),
              bars: [
                AudioWaveBar(heightFactor: 0.1, color: theme.audioWaveColor),
                AudioWaveBar(heightFactor: 0.3, color: theme.audioWaveColor),
                AudioWaveBar(heightFactor: 0.7, color: theme.audioWaveColor),
                AudioWaveBar(heightFactor: 0.4, color: theme.audioWaveColor),
                AudioWaveBar(heightFactor: 1, color: theme.audioWaveColor),
                AudioWaveBar(heightFactor: 0.9, color: theme.audioWaveColor),
                AudioWaveBar(heightFactor: 0.8, color: theme.audioWaveColor),
                AudioWaveBar(heightFactor: 0.7, color: theme.audioWaveColor),
                AudioWaveBar(heightFactor: 0.4, color: theme.audioWaveColor),
                AudioWaveBar(heightFactor: 0.2, color: theme.audioWaveColor),
                AudioWaveBar(heightFactor: 0.1, color: theme.audioWaveColor),
                AudioWaveBar(heightFactor: 0.3, color: theme.audioWaveColor),
                AudioWaveBar(heightFactor: 0.7, color: theme.audioWaveColor),
                AudioWaveBar(heightFactor: 0.4, color: theme.audioWaveColor),
                AudioWaveBar(heightFactor: 0.2, color: theme.audioWaveColor),
                AudioWaveBar(heightFactor: 0.1, color: theme.audioWaveColor),
                AudioWaveBar(heightFactor: 0.3, color: theme.audioWaveColor),
                AudioWaveBar(heightFactor: 0.7, color: theme.audioWaveColor),
                AudioWaveBar(heightFactor: 0.4, color: theme.audioWaveColor),
                AudioWaveBar(heightFactor: 0.2, color: theme.audioWaveColor),
              ],
            ),
          )
        ],
      ),
    );
    return MessageContainer(
      parentContext: ctx,
      message: this,
      theme: theme,
      showUserAvatar: showUserAvatar,
      showMessageStatus: showMessageStatus,
      showUsername: showUsername,
      user: loggedInUser,
      detailsLocation: authorDetailsLocation,
      child: returnValue,
    );
  }
}
