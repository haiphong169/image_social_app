import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:practice_app/user.dart';
import 'package:practice_app/widgets/chat_card.dart';
import 'package:practice_app/widgets/post.dart';
import 'package:practice_app/widgets/text_message.dart';

mixin Firestore {
  final db = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;

  Future<List<Message>> getAllMessagesInAChatRoom(String roomId) async {
    final List<Message> res = [];
    var allMessages = await db.collection('messages').orderBy('date').get();
    for (var message in allMessages.docs) {
      if (message.data()['roomId'] == roomId) {
        var user =
            await db.collection('users').doc(message.data()['senderId']).get();
        res.add(Message.fromJson(message.data(), user.data()!['avatarPath']));
      }
    }
    return res;
  }

// new muon sap xep chat card nhu messenger, bat dau query tu message trc
  Future<List<ChatCard>> getAllChatRooms() async {
    final List<ChatCard> res = [];
    var allRooms = await db.collection('rooms').get();
    for (var room in allRooms.docs) {
      print(allRooms.docs.length);
      if (room.data()['user1'] == getCurrentUser().userId ||
          room.data()['user2'] == getCurrentUser().userId) {
        var user = room.data()['user1'] == getCurrentUser().userId
            ? await db.collection('users').doc(room.data()['user2']).get()
            : await db.collection('users').doc(room.data()['user1']).get();
        var allMessages = await db
            .collection('messages')
            .orderBy('date', descending: true)
            .get();
        final List<Message> messages = [];
        for (var mes in allMessages.docs) {
          if (mes.data()['roomId'] == room.id) {
            messages
                .add(Message.fromJson(mes.data(), user.data()!['avatarPath']));
          }
        }
        ChatCard chatCard = ChatCard(
            avatarPath: user.data()!['avatarPath'],
            username: user.data()!['username'],
            lastMessage: messages[0].content,
            roomId: room.id);
        res.add(chatCard);
      }
    }
    return res;
  }

  addMessage(String roomId, String content, Timestamp date) async {
    await db.collection('messages').add({
      'senderId': getCurrentUser().userId,
      'content': content,
      'date': date,
      'roomId': roomId
    });
  }

  Future<String> addChatRoom(String otherUser) async {
    var allRooms = await db.collection('rooms').get();
    for (var room in allRooms.docs) {
      if ((room.data()['user1'] == getCurrentUser().userId &&
              room.data()['user2'] == otherUser) ||
          room.data()['user1'] == otherUser &&
              room.data()['user2'] == getCurrentUser().userId) {
        return room.id;
      }
    }
    var newChatRoom = await db
        .collection('rooms')
        .add({'user1': getCurrentUser().userId, 'user2': otherUser});
    return newChatRoom.id;
  }

  Future<Map<String, dynamic>> getUserInfo(String userId) async {
    var user = await db.collection('users').doc(userId).get();
    var res = {
      'avatarPath': user.data()!['avatarPath'],
      'handle': user.data()!['handle'],
      'location': user.data()!['location'],
      'username': user.data()!['username'],
    };
    return res;
  }

  Future<List<Post>> getPostsOfAUser(String userId) async {
    var posts =
        await db.collection('posts').orderBy('date', descending: true).get();
    final List<Post> res = [];
    for (var document in posts.docs) {
      var data = document.data();
      if (data['userId'] == userId) {
        var user = await db.collection('users').doc(data['userId']).get();
        var userData = user.data();
        Post item = Post(
            location: userData!['location'],
            imagePath: data['imagePath'],
            avatarPath: userData['avatarPath'],
            username: userData['username'],
            handle: userData['handle'],
            title: data['title'],
            date: data['date'],
            userId: data['userId']);
        res.add(item);
      }
    }
    return res;
  }

  Future<List<Post>> getPersonalPosts() async {
    var personalPosts =
        await db.collection('posts').orderBy('date', descending: true).get();
    final List<Post> res = [];
    for (var document in personalPosts.docs) {
      var data = document.data();
      if (data['userId'] == getCurrentUser().userId) {
        Post item = Post(
          location: getCurrentUser().location,
          userId: data['userId'],
          date: data['date'],
          title: data['title'],
          imagePath: data['imagePath'],
          avatarPath: getCurrentUser().avatarPath,
          username: getCurrentUser().username,
          handle: getCurrentUser().handle,
        );
        res.add(item);
      }
    }
    return res;
  }

  Future<List<Post>> getAllPosts() async {
    var allPosts =
        await db.collection('posts').orderBy('date', descending: true).get();

    final List<Post> res = [];
    for (var document in allPosts.docs) {
      var data = document.data();

      if (data['userId'] != getCurrentUser().userId) {
        var user = await db.collection('users').doc(data['userId']).get();
        Post post = Post(
            location: user.data()!['location'],
            userId: data['userId'],
            date: data['date'],
            avatarPath: user.data()!['avatarPath'],
            imagePath: data['imagePath'],
            handle: user.data()!['handle'],
            username: user.data()!['username'],
            title: data['title']);
        res.add(post);
      }
    }
    return res;
  }

  Future<List<Post>> searchPosts(String searchTitle) async {
    var matchedPosts =
        await db.collection('posts').orderBy('date', descending: true).get();
    final List<Post> res = [];
    for (var document in matchedPosts.docs) {
      var data = document.data();
      if (data['title'] == searchTitle) {
        var user = await db.collection('users').doc(data['userId']).get();
        Post post = Post(
            location: user.data()!['location'],
            userId: data['userId'],
            date: data['date'],
            avatarPath: user.data()!['avatarPath'],
            imagePath: data['imagePath'],
            handle: user.data()!['handle'],
            username: user.data()!['username'],
            title: data['title']);
        res.add(post);
      }
    }
    return res;
  }

  addPost(String filePath, String title, Timestamp date) async {
    final userStorage = storage
        .ref()
        .child(getCurrentUser().userId)
        .child(DateTime.now().toString());
    File image = File(filePath);
    var res = await userStorage.putFile(image);
    final downloadUrl = await res.ref.getDownloadURL();

    await db.collection('posts').add({
      'imagePath': downloadUrl,
      'isFeatured': false,
      'title': title,
      'userId': getCurrentUser().userId,
      'date': date
    });
  }

  changeAvatar(String filePath) async {
    final avatarRef =
        storage.ref().child(getCurrentUser().userId).child('avatar.png');
    File avatarImage = File(filePath);
    var res = await avatarRef.putFile(avatarImage);
    final downloadUrl = await res.ref.getDownloadURL();

    final userDoc = db.collection('users').doc(getCurrentUser().userId);
    userDoc.update({'avatarPath': downloadUrl});

    setCurrentUser(
        await getUserWithId(getCurrentUser().userId), getCurrentUser().userId);
  }

  addUser(
      String username, String handle, String location, String userId) async {
    final user = <String, dynamic>{
      'username': username,
      'handle': '@' + handle,
      'location': location,
      'avatarPath':
          'https://firebasestorage.googleapis.com/v0/b/flutter-practice-app-9b111.appspot.com/o/default_avatar.png?alt=media&token=3ea8c2fa-44d2-47d9-955f-4c8ecb66dafe',
    };
    await db.collection('users').doc(userId).set(user);
  }

  Future<Map<String, dynamic>> getUserWithId(String userId) async {
    final userDoc = await db.collection('users').doc(userId).get();
    final data = userDoc.data() as Map<String, dynamic>;
    final res = {...data, "userId": userId};
    return res;
  }
}
