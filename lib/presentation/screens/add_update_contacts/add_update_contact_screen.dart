import 'package:contacts_app/imports.dart';
import 'package:contacts_app/presentation/screens/add_update_contacts/controller/add_update_contacts_controller.dart';

class AddUpdateContactScreen extends GetView<AddUpdateContactsController> {
  const AddUpdateContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() {
          return TextView(
            text: controller.title.value,
            textColor: AppColors.blackColor,
            fontSize: 22,
            fontWeight: FontWeight.w800,
          );
        }),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            textTitle(Strings.strName),
            CommonEditText(
              hintText: Strings.strName,
              textEditingController: controller.nameController,
              focusNode: controller.nameNode,
            ),
            const Gap(15),
            textTitle(Strings.strPhone),
            CommonEditText(
              hintText: Strings.strPhone,
              textEditingController: controller.phoneController,
              focusNode: controller.phoneNode,
              keyboardType: TextInputType.number,
            ),
            const Gap(15),
            textTitle(Strings.strEmail),
            CommonEditText(
              hintText: Strings.strEmail,
              textEditingController: controller.emailController,
              focusNode: controller.emailNode,
            ),
            const Gap(30),
            Obx(() {
              return CommonButton(
                title: controller.title.value,
                onTap: () {
                  if (controller.isUpdatedContact.value) {
                    print('@@@vikash');
                    controller.updateContactFunction(
                      name: controller.nameController.text.trim(),
                      phone: controller.phoneController.text.trim(),
                      email: controller.emailController.text.trim(),
                    );
                  } else {
                    print('@@@tiwaeri');
                    controller.addNewContactFunction(
                      name: controller.nameController.text.trim(),
                      phone: controller.phoneController.text.trim(),
                      email: controller.emailController.text.trim(),
                    );
                  }
                },
              );
            }),
            Visibility(
              visible: controller.isUpdatedContact.value,
              child: CommonButton(
                title: Strings.strDeleteContact,
                onTap: () => controller.deleteContacts(docId: controller.docId),
                isSecondButton: true,
              ).paddingOnly(top: 20),
            ),
          ],
        ),
      ),
    );
  }

  Widget textTitle(String title) {
    return TextView(
      text: title,
      fontSize: 16,
      textColor: AppColors.blackColor,
      fontWeight: FontWeight.w500,
    ).paddingOnly(left: 25);
  }
}
