import 'package:flutter/cupertino.dart';
class KeyboardUtil {
 static void onCloseKeyboard() {
    FocusManager.instance.primaryFocus!.unfocus();
  }
}