import 'package:contacts_app/imports.dart';

class SnackBarUtil {
  static void showSnackBar(
      {String? title,
      required String message,
      Duration? duration,
      bool? success}) {
    Get.closeCurrentSnackbar();
    Get.showSnackbar(GetSnackBar(
      messageText: Text(
        message,
        style: TextStyle(
          color: AppColors.whiteColor,
          fontSize: 15,
        ),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      animationDuration: const Duration(milliseconds: 600),
      duration: duration ?? const Duration(seconds: 6),
      snackPosition: SnackPosition.BOTTOM,
      borderRadius: 8,
      boxShadows: [BoxShadow(color: AppColors.shadowColor, blurRadius: 10)],
      barBlur: 0,
      backgroundColor:
          (success ?? false) ? AppColors.color46B203 : AppColors.redColor,
      snackStyle: SnackStyle.FLOATING,
    ));
  }
}
