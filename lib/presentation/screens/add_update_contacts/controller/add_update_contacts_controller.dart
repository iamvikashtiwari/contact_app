import '../../../../imports.dart';

class AddUpdateContactsController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final FocusNode nameNode = FocusNode();
  final FocusNode phoneNode = FocusNode();
  final FocusNode emailNode = FocusNode();

  User? user = FirebaseAuth.instance.currentUser;

  final arg = Get.arguments;
  var docId = '';
  var title = ''.obs;
  var isUpdatedContact = false.obs;

  @override
  void onInit() {
    super.onInit();
    if (arg != null && arg['isUpdatedContact'] == true) {
      nameController.text = arg['name'] ?? '';
      phoneController.text = arg['phone'] ?? '';
      emailController.text = arg['email'] ?? '';
      docId = arg['docId'] ?? '';
      isUpdatedContact.value = true;
      title.value = Strings.strUpdateContact;
    } else {
      isUpdatedContact.value = false;
      title.value = Strings.strAddContact;
    }
  }

  ///Add new contact function
  addNewContactFunction({
    required String name,
    required String phone,
    required String email,
  }) {
    KeyboardUtil.onCloseKeyboard();
    if (name.isEmpty) {
      SnackBarUtil.showSnackBar(message: Strings.strPleaseEnterName);
    } else if (phone.isEmpty) {
      SnackBarUtil.showSnackBar(message: Strings.strPleaseEnterPhone);
    } else if (!phone.contains('9') ||
        !phone.contains('8') ||
        !phone.contains('6')) {
      SnackBarUtil.showSnackBar(message: Strings.strPleaseValidPhone);
    } else if (phone.length > 10) {
      SnackBarUtil.showSnackBar(message: Strings.strPhoneValidation);
    } else if (email.isEmpty) {
      SnackBarUtil.showSnackBar(message: Strings.strPleaseEnterEmail);
    } else if (!email.isEmail) {
      SnackBarUtil.showSnackBar(message: Strings.strEmailValidation);
    } else {
      addNewContacts(name: name, phone: phone, email: email);
      nameController.clear();
      phoneController.clear();
      emailController.clear();
      Get.back();
    }
  }

  ///Add new contacts
  Future addNewContacts({
    required String name,
    required String phone,
    required String email,
  }) async {
    Map<String, dynamic> data = {
      'name': name,
      'phone': phone,
      'email': email,
    };
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .collection('contacts')
          .add(data);
      KLogger.prints('Document Added');
    } catch (e) {
      KLogger.prints(e.toString());
    }
  }

  ///update contact function
  updateContactFunction({
    required String name,
    required String phone,
    required String email,
  }) {
    KeyboardUtil.onCloseKeyboard();
    if (name.isEmpty) {
      SnackBarUtil.showSnackBar(message: Strings.strPleaseEnterName);
    } else if (phone.isEmpty) {
      SnackBarUtil.showSnackBar(message: Strings.strPleaseEnterPhone);
    } else if (!phone.contains('9') ||
        !phone.contains('8') ||
        !phone.contains('6')) {
      SnackBarUtil.showSnackBar(message: Strings.strPleaseValidPhone);
    } else if (phone.length > 10) {
      SnackBarUtil.showSnackBar(message: Strings.strPhoneValidation);
    } else if (email.isEmpty) {
      SnackBarUtil.showSnackBar(message: Strings.strPleaseEnterEmail);
    } else if (!email.isEmail) {
      SnackBarUtil.showSnackBar(message: Strings.strEmailValidation);
    } else {
      updatedContacts(name: name, phone: phone, email: email);
      nameController.clear();
      phoneController.clear();
      emailController.clear();
      Get.back();
    }
  }

  ///update contacts
  Future updatedContacts({
    required String name,
    required String phone,
    required String email,
  }) async {
    Map<String, dynamic> data = {
      'name': name,
      'phone': phone,
      'email': email,
    };
    try {
      if (docId.isNotEmpty) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .collection('contacts')
            .doc(docId)
            .update(data);
        KLogger.prints('Contact Updated');
      } else {
        SnackBarUtil.showSnackBar(
            message: 'Document ID is empty. Cannot update contact.');
      }
    } catch (e) {
      KLogger.prints(e.toString());
    }
  }

  ///delete contacts
  Future deleteContacts({
    required String docId,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .collection('contacts')
          .doc(docId)
          .delete();
      KLogger.prints('Delete Contact');
      SnackBarUtil.showSnackBar(message: Strings.strContactDeletedSuccessfully);
      Get.back();
    } catch (e) {
      KLogger.prints(e.toString());
    }
  }
}
