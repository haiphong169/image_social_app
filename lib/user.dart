library user;

class _MyUser {
  const _MyUser(
      {required this.handle,
      required this.username,
      required this.avatarPath,
      required this.userId,
      required this.location});

  final String handle;
  final String username;
  final String location;
  final String avatarPath;
  final String userId;
}

_MyUser currentUser = const _MyUser(
    handle: '', username: '', avatarPath: '', location: '', userId: '');

setCurrentUser(Map<String, dynamic> userData, String userId) async {
  currentUser = _MyUser(
      location: userData['location'],
      handle: userData['handle'],
      username: userData['username'],
      avatarPath: userData['avatarPath'],
      userId: userId);
}

resetCurrentUser() {
  currentUser = const _MyUser(
      handle: '', username: '', avatarPath: '', userId: '', location: '');
}

getCurrentUser() {
  return currentUser;
}
