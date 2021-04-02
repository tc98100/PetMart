import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test/test.dart';
import 'package:cupertino_store/models/message_data.dart';

void main() {
  // Test the constructor and getters
  test("Unit Test: MessageData - Constructor", () {
    // Variables
    String senderUsername = 'sender-test';
    String receiverUsername = 'receiver-test';
    Timestamp timestamp = Timestamp.now();
    String data = 'data-test';

    // Create `MessageData`
    final MessageData message = MessageData(
      senderUsername: senderUsername,
      receiverUsername: receiverUsername,
      timestamp: timestamp,
      data: data,
    );

    // Ensure variables were set correctly
    expect(message.senderUsername, senderUsername);
    expect(message.receiverUsername, receiverUsername);
    expect(message.timestamp, timestamp);
    expect(message.data, data);
  });

  // Test sorting by timestamp functionality
  test('Unit Test: MessageData - sortByTimestamp', () {
    // Variables
    String senderUsername = 'sender-test';
    String receiverUsername = 'receiver-test';
    String data = 'data-test';

    // Create `messageA` with first timestamp
    final MessageData messageA = MessageData(
      senderUsername: senderUsername,
      receiverUsername: receiverUsername,
      timestamp: Timestamp(10, 11),
      data: data,
    );

    // Create `messageB` with second timestamp
    final MessageData messageB = MessageData(
      senderUsername: senderUsername,
      receiverUsername: receiverUsername,
      timestamp: Timestamp(10, 12),
      data: data,
    );

    // Create `messageC` with second timestamp
    final MessageData messageC = MessageData(
      senderUsername: senderUsername,
      receiverUsername: receiverUsername,
      timestamp: Timestamp(11, 10),
      data: data,
    );

    // List messages in not ordered by timestamp
    List<MessageData> messages = [messageB, messageC, messageA];

    // Recent first sort
    MessageData.sortByTimestamp(messages, true);
    expect(messages, [messageC, messageB, messageA]);

    // Recent last sort
    MessageData.sortByTimestamp(messages, false);
    expect(messages, [messageA, messageB, messageC]);
  });

  // Test `uniqueUsers` functionality
  test('Unit Test: MessageData - uniqueUsers', () {
    // Variables
    String currentUser = 'userA';
    String userB = 'userB';
    String userC = 'userC';
    String data = 'data-test';

    // Create `messageA` with users A,B
    final MessageData messageA = MessageData(
      senderUsername: currentUser,
      receiverUsername: userB,
      timestamp: Timestamp(10, 11),
      data: data,
    );

    // Create `messageB` with users A,B after `messageA`
    final MessageData messageB = MessageData(
      senderUsername: userB,
      receiverUsername: currentUser,
      timestamp: Timestamp(10, 12),
      data: data,
    );

    // Create `messageC` with users A,C
    final MessageData messageC = MessageData(
      senderUsername: currentUser,
      receiverUsername: userC,
      timestamp: Timestamp(10, 13),
      data: data,
    );

    MessagesAndUsers messagesAndUsers =
        MessageData.uniqueUsers([messageA, messageB, messageC], currentUser);

    // Returns messages ordered and only one other user
    expect(messagesAndUsers.messages, [messageC, messageB]);

    // Should contain only other users
    expect(messagesAndUsers.users.contains(currentUser), false);
    expect(messagesAndUsers.users.contains(userB), true);
    expect(messagesAndUsers.users.contains(userC), true);
  });

  // Test `formatTimestamp`
  test('Unit Test: MessageData - formatting timestamps', () {
    // Present should be "hh:mm"
    Timestamp present = Timestamp.now();
    expect(MessageData.formatTimestamp(present).contains(':'), true);
    expect(MessageData.formatTimestamp(present).length, 5);

    // Yesterday should be 'yesterday'
    DateTime yesterdayDateTime = present.toDate().subtract(Duration(days: 1));
    Timestamp yesterday = Timestamp.fromDate(yesterdayDateTime);
    expect(MessageData.formatTimestamp(yesterday), 'yesterday');

    DateTime twoDaysAgoDateTime = present.toDate().subtract(Duration(days: 2));
    Timestamp twoDaysAgo = Timestamp.fromDate(twoDaysAgoDateTime);
    expect(MessageData.formatTimestamp(twoDaysAgo).length, 10);
    expect(MessageData.formatTimestamp(twoDaysAgo).contains('-'), true);
  });
}
