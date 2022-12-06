import 'package:audio_wave/audio_wave.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:iconify_flutter/icons/ion.dart';

import '../../custom_widgets/message_container.dart';
import '../../custom_widgets/text_container.dart';
import '../chat_theme.dart';
import '../user.dart';
import 'message.dart';

class ActionMessage extends Message {
  final String text;
  ActionMessage(
      {required super.author, required super.time, required this.text});

  @override
  Widget builder(BuildContext ctx, bool showUserAvatar, bool showMessageStatus,
      bool showUsername,
      User loggedInUser, ChatTheme theme) {
    return Padding(
      padding: theme.actionMessageMargin,
      child: Text(
        text,
        style: theme.actionMessageTextStyle,
        textAlign: TextAlign.center,
      ),
    );
  }
}

class AudioMessage extends Message {
  AudioMessage({
    required super.author,
    required super.time,
    super.stage,
  });

  @override
  Widget builder(BuildContext ctx, bool showUserAvatar, bool showMessageStatus,
      bool showUsername,
      User loggedInUser, ChatTheme theme) {
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
      child: returnValue,
    );
  }
}

class DocumentMessage extends Message {
  final String documentSize;
  final String documentFormat;
  final String documentName;
  DocumentMessage(
      {required super.author,
      required super.time,
      super.stage,
      required this.documentSize,
      required this.documentFormat,
      required this.documentName});

  @override
  Widget builder(BuildContext ctx, bool showUserAvatar, bool showMessageStatus,
      bool showUsername,
      User loggedInUser, ChatTheme theme) {
    Widget returnValue = Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xff171b1d),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Iconify(
                  Ion.document_text,
                  color: theme.primaryColor,
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    documentName,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                documentFormat,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
              Text(
                documentSize,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
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
      child: returnValue,
    );
  }
}

class ImageMessage extends Message {
  String? caption;
  final String imageUrl;
  ImageMessage(
      {required super.author,
      required super.time,
      super.stage,
      required this.imageUrl,
      this.caption});

  @override
  Widget builder(BuildContext ctx, bool showUserAvatar, bool showMessageStatus,
      bool showUsername,
      User loggedInUser, ChatTheme theme) {
    Widget returnValue = Column(
      children: [
        IntrinsicHeight(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(ctx).size.height * 0.5,
            ),
            child: ClipRRect(
              borderRadius: theme.imageBorderRadius ??
                  const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        caption != null
            ? Padding(
                padding: theme.messagePadding,
                child: TextContainer(
                  text: caption!,
                  style: author.id == loggedInUser.id
                      ? theme.outwardMessageTextStyle
                      : theme.inwardMessageTextStyle,
                  linkStyle: theme.urlTextStyle,
                ),
              )
            : Container(),
      ],
    );
    return MessageContainer(
      parentContext: ctx,
      message: this,
      theme: theme,
      showUserAvatar: showUserAvatar,
      showMessageStatus: showMessageStatus,
      showUsername: showUsername,
      user: loggedInUser,
      child: returnValue,
    );
  }
}

class TextMessage extends Message {
  final String text;
  TextMessage(
      {required super.author,
      required super.time,
      super.stage = 0,
      required this.text});

  @override
  Widget builder(BuildContext ctx, bool showUserAvatar, bool showMessageStatus,
      bool showUsername,
      User loggedInUser, ChatTheme theme) {
    return MessageContainer(
      parentContext: ctx,
      message: this,
      theme: theme,
      showUserAvatar: showUserAvatar,
      showMessageStatus: showMessageStatus,
      showUsername: showUsername,
      user: loggedInUser,
      child: Padding(
        padding: theme.messagePadding,
        child: TextContainer(
          text: text,
          style: author.id == loggedInUser.id
              ? theme.outwardMessageTextStyle
              : theme.inwardMessageTextStyle,
          linkStyle: theme.urlTextStyle,
        ),
      ),
    );
  }
}

class TimeStampMessage extends Message {
  final String displayTime;
  TimeStampMessage({required super.author, required this.displayTime});

  @override
  Widget builder(BuildContext ctx, bool showUserAvatar, bool showMessageStatus,
      bool showUsername,
      User loggedInUser, ChatTheme theme) {
    return Text(
      displayTime,
      style: theme.timestampTextStyle,
      textAlign: TextAlign.center,
    );
  }
}
