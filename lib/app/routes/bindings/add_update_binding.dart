import 'package:contacts_app/imports.dart';
import 'package:contacts_app/presentation/screens/add_update_contacts/controller/add_update_contacts_controller.dart';

class AddUpdateContactsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddUpdateContactsController>(
        () => AddUpdateContactsController());
  }
}
