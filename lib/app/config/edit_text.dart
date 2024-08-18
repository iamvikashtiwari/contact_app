import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class EditTextView extends TextField {
  EditTextView(
      {super.key,
      TextEditingController? controller,
      double fontSize = 16,
      FontWeight fontWeight = FontWeight.w500,
      super.textInputAction,
      TextInputType textInputType = TextInputType.text,
      List<TextInputFormatter>? inputFormatter,
      int super.maxLength = TextField.noMaxLength,
      Function(String)? onChange,
      super.obscureText,
      Color textColor = Colors.black,
      Color borderColor = Colors.black87 /*const Color(0XFFDFE0E1)*/,
      Decoration? decoration,
      InputDecoration? inputDecoration,
      OutlinedBorder? outlinedBorder,
      Border? border,
      ShapeBorder? shapeBorder,
      String hint = '',
      // String fontFamily: Fonts.poppinsRegular,
      bool super.enabled = true,
      Color fillColor = Colors.transparent,
      Color disabledColor = Colors.transparent,
      int maxLine = 1,
      int minLine = 1,
      bool hasIcon = false,
      Widget? prefixIcon,
      Widget? suffixIcon,
      // bool hasRightIcon,
      super.textAlign = TextAlign.left,
      // IconData rightIcons: null,
      double verticalPadding = 10,
      double horizontalPadding = 15,
      LengthLimitingTextInputFormatter? lengthLimitingTextInputFormatter,
      super.focusNode})
      : super(
          inputFormatters: inputFormatter,
          autocorrect: false,
          enableSuggestions: false,
          maxLines: maxLine,
          minLines: minLine,
          controller: controller ?? TextEditingController(),
          style: GoogleFonts.urbanist(
            textStyle: TextStyle(
              fontSize: fontSize,
              color: textColor,
              fontWeight: fontWeight,
            ),
          ),
          keyboardType: textInputType,
          onChanged: onChange,
          decoration: InputDecoration(
            hintStyle: const TextStyle(color: Color(0XFF808080)),
            counterText: '',
            hintText: hint,
            border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black87)),
            // counterStyle: const TextStyle(fontSize: 0),
            fillColor: fillColor,
            filled: true,
            contentPadding: EdgeInsets.symmetric(
                vertical: verticalPadding, horizontal: horizontalPadding),
            isDense: true,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: borderColor, width: 0.5)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: borderColor, width: 0.5)),
            disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: borderColor, width: 0.5)),
          ),
        );
}
