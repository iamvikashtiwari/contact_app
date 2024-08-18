// import 'dart:async';
//
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:lms_flutter/imports.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// class ConnectivityUtil {
//   void startNetworkCheck() {
//     Timer.periodic(const Duration(seconds: 1), (timer) {
//       _checkNetworkStatus();
//     });
//   }
//
//   void _checkNetworkStatus() async {
//     var connectivityResult = await Connectivity().checkConnectivity();
//
//     bool isConnected = (connectivityResult.first != ConnectivityResult.none);
//     if (!isConnected) {
//       _showNoConnectionDialog();
//     }
//   }
//
//   void _showNoConnectionDialog() {
//     if (Get.isDialogOpen == false) {
//       Get.dialog(
//         AlertDialog.adaptive(
//           title: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               // Image.asset(ImageAsset.appLogo, width: 50, height: 50),
//               TextView(
//                 text: LocalizationKeys.appName.tr,
//                 fontSize: 16,
//                 textAlign: TextAlign.center,
//                 fontWeight: FontWeight.w800,
//                 textColor: AppColors.whiteAndBlack(),
//               )
//             ],
//           ),
//           contentPadding:
//               const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
//           clipBehavior: Clip.hardEdge,
//           content: TextView(
//             text: LocalizationKeys.internetConnectionErrorString.tr,
//             fontSize: 16,
//             textAlign: TextAlign.center,
//             textColor: Theme.of(Get.context!).textTheme.titleLarge!.color!,
//             fontWeight: FontWeight.w400,
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Get.back();
//               },
//               style: const ButtonStyle(
//                 splashFactory: NoSplash.splashFactory,
//                 overlayColor: MaterialStatePropertyAll(Colors.transparent),
//               ),
//               isSemanticButton: true,
//               child: TextView(
//                 text: LocalizationKeys.close.tr,
//                 fontSize: 16,
//                 textAlign: TextAlign.center,
//                 textColor: Theme.of(Get.context!).textTheme.titleLarge!.color!,
//                 fontWeight: FontWeight.w400,
//               ),
//             ),
//           ],
//         ),
//       );
//     }
//   }
// }
//
// void showNoInternetDialog() {
//   showDialog(
//       context: Get.context!,
//       builder: (BuildContext context) {
//         return AlertDialog(
//             title: Text(
//               Strings.appName,
//               style: TextStyle(color: AppColors.whiteAndBlack()),
//             ),
//             content: Text(LocalizationKeys.internetConnectionErrorString.tr),
//             actions: <Widget>[
//               TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: const Text("Close"))
//             ]);
//       });
// }
//
// void launchUrlLink(String url) async {
//   try {
//     await launchUrl(Uri.parse(url));
//   } catch (e) {
//     throw 'Could not launch $url';
//   }
// }
