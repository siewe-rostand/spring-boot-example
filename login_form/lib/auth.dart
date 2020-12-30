import 'dart:async';

/*abstract class BaseAuth{
  Stream<User> get onAuthStateChange;
  Future<String> signInWithEmailAndPassword(String email, String password);
  Future<String> createUserWithEmailAndPassword(String email, String password);
  Future<String> currentUser();
  Future<void> signedOut();
}

class Auth implements BaseAuth{
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Stream<User> get onAuthStateChange{
    return firebaseAuth.authStateChanges();
  }

  Future<String> signInWithEmailAndPassword(String email, String password)async{
    User user = (await firebaseAuth.signInWithEmailAndPassword(email: email, password: password)) .user;
    user.email;
    return user?.uid;
  }
  Future<String> createUserWithEmailAndPassword(String email, String password) async{
    User user = (await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password)).user;
    return user?.uid;
  }
  Future<String> currentUser() async{
    User user = firebaseAuth.currentUser;
    return user?.uid;
  }
  Future<void> signedOut() async {
    return firebaseAuth.signOut();
  }

}*/