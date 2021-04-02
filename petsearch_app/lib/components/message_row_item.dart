import 'package:cupertino_store/enums/item_condition.dart';
import 'package:cupertino_store/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/message_data.dart';
import '../theme.dart';
import '../tabs/chat_screen.dart';

class MessageRowItem extends StatelessWidget {
  const MessageRowItem({
    this.index,
    this.message,
    this.otherUser,
    this.lastItem,
  });

  final MessageData message;
  final UserModel otherUser;
  final int index;
  final bool lastItem;

  @override
  Widget build(BuildContext context) {
    final row = SafeArea(
      top: false,
      bottom: false,
      minimum: EdgeInsets.only(
        left: 0,
        top: MediaQuery.of(context).size.height * padding,
        bottom: MediaQuery.of(context).size.height * padding,
        right: MediaQuery.of(context).size.height * padding,
      ),
      child: FlatButton(
        padding: EdgeInsets.all(MediaQuery.of(context).size.height * padding),
        onPressed: () {
          Navigator.of(context, rootNavigator: true)
              .pushNamed(ChatScreen.route, arguments: otherUser);
        },
        child: Padding(
          padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.height * morePadding,
          ),
          child: Row(children: <Widget>[
            CircleAvatar(
                radius: MediaQuery.of(context).size.width * 0.08,
                backgroundColor: Colors.white.withOpacity(0),
                child: ClipOval(
                    child: new SizedBox(
                        width: MediaQuery.of(context).size.width * 0.08 * 2,
                        height: MediaQuery.of(context).size.width * 0.08 * 2,
                        child: new Image.network(otherUser.profilePath,
                            fit: BoxFit.cover)))),
            Expanded(
                child: Padding(
              padding: EdgeInsets.only(
                  top: 0,
                  bottom: MediaQuery.of(context).size.height * padding,
                  left: MediaQuery.of(context).size.height * morePadding,
                  right: MediaQuery.of(context).size.height * padding),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
                      Expanded(
                        child: new Padding(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height *
                                morePadding,
                          ),
                          child: Text(otherUser.firstName + " " + otherUser.lastName,
                              style: title(MediaQuery.of(context).size.height *
                                  normalSize)),
                        ),
                      ),
                      Expanded(
                        child: new Padding(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height *
                                morePadding,
                          ),
                          child: Text(
                              MessageData.formatTimestamp(message.timestamp),
                              textAlign: TextAlign.end,
                              style: subShadow(
                                  MediaQuery.of(context).size.height *
                                      smallSize)),
                        ),
                      )
                    ]),
                    Text(
                      message.data,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: regularFont(
                          MediaQuery.of(context).size.height * normalSize),
                    ),
                  ]),
            )),
          ]),
        ),
      ),
    );

    return Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
      row,
      Padding(
          padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.height * morePadding,
            right: MediaQuery.of(context).size.height * morePadding,
          ),
          child: Container(
            height: 1,
            color: appTheme.primaryColor,
          ))
    ]);
  }
}
