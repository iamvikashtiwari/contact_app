import 'package:contacts_app/imports.dart';
import 'package:contacts_app/presentation/screens/sign_up/controller/sign_up_controller.dart';

class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpController>(() => SignUpController());
  }
}
