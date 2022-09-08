<br>

<h1 align="center">Mobile Chat UI</h1>

<p align="center">
  A fully customizable chat UI for mobile developers
</p>

<br>

<p align="center">
  <a href="https://ayzerobug.com">
    <img alt="Chat Image" src="#" />
  </a>
</p>

<br>

## Getting Started

### Requirements
`Dart >=2.17.0` and `Flutter >=2.0.0`

First run the following command in your terminal:

```dart
flutter pub add mobile_chat_ui
```

## Usage
```dart
import 'package:mobile_chat_ui/mobile_chat_ui.dart';

return Scaffold(
    appBar: AppBar(
    title: const Center(child: Text("Mobile Chat UI"))),
    body: Chat(
        user: loggedInUser,
        messages: messages,
        theme: DefaultChatTheme(
          userAvatarRadius: 12,
        ),
        showUserAvatar: true,
        input: const ChatInput(),
    ),
);
```

## Messages
The messages variable is a list of type Message which subTypes of:
* TextMessage
* AudioMessage
* ImageMessage
* ActionMessage
* DocumentMessage
* TimestampMessage

```dart
import 'package:mobile_chat_ui/models/messages/message.dart';

List<Message> messages = [
    TimeStampMessage(displayTime: "Today"),
    TextMessage(
        author: users[Random().nextInt(users.length)],
        time: "12:00 PM",
        text:
            "Hello house, we shall be having a brief meeting in this group tonight by 8:00pm UTC."),
    ActionMessage(
        author: users[Random().nextInt(users.length)],
        time: "now",
        text: "Victor Aniedi joined the group chat via group invite link"),
    ImageMessage(
        author: users[Random().nextInt(users.length)],
        time: "12:00 PM",
        imageUrl:
            "https://images.unsplash.com/photo-1493612276216-ee3925520721?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cmFuZG9tfGVufDB8fDB8fA%3D%3D&w=1000&q=80",
        caption:
            "Mollit tempor ea quis laborum ipsum velit ea elit sunt nisi. Ipsum amet commodo sint magna velit in sint eu ipsum reprehenderit in incididunt sint fugiat. Consectetur sit laborum commodo cupidatat. Velit aliquip minim officia consequat. Nisi eu Lorem proident incididunt."),
    DocumentMessage(
        author: users[Random().nextInt(users.length)],
        time: "12:28 PM",
        documentFormat: "DOCX",
        documentSize: "32 kb",
        documentName: "Brief Project Real Estate Landing Page",
    ),
];
```
The author parameter of a message should receive a type User


##user
Declare a User object with the example below
```dart
import 'package:mobile_chat_ui/models/user.dart';

User loggedInUser = User(
    id: "GtIqnUfq0KY5GfR6mD25jlVyNlDdl",
    name: "Putra Silas",
    avatarUrl: "https://randomuser.me/api/portraits/women/92.jpg",
);
```




List what your package can do. Maybe include images, gifs, or videos.

## Getting started

List prerequisites and provide or point to information on how to
start using the package.

## Usage

Include short and useful examples for package users. Add longer examples
to `/example` folder. 

```dart
const like = 'sample';
```

## Additional information

Tell users more about the package: where to find more information, how to 
contribute to the package, how to file issues, what response they can expect 
from the package authors, and more.
