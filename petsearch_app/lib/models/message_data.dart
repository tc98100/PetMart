import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

const Icon DefaultAvatar = Icon(CupertinoIcons.person);

class MessageData {
  final String senderUsername;
  final String receiverUsername;
  final Timestamp timestamp;
  final String data;

  const MessageData(
      {this.senderUsername, this.receiverUsername, this.timestamp, this.data});

  // `findOtherUser`
  //
  // Find other use (sender/receiver) given one username
  String findOtherUser(String username) {
    if (senderUsername == username) {
      return receiverUsername;
    } else {
      return senderUsername;
    }
  }

  // `uniqueUsers`
  //
  // Include only most recent message for each user.
  static MessagesAndUsers uniqueUsers(
      List<MessageData> messages, String currentUser) {
    // Sort messages by timestamp most recent to least recent.
    sortByTimestamp(messages, true);

    // Filter messages
    List<MessageData> filteredMessages = [];
    Map<String, bool> seen = Map();
    for (MessageData message in messages) {
      String otherUser = message.findOtherUser(currentUser);
      if (!seen.containsKey(otherUser)) {
        seen[otherUser] = true;
        filteredMessages.add(message);
      }
    }
    return MessagesAndUsers(
        messages: filteredMessages, users: seen.keys.toList());
  }

  // `sortByTimestamp`
  //
  // Sorts the messages based off the timestamp
  // Set `isRecentFirst` to true for most recent first
  static void sortByTimestamp(List<MessageData> messages, bool isRecentFirst) {
    if (isRecentFirst) {
      // index 0 is most recent timestamp
      messages.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    } else {
      // index 0 is oldest timestamp
      messages.sort((a, b) => a.timestamp.compareTo(b.timestamp));
    }
  }

  // `formatTimestamp`
  //
  // Convert timestamp to a String.
  // - Today -> "hh:mm"
  // - Yesterday -> "yesterday"
  // - Before Yesterday -> "date"
  static String formatTimestamp(Timestamp timestamp) {
    // Assume database validation does not allow datetime significantly in the future

    DateTime dateTime = timestamp.toDate();
    if (dateTime.day == DateTime.now().day) {
      // Today
      String hour = dateTime.hour.toString().padLeft(2, '0');
      String minute = dateTime.minute.toString().padLeft(2, '0');
      return "$hour:$minute";
    } else if (dateTime.day == DateTime.now().day - 1) {
      // Yesterday
      return "yesterday";
    } else {
      // >=2 days ago
      return dateTime.toString().split(" ")[0];
    }
  }
}

class MessagesAndUsers {
  final List<MessageData> messages;
  final List<String> users;

  MessagesAndUsers({this.messages, this.users});
}
