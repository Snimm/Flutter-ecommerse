import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class GwaleFirebaseUser {
  GwaleFirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

GwaleFirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<GwaleFirebaseUser> gwaleFirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<GwaleFirebaseUser>((user) => currentUser = GwaleFirebaseUser(user));
