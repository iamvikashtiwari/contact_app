import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextView extends StatelessWidget {
  const TextView({
    super.key,
    required this.text,
    this.fontSize = 15,
    this.fontFamily = '',
    this.textColor = Colors.white,
    this.fontWeight = FontWeight.normal,
    this.marginTop = 0,
    //this.textOverflow,
    this.lineheight,
    this.textAlign,
    this.textDecoration,
    this.maxLine,
    this.overflow,
    this.softWrap,
  });

  final TextDecoration? textDecoration;
  final int fontSize;
  final String text;
  final String fontFamily;
  final Color textColor;
  final FontWeight? fontWeight;
  final double marginTop;
  final int? maxLine;
  // final TextOverflow? textOverflow;
  final double? lineheight;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final bool? softWrap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: marginTop),
      child: Text(
        text,
        textAlign: textAlign,
        overflow: overflow,
        maxLines: maxLine,
        softWrap: softWrap,
        style: GoogleFonts.urbanist(
          textStyle: TextStyle(
            decoration: textDecoration,
            height: lineheight,
            fontSize: fontSize.toDouble(),
            fontFamily: fontFamily,
            fontWeight: fontWeight,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
