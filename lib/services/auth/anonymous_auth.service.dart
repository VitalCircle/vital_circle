import 'package:firebase_auth/firebase_auth.dart';

import 'auth.service.dart';

class AnonymousAuthService implements AuthProviderService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<bool> signInSilently() {
    return _signIn(true);
  }

  @override
  Future<bool> signIn() {
    return _signIn(false);
  }

  @override
  Future<bool> signOut() {
    return _firebaseAuth.signOut().then((_) => true);
  }

  Future<bool> _signIn([bool isSilent = false]) async {
    var user = await _firebaseAuth.currentUser();
    user ??= isSilent ? null : (await _firebaseAuth.signInAnonymously()).user;
    return user != null;
  }
}
