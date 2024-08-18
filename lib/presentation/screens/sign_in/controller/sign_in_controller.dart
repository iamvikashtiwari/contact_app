import '../../../../imports.dart';

class SignInController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode emailNode = FocusNode();
  final FocusNode passwordNode = FocusNode();
  FirebaseAuth auth = FirebaseAuth.instance;

  signInFunction({
    required String email,
    required String password,
  }) {
    KeyboardUtil.onCloseKeyboard();
    if (email.isEmpty) {
      SnackBarUtil.showSnackBar(message: Strings.strPleaseEnterEmail);
    } else if (!email.isEmail) {
      SnackBarUtil.showSnackBar(message: Strings.strEmailValidation);
    } else if (password.isEmpty) {
      SnackBarUtil.showSnackBar(message: Strings.strPleaseEnterPassword);
    } else if (password.trim().length < 8) {
      SnackBarUtil.showSnackBar(message: Strings.strPasswordValidation);
    } else {
      loginAccountWithEmail(email: email, password: password).then((value) {
        if (value == 'Login Successful') {
          SnackBarUtil.showSnackBar(message: 'Login Successful', success: true);
          Get.offAllNamed(RoutesConsts.homeScreen);
        } else {
          SnackBarUtil.showSnackBar(message: value.toString());
        }
      });
    }
  }

  Future<String> loginAccountWithEmail(
      {required String email, required String password}) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      return 'Login Successful';
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }

  Future logout() async {
    try {
      await auth.signOut();
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }

  Future<bool> isLoggedIn() async {
    var user = auth.currentUser;
    return user != null;
  }
}
