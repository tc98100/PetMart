import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cupertino_store/models/message_data.dart';
import 'package:cupertino_store/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../theme.dart';

class ChatMessage extends StatelessWidget {
  // Data in a message
  final String text;

  // Was current user receiver (otherwise they are sender)
  final bool receiver;

  // The user currently logged in
  final UserModel currentUser;

  // Other user we are communicating with
  final UserModel otherUser;

  //timestamp of message
  final Timestamp timestamp;

  ChatMessage({
    this.text,
    this.receiver,
    this.otherUser,
    this.currentUser,
    this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    if (receiver) {
      // Display message we have received
      return Container(
          child: Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.height * padding,
                right: MediaQuery.of(context).size.height * padding,
                top: MediaQuery.of(context).size.height * morePadding,
                bottom: MediaQuery.of(context).size.height * morePadding,
              ),
              child: Row(children: [
                Padding(
                  padding: EdgeInsets.only(
                      right: MediaQuery.of(context).size.height * morePadding),
                  child: CircleAvatar(
                      radius: MediaQuery.of(context).size.width * 0.08,
                      backgroundColor: Colors.white.withOpacity(0),
                      child: ClipOval(
                          child: new SizedBox(
                              width:
                                  MediaQuery.of(context).size.width * 0.08 * 2,
                              height:
                                  MediaQuery.of(context).size.width * 0.08 * 2,
                              child: new Image.network(otherUser.profilePath,
                                  fit: BoxFit.cover)))),
                ),
                Expanded(
                  child: Padding(
                      padding: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width * 0.2),
                      child: Container(
                        decoration: chatBubbleOther,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              // Padding(
                              //   padding: const EdgeInsets.all(8.0),
                              //   child: Text(
                              //     otherUser,
                              //     style: subShadow,
                              //   ),
                              // ),
                              Padding(
                                padding: EdgeInsets.all(
                                    MediaQuery.of(context).size.height *
                                        padding),
                                child: Text(text,
                                    style: regularFont(
                                        MediaQuery.of(context).size.height *
                                            normalSize)),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.height *
                                          padding,
                                      bottom:
                                          MediaQuery.of(context).size.height *
                                              padding),
                                  child: Text(
                                    MessageData.formatTimestamp(this.timestamp),
                                    style: subShadow(
                                        MediaQuery.of(context).size.height *
                                            normalSize),
                                  )),
                            ]),
                      )),
                ),
              ])));
    } else {
      // Display message we have sent
      return Container(
          child: Padding(
        padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.height * padding,
          right: MediaQuery.of(context).size.height * padding,
          top: MediaQuery.of(context).size.height * morePadding,
          bottom: MediaQuery.of(context).size.height * morePadding,
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          Expanded(
              child: Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.2),
                  child: Container(
                    decoration: chatBubbleSelf,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(
                                MediaQuery.of(context).size.height * padding),
                            // child: Text(text, style: normal,),

                            child: Text(text,
                                style: regularFont(
                                    MediaQuery.of(context).size.height *
                                        normalSize)),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.height *
                                    padding,
                                bottom: morePadding),
                            child: Text(
                                MessageData.formatTimestamp(this.timestamp),
                                style: regularFont(
                                    MediaQuery.of(context).size.height *
                                        normalSize)),
                          )
                        ]),
                  ))),
          Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.height * padding),
            child: CircleAvatar(
                radius: MediaQuery.of(context).size.width * 0.08,
                backgroundColor: Colors.white.withOpacity(0),
                child: ClipOval(
                    child: new SizedBox(
                        width: MediaQuery.of(context).size.width * 0.08 * 2,
                        height: MediaQuery.of(context).size.width * 0.08 * 2,
                        child: new Image.network(currentUser.profilePath,
                            fit: BoxFit.cover)))),
          ),
        ]),
      ));
    }
  }
}
