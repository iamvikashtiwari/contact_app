import 'package:contacts_app/imports.dart';
import 'package:contacts_app/presentation/screens/contacts/controller/contacts_controller.dart';
import 'package:contacts_app/presentation/screens/home/controller/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<ContactsController>(() => ContactsController());
  }
}
