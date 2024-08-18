import 'package:contacts_app/imports.dart';
import 'package:contacts_app/presentation/screens/contacts/controller/contacts_controller.dart';

class ContactsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContactsController>(() => ContactsController());
  }
}
