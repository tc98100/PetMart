import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cupertino_store/backend/message_service.dart';
import 'package:cupertino_store/theme.dart';
import 'package:cupertino_store/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/message_data.dart';
import '../models/user_model.dart';
import '../components/chat_message.dart';

class ChatScreen extends StatefulWidget {
  static const String route = 'chat_page';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  // State Variables
  List<ChatMessage> _messages = [];
  UserModel currentUser;
  UserModel otherUser;

  @override
  Widget build(BuildContext context) {
    // Set current logged in user
    currentUser = Provider.of<UserModel>(context);

    // Get the other user's username as input argument
    otherUser = ModalRoute.of(context).settings.arguments;

    // Loading if we do not currently have the either user
    if (currentUser == null || otherUser == null) {
      return LoadingScreen(message: 'Loading messages ...');
    }

    List<Stream<List<MessageData>>> messageStreams = MessageService()
        .messagesBetween(currentUser.username, otherUser.username);

    // Build first message stream
    return StreamBuilder(
      stream: messageStreams[0], // current -> other
      builder: (context, snapshot) {
        List<MessageData> messagesSent = [];
        // Update _message if available
        if (snapshot.hasData) {
          messagesSent = snapshot.data;
        }

        // Build second message stream
        return StreamBuilder(
            stream: messageStreams[1], // other -> current
            builder: (context, snapshot) {
              // Update _message if messages are available
              List<MessageData> messagesReceived = [];
              if (snapshot.hasData) {
                messagesReceived = snapshot.data;
              }

              // Create combined list of message fresh for each stream rebuild.
              List<MessageData> messages = [];
              messages.addAll(messagesReceived);
              messages.addAll(messagesSent);

              // Sort messages newest to oldest
              messages.sort((a, b) => b.timestamp.compareTo(a.timestamp));

              // Convert messages to ChatMessages
              _messages = (messages.map((message) {
                return ChatMessage(
                  text: message.data,
                  receiver: currentUser.username == message.receiverUsername,
                  currentUser: currentUser,
                  otherUser: otherUser,
                  timestamp: message.timestamp,
                );
              })).toList();

              // Display ChatMessages
              return CupertinoPageScaffold(
                  navigationBar: CupertinoNavigationBar(
                    leading: CupertinoNavigationBarBackButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      color: appTheme.primaryColor,
                    ),
                    backgroundColor: appTheme.scaffoldBackgroundColor,
                    middle: Text(otherUser.firstName,
                        style: gradientText(
                            MediaQuery.of(context).size.height * titleSize)),
                  ),
                  child: SafeArea(
                      child: Column(children: [
                    Flexible(
                        child: ListView.builder(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.height * padding),
                      reverse: true,
                      itemBuilder: (_, int index) => _messages[index],
                      itemCount: _messages.length,
                    )),
                    Divider(height: 1.0),
                    _buildTextComposer(otherUser.username),
                  ])));
            });
      },
    );
  }

  //the text input widget
  Widget _buildTextComposer(String otherUser) {
    return Container(
        margin: EdgeInsets.all(MediaQuery.of(context).size.height * padding),
        child: Row(children: [
          Flexible(
            child: DarkTextField(
              obscureText: false,
              maxLines: null,
              controller: _textController,
              onSubmitted: _handleSubmitted,
              placeholder: "Write Message Here",
              focusNode: _focusNode,
            ),
          ),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 2.0),
              child: CupertinoButton(
                child: Text(
                  "Send",
                  style: highlight,
                ),
                onPressed: () => _handleSubmitted(_textController.text),
              ))
        ]));
  }

  void _handleSubmitted(String text) {
    _textController.clear();

    // Send message to firebase.
    MessageService().createMessage(MessageData(
      senderUsername: currentUser.username,
      receiverUsername: otherUser.username,
      timestamp: Timestamp.now(),
      data: text,
    ));

    _focusNode.requestFocus();
  }
}
