import 'package:contacts_app/imports.dart';
import 'package:contacts_app/presentation/screens/sign_in/controller/sign_in_controller.dart';

class SignInBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignInController>(() => SignInController());
  }
}
