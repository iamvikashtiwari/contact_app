import 'package:contacts_app/imports.dart';

class CommonButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool isSecondButton;
  const CommonButton({
    super.key,
    required this.title,
    required this.onTap,
    this.isSecondButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: isSecondButton ? Colors.transparent : Colors.black87,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
                color: isSecondButton ? Colors.black87 : Colors.transparent)),
        child: TextView(
          text: title,
          fontSize: 16,
          textColor:
              isSecondButton ? AppColors.blackColor : AppColors.whiteColor,
          fontWeight: FontWeight.w800,
          textAlign: TextAlign.center,
        ).paddingSymmetric(vertical: 12),
      ).paddingSymmetric(horizontal: 20),
    );
  }
}
