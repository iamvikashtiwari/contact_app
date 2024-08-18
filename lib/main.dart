import 'package:contacts_app/firebase_options.dart';
import 'package:contacts_app/imports.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'app/routes/pages.dart';
import 'presentation/widgets/custom_scroll_behaviour.dart';

// C:\softwares\3.22.2\flutter\bin

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: Strings.strAppName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      getPages: Pages.pages,
      initialRoute: FirebaseAuth.instance.currentUser != null
          ? RoutesConsts.homeScreen
          : RoutesConsts.signInScreen,
      builder: (context, child) {
        return Stack(
          children: [
            Positioned.fill(
              child: SafeArea(
                child: Container(
                  color: AppColors.primaryLightColor,
                  child:
                      const $AssetsPngsGen().background.image(fit: BoxFit.fill),
                ),
              ),
            ),
            ScrollConfiguration(
              behavior: CustomScrollBehaviour(),
              child: child!,
            ),
            StreamBuilder<bool>(
              initialData: false,
              stream: AppBaseComponent.instance.progressStream,
              builder: (context, snapshot) {
                return Obx(
                  () => AppBaseComponent.instance.completed.value
                      ? const Offstage()
                      : Positioned.fill(
                          child: AnimatedOpacity(
                            opacity: snapshot.data! ? 1 : 0,
                            duration: const Duration(milliseconds: 200),
                            child: Container(
                              color: Colors.black.withOpacity(0.3),
                              child: Center(
                                child: LoadingAnimationWidget.discreteCircle(
                                    color: AppColors.primaryLightColor,
                                    size: 40),
                              ),
                            ),
                          ),
                        ),
                );
              },
            ),
            StreamBuilder<bool>(
              initialData: true,
              stream: AppBaseComponent.instance.networkStream,
              builder: (context, snapshot) {
                return Positioned(
                    top: 0,
                    child: SafeArea(
                      child: AnimatedContainer(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: AppColors.primaryLightColor,
                            boxShadow: [
                              BoxShadow(
                                  offset: const Offset(0, 0),
                                  blurRadius: 14,
                                  spreadRadius: 0,
                                  color: AppColors.shadowColor)
                            ],
                            borderRadius: const BorderRadius.vertical(
                                bottom: Radius.circular(15))),
                        height: snapshot.data! ? 0 : 100,
                        width: Get.width,
                        curve: Curves.decelerate,
                        duration: const Duration(seconds: 1),
                        child: Material(
                          type: MaterialType.transparency,
                          child: Text(
                            Strings.strNoInternetAvailable,
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                                color: AppColors.whiteColor, fontSize: 18),
                          ),
                        ),
                      ),
                    ));
              },
            )
          ],
        );
      },
    );
  }
}
