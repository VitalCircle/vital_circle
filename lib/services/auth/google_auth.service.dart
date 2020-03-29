import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'auth.service.dart';

class GoogleAuthService implements AuthProviderService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
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
    return Future.wait([_firebaseAuth.signOut(), _googleSignIn.signOut()]).then((_) => true);
  }

  Future<bool> _signIn([bool isSilent = false]) async {
    GoogleSignInAccount googleUser = _googleSignIn.currentUser;
    googleUser ??= await (isSilent ? _googleSignIn.signInSilently() : _googleSignIn.signIn());
    if (googleUser == null) {
      return false;
    }
    return await _signInWithFirebase(googleUser);
  }

  Future<bool> _signInWithFirebase(GoogleSignInAccount googleUser) async {
    final GoogleSignInAuthentication auth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: auth.accessToken,
      idToken: auth.idToken,
    );
    final authResult = await _firebaseAuth.signInWithCredential(credential);
    return authResult != null;
  }
}
