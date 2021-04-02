import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cupertino_store/models/message_data.dart';

class MessageService {
  // Stores the reference to the collection `messages`.
  final CollectionReference messagesCollection =
      FirebaseFirestore.instance.collection('messages');

  // `messages`
  //
  // Attempts to retrieve all messages. Note will be blocked in firebase console in the future.
  Stream<List<MessageData>> get messages {
    return messagesCollection.snapshots().map(messageDataFromSnapshot);
  }

  // `messagesBetween`
  //
  // Returns the Messages between two users.
  // Users may be either sender or receiver.
  List<Stream<List<MessageData>>> messagesBetween(String userA, String userB) {
    // Collect Messages A to B
    Stream<List<MessageData>> stream1 = messagesCollection
        .where('senderUsername', isEqualTo: userA)
        .where('receiverUsername', isEqualTo: userB)
        .snapshots()
        .map(messageDataFromSnapshot);
    // Collect Messages B to A
    Stream<List<MessageData>> stream2 = messagesCollection
        .where('senderUsername', isEqualTo: userB)
        .where('receiverUsername', isEqualTo: userA)
        .snapshots()
        .map(messageDataFromSnapshot);
    // Merge the streams
    return [stream1, stream2];
  }

  // `sentMessages`
  //
  // Returns all messages sent by `username`
  Stream<List<MessageData>> sentMessages(String username) {
    return messagesCollection
        .where('senderUsername', isEqualTo: username)
        .snapshots()
        .map(messageDataFromSnapshot);
  }

  // `receivedMessages`
  //
  // Returns all messages received by `username`.
  Stream<List<MessageData>> receivedMessages(String username) {
    return messagesCollection
        .where('receiverUsername', isEqualTo: username)
        .snapshots()
        .map(messageDataFromSnapshot);
  }

  // `createMessage`
  //
  // Creates a new message
  void createMessage(MessageData message) {
    // TODO: Message validation and escaping

    // Add message to database.
    messagesCollection.add({
      'senderUsername': message.senderUsername,
      'receiverUsername': message.receiverUsername,
      'timestamp': message.timestamp ?? Timestamp.now(),
      'data': message.data,
    });
  }

  /*
  * Helpers
  */

  // Converts database snapshots to a list of `MessageData`
  static List<MessageData> messageDataFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return MessageData(
        senderUsername: doc['senderUsername'] ?? '',
        receiverUsername: doc['receiverUsername'] ?? '',
        timestamp: doc['timestamp'] ?? Timestamp.now(),
        data: doc['data'] ?? '',
      );
    }).toList();
  }
}
