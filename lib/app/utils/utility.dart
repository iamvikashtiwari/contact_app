// import 'package:flutter/material.dart';
// import 'package:flutter_styled_toast/flutter_styled_toast.dart';
// import 'package:get/get.dart';
// import 'package:lms_flutter/models/quiz_model.dart';
// import 'package:lms_flutter/shared/constants/app_colors.dart';
//
// class Utility {
//   static void showToastMessage(message) {
//     showToast(
//       message,
//       context: Get.context!,
//       animation: StyledToastAnimation.slideFromBottom,
//       reverseAnimation: StyledToastAnimation.fade,
//       position: StyledToastPosition.top,
//       animDuration: const Duration(milliseconds: 500),
//       duration: const Duration(seconds: 3),
//       curve: Curves.elasticOut,
//       reverseCurve: Curves.linear,
//     );
//   }
//
//   static void hideKeyboard(BuildContext context) {
//     FocusScope.of(context).requestFocus(FocusNode());
//   }
//
//   static PopupMenuItem buildPopupMenuItemOld(
//       String title, IconData? iconData, int position) {
//     return PopupMenuItem(
//       value: position,
//       child: Row(
//         children: [
//           if (iconData != null)
//             Icon(
//               iconData,
//               size: 20,
//               color: Colors.black,
//             ),
//           if (iconData != null)
//             const SizedBox(
//               width: 10,
//             ),
//           Text(
//             title,
//             style: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
//           ),
//         ],
//       ),
//     );
//   }
//
//   static PopupMenuEntry<int> buildPopupMenuItem(int value, String text) {
//     return PopupMenuItem<int>(
//       value: value,
//       child: Text(text),
//     );
//   }
//
//
//   static bool isValidUrl(String? str,
//       {List<String?> protocols = const ['http', 'https', 'ftp'],
//       bool requireTld = true,
//       bool requireProtocol = false,
//       bool allowUnderscore = false,
//       List<String> hostWhitelist = const [],
//       List<String> hostBlacklist = const []}) {
//     if (str == null ||
//         str.length == 0 ||
//         str.length > 2083 ||
//         str.startsWith('mailto:')) {
//       return false;
//     }
//
//     var protocol,
//         user,
//         auth,
//         host,
//         hostname,
//         port,
//         port_str,
//         path,
//         query,
//         hash,
//         split;
//
//     // check protocol
//     split = str.split('://');
//     if (split.length > 1) {
//       protocol = shift(split);
//       if (protocols.indexOf(protocol) == -1) {
//         return false;
//       }
//     } else if (requireProtocol == true) {
//       return false;
//     }
//     str = split.join('://');
//
//     // check hash
//     split = str!.split('#');
//     str = shift(split);
//     hash = split.join('#');
//     if (hash != null && hash != "" && new RegExp(r'\s').hasMatch(hash)) {
//       return false;
//     }
//
//     // check query params
//     split = str!.split('?');
//     str = shift(split);
//     query = split.join('?');
//     if (query != null && query != "" && new RegExp(r'\s').hasMatch(query)) {
//       return false;
//     }
//
//     // check path
//     split = str!.split('/');
//     str = shift(split);
//     path = split.join('/');
//     if (path != null && path != "" && new RegExp(r'\s').hasMatch(path)) {
//       return false;
//     }
//
//     // check auth type urls
//     split = str!.split('@');
//     if (split.length > 1) {
//       auth = shift(split);
//       if (auth.indexOf(':') >= 0) {
//         auth = auth.split(':');
//         user = shift(auth);
//         if (!new RegExp(r'^\S+$').hasMatch(user)) {
//           return false;
//         }
//         if (!new RegExp(r'^\S*$').hasMatch(user)) {
//           return false;
//         }
//       }
//     }
//
//     // check hostname
//     hostname = split.join('@');
//     split = hostname.split(':');
//     host = shift(split);
//     if (split.length > 0) {
//       port_str = split.join(':');
//       try {
//         port = int.parse(port_str, radix: 10);
//       } catch (e) {
//         return false;
//       }
//       if (!new RegExp(r'^[0-9]+$').hasMatch(port_str) ||
//           port <= 0 ||
//           port > 65535) {
//         return false;
//       }
//     }
//
//     if (!isIP(host) &&
//         !isFQDN(host,
//             requireTld: requireTld, allowUnderscores: allowUnderscore) &&
//         host != 'localhost') {
//       return false;
//     }
//
//     if (hostWhitelist.isNotEmpty && !hostWhitelist.contains(host)) {
//       return false;
//     }
//
//     if (hostBlacklist.isNotEmpty && hostBlacklist.contains(host)) {
//       return false;
//     }
//
//     return true;
//   }
//
//   static shift(List l) {
//     if (l.isNotEmpty) {
//       var first = l.first;
//       l.removeAt(0);
//       return first;
//     }
//     return null;
//   }
//
//   static final RegExp _ipv4Maybe =
//       RegExp(r'^(\d?\d?\d)\.(\d?\d?\d)\.(\d?\d?\d)\.(\d?\d?\d)$');
//   static final RegExp _ipv6 =
//       RegExp(r'^::|^::1|^([a-fA-F0-9]{1,4}::?){1,7}([a-fA-F0-9]{1,4})$');
//
//   static bool isIP(String? str, [/*<String | int>*/ version]) {
//     version = version.toString();
//     if (version == 'null') {
//       return isIP(str, 4) || isIP(str, 6);
//     } else if (version == '4') {
//       if (!_ipv4Maybe.hasMatch(str!)) {
//         return false;
//       }
//       var parts = str.split('.');
//       parts.sort((a, b) => int.parse(a) - int.parse(b));
//       return int.parse(parts[3]) <= 255;
//     }
//     return version == '6' && _ipv6.hasMatch(str!);
//   }
//
//   /// check if the string [str] is a fully qualified domain name (e.g. domain.com).
//   ///
//   /// * [requireTld] sets if TLD is required
//   /// * [allowUnderscore] sets if underscores are allowed
//   static bool isFQDN(String str,
//       {bool requireTld = true, bool allowUnderscores = false}) {
//     var parts = str.split('.');
//     if (requireTld) {
//       var tld = parts.removeLast();
//       if (parts.length == 0 || !new RegExp(r'^[a-z]{2,}$').hasMatch(tld)) {
//         return false;
//       }
//     }
//
//     for (var part in parts) {
//       if (allowUnderscores) {
//         if (part.contains('__')) {
//           return false;
//         }
//       }
//       if (!new RegExp(r'^[a-z\\u00a1-\\uffff0-9-]+$').hasMatch(part)) {
//         return false;
//       }
//       if (part[0] == '-' ||
//           part[part.length - 1] == '-' ||
//           part.indexOf('---') >= 0) {
//         return false;
//       }
//     }
//     return true;
//   }
//
//   static String extractPriceValue(String input) {
//     RegExp regex = RegExp(r'[\d,.]+');
//     String priceValue = regex.stringMatch(input)?.replaceAll(',', '') ?? '';
//     return priceValue;
//   }
//
//   static int _getMaxWidthFromWidths(String? widths) {
//     if (widths != null) {
//       final widthList = widths
//           .replaceAll(RegExp(r'[\[\]]'), '')
//           .split(',')
//           .map((e) => int.tryParse(e.trim()))
//           .where((e) => e != null)
//           .cast<int>()
//           .toList();
//       if (widthList.isNotEmpty) {
//         return widthList.reduce((max, width) => width > max ? width : max);
//       }
//     }
//     return 0;
//   }
//
//   static Color getColorFromQuizLevel(Level level) {
//     switch (level) {
//       case Level.EASY:
//         return AppColors.color92D050;
//       case Level.MEDIUM:
//         return AppColors.colorFFC000;
//       case Level.DIFFICULT:
//         return AppColors.colorFF4343;
//       default:
//         return AppColors.primaryColor;
//     }
//   }
//
//   static Color getColorFromQuizLevelStringType(String level) {
//     switch (level) {
//       case "easy":
//         return AppColors.color92D050;
//       case "medium":
//         return AppColors.colorFFC000;
//       case "difficult":
//         return AppColors.colorFF4343;
//       default:
//         return AppColors.primaryColor;
//     }
//   }
//
//   static Color getColorFromResultLevelStringType(String level) {
//     switch (level) {
//       case "pass":
//         return AppColors.color92D050;
//       case "failed":
//         return AppColors.colorFF4343;
//       case "":
//         return Colors.transparent;
//       default:
//         return AppColors.primaryColor;
//     }
//   }
//
//   static String getStringFromLevel(Level level) {
//     switch (level) {
//       case Level.EASY:
//         return "Easy";
//       case Level.MEDIUM:
//         return "Medium";
//       case Level.DIFFICULT:
//         return "Difficult";
//       default:
//         return "";
//     }
//   }
//
//   static String getStringFromLevelStringType(String level) {
//     switch (level) {
//       case "easy":
//         return "Easy";
//       case "medium":
//         return "Medium";
//       case "difficult":
//         return "difficult";
//       default:
//         return "";
//     }
//   }
// }
