import '../../../../imports.dart';

class SignUpController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode emailNode = FocusNode();
  final FocusNode passwordNode = FocusNode();

  FirebaseAuth auth = FirebaseAuth.instance;

  signUpFunction({
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
      createAccountWithEmail(email: email, password: password).then((value) {
        if (value == 'Account Created') {
          SnackBarUtil.showSnackBar(message: 'Account Created', success: true);
          Get.offAllNamed(RoutesConsts.homeScreen);
        } else {
          SnackBarUtil.showSnackBar(message: value.toString());
        }
      });
    }
  }

  Future<String> createAccountWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      Get.focusScope!.unfocus();
      AppBaseComponent.instance.startLoading();
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      return 'Account Created';
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }
}
