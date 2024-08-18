import 'package:contacts_app/gen/assets.gen.dart';
import 'package:contacts_app/imports.dart';
import 'package:contacts_app/presentation/screens/home/controller/home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => controller.screens[controller.currentIndex.value]),
      bottomNavigationBar: Obx(() {
        return Theme(
          data: Theme.of(context).copyWith(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            currentIndex: controller.currentIndex.value,
            onTap: (index) {
              controller.currentIndex.value = index;
            },
            fixedColor: AppColors.greyColor,
            items: [
              BottomNavigationBarItem(
                icon: Container(
                    height: 30,
                    width: 60,
                    decoration: BoxDecoration(
                        color: controller.currentIndex.value == 0
                            ? AppColors.whiteColor
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(
                            controller.currentIndex.value == 0 ? 12 : 0),
                        border: Border.all(
                            color: controller.currentIndex.value == 0
                                ? AppColors.greyColor
                                : Colors.transparent)),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: const $AssetsPngsGen()
                          .icContact
                          .image(fit: BoxFit.scaleDown),
                    )),
                label: Strings.strContacts,
              ),
              BottomNavigationBarItem(
                icon: Container(
                    height: 30,
                    width: 60,
                    decoration: BoxDecoration(
                        color: controller.currentIndex.value == 1
                            ? AppColors.whiteColor
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(
                            controller.currentIndex.value == 1 ? 12 : 0),
                        border: Border.all(
                            color: controller.currentIndex.value == 1
                                ? AppColors.greyColor
                                : Colors.transparent)),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: const $AssetsPngsGen()
                          .icFavourite
                          .image(fit: BoxFit.scaleDown),
                    )),
                label: Strings.strFavorites,
              ),
            ],
          ),
        );
      }),
    );
  }
}
