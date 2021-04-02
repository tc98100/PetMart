import 'package:cupertino_store/backend/message_service.dart';
import 'package:cupertino_store/backend/user_service.dart';
import 'package:cupertino_store/models/message_data.dart';
import 'package:cupertino_store/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../components/message_row_item.dart';
import '../theme.dart';
import '../utils.dart';

class MessageTab extends StatefulWidget {
  static const String route = 'messages';

  @override
  _MessageTabState createState() => _MessageTabState();
}

class _MessageTabState extends State<MessageTab> {
  @override
  Widget build(BuildContext context) {
    // Attempt to access current user
    final currentUser = Provider.of<UserModel>(context);

    if (currentUser == null || currentUser.username == '') {
      return CupertinoPageScaffold(
          child: Center(
              child: Container(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal:
                        MediaQuery.of(context).size.height * sectionPadding),
                child: Text(
                  "You are not logged in!",
                  textAlign: TextAlign.center,
                  style: gradientText(
                      MediaQuery.of(context).size.height * subtitleSize),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal:
                        MediaQuery.of(context).size.height * sectionPadding,
                    vertical: MediaQuery.of(context).size.height * 0.01),
                child: Text(
                  "Please log in or create an account to start messaging!",
                  textAlign: TextAlign.center,
                  style: gradientText(
                      MediaQuery.of(context).size.height * subtitleSize),
                ),
              ),
              // CustomButton(
              //   onPressed: (){
              //     Navigator.of(context, rootNavigator: true).pushNamed(AppStateSwitcher.route);
              //   },
              //   child: Text("Log In or Sign Up"),
              // ),
            ]),
      )));
    }

    // Build stream for sent messages
    return StreamBuilder<List<MessageData>>(
        stream: MessageService().sentMessages(currentUser.username),
        builder: (context, snapshot) {
          List<MessageData> messages = [];
          // Add sent messages
          if (snapshot.hasData) {
            messages = snapshot.data;
          }
          // Build stream for received messages
          return StreamBuilder<List<MessageData>>(
              stream: MessageService().receivedMessages(currentUser.username),
              builder: (context, snapshot) {
                // Add received messages
                if (snapshot.hasData) {
                  messages.addAll(snapshot.data);
                }

                // Remove any duplicate users and obtain list of usernames
                MessagesAndUsers messagesAndUsers =
                    MessageData.uniqueUsers(messages, currentUser.username);
                messages = messagesAndUsers.messages;

                return StreamBuilder(
                    stream: UserService(currentUser.userId)
                        .getUsersByUsername(messagesAndUsers.users),
                    builder: (context, snapshot) {
                      // UserModels for each username
                      List<UserModel> users = [];
                      if (snapshot.hasData) {
                        users = snapshot.data;
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        // Connection is done with no messages
                        return CupertinoPageScaffold(
                            child: Center(
                                child: Container(
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        MediaQuery.of(context).size.height *
                                            sectionPadding),
                                child: Text(
                                  "You have no messages yet!",
                                  textAlign: TextAlign.center,
                                  style: gradientText(
                                      MediaQuery.of(context).size.height *
                                          subtitleSize),
                                ),
                              )
                            ]))));
                      } else {
                        // Still loading messages
                        return CupertinoPageScaffold(
                            navigationBar: CupertinoNavigationBar(
                              backgroundColor: appTheme.scaffoldBackgroundColor,
                              middle: Text("Messages", style: gradientText(20)),
                            ),
                            child: SafeArea(
                                child: LoadingScreen(
                                    message: "Fetching messages ...")));
                      }

                      return CustomScrollView(slivers: <Widget>[
                        CupertinoSliverNavigationBar(
                          backgroundColor: appTheme.scaffoldBackgroundColor,
                          largeTitle: Text("Messages",
                              style: gradientText(
                                  MediaQuery.of(context).size.height *
                                      headerSize)),
                        ),
                        SliverSafeArea(
                          top: false,
                          sliver: SliverList(
                            delegate:
                                SliverChildBuilderDelegate((context, index) {
                              // If we have a current use display messages
                              if (index < messages.length) {
                                String otherUsername = messages[index]
                                    .findOtherUser(currentUser.username);

                                // Display message header if we have not yet done so for a user.
                                return MessageRowItem(
                                  index: index,
                                  message: messages[index],
                                  otherUser: UserModel.getUserFromUsername(
                                      users, otherUsername),
                                  lastItem: index == messages.length - 1,
                                );
                              }
                              return null;
                            }),
                          ),
                        )
                      ]);
                    });
              });
        });
  }
}
