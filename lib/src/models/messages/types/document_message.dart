import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ion.dart';

import '../../../widgets/containers/message_container.dart';
import '../../../../utils/author_details_location.dart';
import '../../../../utils/chat_theme.dart';
import '../../user.dart';
import 'message.dart';

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
  Widget builder(
      BuildContext ctx,
      bool showUserAvatar,
      bool showMessageStatus,
      bool showUsername,
      User loggedInUser,
      ChatTheme theme,
      AuthorDetailsLocation authorDetailsLocation) {
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
      detailsLocation: authorDetailsLocation,
    );
  }
}
