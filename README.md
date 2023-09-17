<br>

<h1 align="center">Mobile Chat UI</h1>

<p align="center">
  A fully customizable modern chat UI for Android, IOS and web developers.
</p>

<br>

<p align="center">
  <a href="https://ayzerobug.com">
    <img alt="Chat Image" src="https://raw.githubusercontent.com/ayzerobug/mobile_chat_ui/master/design.png" />
  </a>
</p>

<br>

## Getting Started

### Requirements
`Dart >=3.1.1` and `Flutter >=3.13.3`

First run the following command in your terminal:

```dart
flutter pub add mobile_chat_ui
```

## Usage
```dart
import 'package:mobile_chat_ui/mobile_chat_ui.dart';

return Scaffold(
    appBar: AppBar(title: const Text("Chat Test")),
    body: Chat(
        user: loggedInUser,
        messages: messages,
        theme: DefaultChatTheme(userAvatarRadius: 12),
        authorDetailsLocation: AuthorDetailsLocation.bottom,
        hasInput: true,
        showUserAvatar: true,
    ),
);
```

# Contributing 

All contributions are welcome!

If you like this project then please click on the 🌟 it'll be appreciated or if you wanna add more epic stuff you can submit your pull request and it'll be gladly accepted 🙆‍♂️

or if you found any bug or issue do not hesitate opening an issue on github