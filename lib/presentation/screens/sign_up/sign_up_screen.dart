import '../../../imports.dart';
import 'controller/sign_up_controller.dart';

class SignUpScreen extends GetView<SignUpController> {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Gap(Get.height / 7),
              const TextView(
                text: Strings.strSignUp,
                textColor: Colors.black,
                textAlign: TextAlign.center,
                fontSize: 30,
              ),
              const Gap(15),
              textTitle(Strings.strEmail),
              CommonEditText(
                hintText: Strings.strEmail,
                textEditingController: controller.emailController,
                focusNode: controller.emailNode,
              ),
              const Gap(20),
              textTitle(Strings.strPassword),
              CommonEditText(
                hintText: Strings.strPassword,
                textEditingController: controller.passwordController,
                focusNode: controller.passwordNode,
                isPassword: true.obs,
              ),
              const Gap(30),
              CommonButton(
                title: Strings.strSignUp,
                onTap: () => controller.signUpFunction(
                    email: controller.emailController.text.trim(),
                    password: controller.passwordController.text.trim()),
              ),
              const Gap(15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextView(
                    text: Strings.strAlreadyHaveAnAccount,
                    fontSize: 16,
                    textColor: AppColors.lightGreyColor,
                    fontWeight: FontWeight.w500,
                    textAlign: TextAlign.center,
                  ),
                  GestureDetector(
                    onTap: () => Get.offAllNamed(RoutesConsts.signInScreen),
                    child: TextView(
                      text: Strings.strSignIn,
                      fontSize: 16,
                      textColor: AppColors.blackColor,
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.center,
                      textDecoration: TextDecoration.underline,
                    ).paddingOnly(left: 10),
                  ),
                ],
              )
            ],
          ),
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
