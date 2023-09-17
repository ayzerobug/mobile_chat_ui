import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mobile_chat_ui/utils/message.dart';
import 'package:mobile_chat_ui/utils/user.dart';

User loggedInUser = User(
  id: "Putras",
  name: "Putra Silas",
  avatarUrl: "https://randomuser.me/api/portraits/women/92.jpg",
  color: colorList[Random().nextInt(colorList.length)],
);

Future<List<Message>> fetchMessages() async {
  List<User> users = [];
  final rand = Random();

  Response response =
      await get(Uri.parse("https://randomuser.me/api/?results=50"));
  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    for (dynamic item in data['results']) {
      users.add(
        User(
          id: item['login']['uuid'],
          avatarUrl: item['picture']['thumbnail'],
          name: item['name']['first'] + " " + item['name']['last'],
          color: colorList[rand.nextInt(colorList.length)],
          isVerified: rand.nextBool(),
        ),
      );
    }
    return [
      TimeStampMessage(author: loggedInUser, displayTime: "Today"),
      TextMessage(
          author: users[Random().nextInt(users.length)],
          time: "12:00 PM",
          text:
              "Hello house, we shall be having a brief meeting in this group tonight by 8:00pm UTC."),
      ActionMessage(
          author: users[Random().nextInt(users.length)],
          time: "now",
          text: "Victor Aniedi joined the group chat via group invite link"),
      TextMessage(
        author: loggedInUser,
        time: "12:21 PM",
        text: "Victor Aniedi, you are welcome to this group chat.",
        stage: 1,
      ),
      AudioMessage(
        author: users[Random().nextInt(users.length)],
        time: "1:06 PM",
      ),
      TextMessage(
        author: users[Random().nextInt(users.length)],
        time: "1:14 PM",
        text:
            "Please check out this link. It's really something you'll like \n\nhttps://github.com/ayzerobug",
      ),
      ImageMessage(
          author: users[Random().nextInt(users.length)],
          time: "2:00 PM",
          uri:
              "https://images.unsplash.com/photo-1494253109108-2e30c049369b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTB8fHJhbmRvbXxlbnwwfHwwfHw%3D&w=1000&q=80",
          caption:
              "Someone sent this picture to me yesterday. \n\n What as it for?"),
      ImageMessage(
          author: users[Random().nextInt(users.length)],
          time: "12:00 PM",
          uri:
              "https://images.unsplash.com/photo-1493612276216-ee3925520721?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cmFuZG9tfGVufDB8fDB8fA%3D%3D&w=1000&q=80",
          caption:
              "Mollit tempor ea quis laborum ipsum velit ea elit sunt nisi. Ipsum amet commodo sint magna velit in sint eu ipsum reprehenderit in incididunt sint fugiat. Consectetur sit laborum commodo cupidatat. Velit aliquip minim officia consequat. Nisi eu Lorem proident incididunt."),
      TextMessage(
          author: users[Random().nextInt(users.length)],
          time: "12:01 PM",
          text:
              "Good Afternoon, may i ask your help to make a real estate landing page, for more details i will send as soon as you provide it. Thanks"),
      TextMessage(
          author: loggedInUser,
          time: "12:10 PM",
          text: "Haii, Micheal!",
          stage: 2),
      TextMessage(
          author: loggedInUser,
          time: "12:10 PM",
          text:
              "Thank you for the offer you gave me, yes I will accept the project from you, for the brief please send it now so i can study it first.",
          stage: 2),
      ActionMessage(
          author: users[Random().nextInt(users.length)],
          time: "now",
          text: "John Doe joined the group chat via group invite link"),
      ActionMessage(
          author: users[Random().nextInt(users.length)],
          time: "now",
          text:
              "The Real Kind of Vibe and More joined the group chat via group invite link"),
      DocumentMessage(
          author: users[Random().nextInt(users.length)],
          time: "12:28 PM",
          documentFormat: "DOCX",
          documentSize: "32 kb",
          documentName: "Brief Project Real Estate Landing Page"),
      ActionMessage(
          author: users[Random().nextInt(users.length)],
          time: "now",
          text: "James left the group chat"),
      AudioMessage(
        author: users[Random().nextInt(users.length)],
        time: "now",
      ),
      ActionMessage(
          author: users[Random().nextInt(users.length)],
          time: "now",
          text: "Victor joined the group chat via group invite link"),
      ActionMessage(
          author: users[Random().nextInt(users.length)],
          time: "now",
          text: "James added Johnson Adekunle"),
      TextMessage(
        author: loggedInUser,
        time: "12:33 PM",
        text: "Ohh i see, for payment we can directly discuss now",
        stage: 1,
      ),
      AudioMessage(
        author: loggedInUser,
        time: "now",
        stage: 2,
      ),
      TextMessage(
        author: users[Random().nextInt(users.length)],
        time: "12:10 PM",
        text:
            "Please check out this link. It's really something you'll like \n\nhttps://github.com/ayzerobug",
      ),
      ImageMessage(
          author: loggedInUser,
          time: "12:00 PM",
          stage: 1,
          uri:
              "https://img.gadgethacks.com/img/55/43/63742419720670/0/pick-different-chat-wallpapers-for-whatsapps-light-dark-modes-for-even-more-control-over-your-theme.1280x600.jpg",
          caption:
              "Mollit tempor ea quis laborum ipsum velit ea elit sunt nisi. Ipsum amet commodo sint magna velit in sint eu ipsum reprehenderit in incididunt sint fugiat. Consectetur sit laborum commodo cupidatat. Velit aliquip minim officia consequat. Nisi eu Lorem proident incididunt."),
    ];
  }
  return [];
}

List<Color> colorList = const <Color>[
  Color(0xff66e0da),
  Color(0xfff5a2d9),
  Color(0xfff0c722),
  Color(0xff6a85e5),
  Color(0xfffd9a6f),
  Color(0xff92db6e),
  Color(0xff73b8e5),
  Color(0xfffd7590),
  Color(0xffc78ae5),
];
