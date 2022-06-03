import 'package:flutter/cupertino.dart';
import 'package:practice_app/firestore.dart';
import 'package:practice_app/widgets/post.dart';

class CurrentUser extends ChangeNotifier with Firestore {
  String _handle = '';
  String _username = '';
  String _avatarPath = '';
  String _location = '';
  String _uid = '';
  final List<Post> _personalPosts = [];
  final List<Post> _viewablePosts = [];

  String get handle => _handle;
  String get username => _username;
  String get avatarPath => _avatarPath;
  String get location => _location;
  String get uid => _uid;
  List<Post> get personalPosts => _personalPosts;
  List<Post> get viewablePosts => _viewablePosts;

  void setUser(String handle, String username, String avatarPath,
      String location, String uid) {
    _handle = handle;
    _username = username;
    _avatarPath = avatarPath;
    _location = location;
    _uid = uid;
    notifyListeners();
  }

  void getAllViewablePosts(List<Post> posts) {
    _viewablePosts.addAll(posts);
    notifyListeners();
  }

  void getAllPersonalPosts() async {
    final posts = await getPersonalPosts();
    _personalPosts.addAll(posts);
    notifyListeners();
  }

  void changeAvatarPath(String newPath) {
    _avatarPath = newPath;
  }
}
