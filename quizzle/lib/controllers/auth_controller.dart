import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quizzle/firebase/references.dart';
import 'package:quizzle/screens/screens.dart' show AppIntroductionScreen, HomeScreen, LoginScreen;
import 'package:quizzle/utils/utils.dart';
import 'package:quizzle/widgets/widgets.dart';

class AuthController extends GetxController {
  @override
  void onReady() {
    initAuth();
    super.onReady();
  }

  late FirebaseAuth _auth;
  final _user = Rxn<User>();
  late Stream<User?> _authStateChanges;

  void initAuth() async {
    await Future.delayed(const Duration(seconds: 2)); // waiting in splash
    _auth = FirebaseAuth.instance;
    _authStateChanges = _auth.authStateChanges();
    _authStateChanges.listen((User? user) {
      _user.value = user;
    });
    navigateToIntroduction();
  }

  Future<void> siginInWithGoogle() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();

    try {
      GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account != null) {
        final _gAuthentication = await account.authentication;
        final _credential = GoogleAuthProvider.credential(
            idToken: _gAuthentication.idToken,
            accessToken: _gAuthentication.accessToken);
        await _auth.signInWithCredential(_credential);
        await saveUser(account);
        navigateToHome();
      }
    } on Exception catch (error) {
      AppLogger.e(error);
    }
  }

  Future<void> signOut() async {
    AppLogger.d("Sign out");
    try {
      await _auth.signOut();
      navigateToHome();
    } on FirebaseAuthException catch (e) {
      AppLogger.e(e);
    }
  }

  Future<void> saveUser(GoogleSignInAccount account) async {
    userFR
        .doc(account.email)
        .set({"email" : account.email, "name": account.displayName, "profilepic": account.photoUrl});
  }

  User? getUser() {
    _user.value = _auth.currentUser;
    return _user.value;
  }

  bool isLogedIn() {
    return _auth.currentUser != null;
  }

  void navigateToHome() {
    Get.offAllNamed(HomeScreen.routeName);
  }

  void navigateToLogin() {
    Get.toNamed(LoginScreen.routeName);
  }

  void navigateToIntroduction() {
    Get.offAllNamed(AppIntroductionScreen.routeName);
  }

  void showLoginAlertDialog() {
    Get.dialog(
      Dialogs.quizStartDialog(onTap: (){
        Get.back();
        navigateToLogin();
      }),
      barrierDismissible: false,
    );
  }
}
