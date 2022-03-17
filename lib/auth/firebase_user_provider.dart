import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class HiappFirebaseUser {
  HiappFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

HiappFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<HiappFirebaseUser> hiappFirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<HiappFirebaseUser>((user) => currentUser = HiappFirebaseUser(user));
