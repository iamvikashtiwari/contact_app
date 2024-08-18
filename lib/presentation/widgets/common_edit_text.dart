import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonEditText extends StatelessWidget {
  final TextEditingController textEditingController;
  final FocusNode focusNode;
  final String hintText;
  final RxBool isPassword;
  final TextInputType keyboardType;
  late final RxBool isObscured;

  CommonEditText({
    super.key,
    required this.textEditingController,
    required this.focusNode,
    this.hintText = '',
    this.keyboardType = TextInputType.text,
    RxBool? isPassword,
    // this.isPassword,
  }) : isPassword = isPassword ?? RxBool(false) {
    // Default to false if not provided
    isObscured = RxBool(this
        .isPassword
        .value); // Initialize isObscured based on isPassword's initial value
  }

  /*: isObscured = isPassword!.value ? true.obs : false.obs;*/

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return TextField(
        controller: textEditingController,
        focusNode: focusNode,
        obscureText: isPassword.value ? isObscured.value : false,
        cursorColor: Colors.grey,
        textInputAction: TextInputAction.next,
        onEditingComplete: () => FocusScope.of(context).nextFocus(),
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey),
          counterText: '',
          border: const OutlineInputBorder(),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          suffixIcon: isPassword.value
              ? GestureDetector(
                  onTap: () => isObscured.toggle(),
                  child: Icon(isObscured.value
                      ? Icons.visibility_off
                      : Icons.visibility),
                )
              : null,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400, width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400, width: 1.0),
          ),
        ),
      );
    }).paddingSymmetric(horizontal: 20);
  }
}
