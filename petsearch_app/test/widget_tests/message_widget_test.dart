import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cupertino_store/components/message_row_item.dart';
import 'package:cupertino_store/models/message_data.dart';
import 'package:cupertino_store/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockFirestore extends Mock implements FirebaseFirestore {}

void main() {
  // Create `MessageData`
  final MessageData message = MessageData(
    senderUsername: 'sender-test',
    receiverUsername: 'receiver-test',
    timestamp: Timestamp.now(),
    data: 'data-test',
  );

  //Create UserModel
  final UserModel otherUser = UserModel(
      userId: 'a',
      firstName: 'first-a',
      lastName: 'last-a',
      username: 'user-a',
      sumRatings: 1,
      countRatings: 2,
      profilePhoto: File('profilePhoto-a'),
      profilePath: 'profilePath-a',
      bio: 'bio-a');

  Widget testWidget = new MediaQuery(
      data: new MediaQueryData(),
      child: new MaterialApp(
          home: MessageRowItem(
        index: 1,
        message: message,
        otherUser: otherUser,
        lastItem: false,
      )));

  testWidgets('Widget Test: Message Row Item', (WidgetTester tester) async {
    // await tester.pumpWidget(testWidget);
    // final messageFinder = find.text(message.data);

    // expect(find.text(otherUser.username), findsOneWidget);
    // final messageFinder = find.Text(1);

  });
}