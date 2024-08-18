import 'package:contacts_app/imports.dart';
import 'package:contacts_app/presentation/screens/contacts/controller/contacts_controller.dart';

class FavoritesScreen extends GetView<ContactsController> {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextView(
          text: Strings.strFavorites,
          textColor: AppColors.blackColor,
          fontSize: 22,
          fontWeight: FontWeight.w800,
        ),
      ),
      body: Obx(() {
        if (controller.favorites.isEmpty) {
          return Center(
            child: TextView(
              text: Strings.strNoFavorites,
              textColor: AppColors.greyColor,
              fontWeight: FontWeight.w200,
              fontSize: 18,
              textAlign: TextAlign.center,
            ),
          );
        }

        return StreamBuilder<QuerySnapshot>(
          stream: controller.getContacts(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const TextView(text: 'Something Went Wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const TextView(text: 'Loading');
            }

            var favoriteDocs = snapshot.data!.docs
                .where((doc) => controller.favorites.contains(doc.id))
                .toList();

            if (favoriteDocs.isEmpty) {
              return Center(
                child: TextView(
                  text: 'No Favorites',
                  textColor: AppColors.greyColor,
                  fontWeight: FontWeight.w200,
                  fontSize: 18,
                  textAlign: TextAlign.center,
                ),
              );
            }

            return ListView(
              children: favoriteDocs
                  .map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    return ListTile(
                      onTap: () {
                        Get.toNamed(RoutesConsts.addUpdateContactScreen,
                            arguments: {
                              'name': data['name'],
                              'phone': data['phone'],
                              'email': data['email'],
                              'docId': document.id,
                              'isUpdatedContact': true,
                            });
                      },
                      leading: CircleAvatar(
                        child: TextView(
                          text: data['name'][0],
                        ),
                      ),
                      title: TextView(
                        text: data['name'],
                        textColor: AppColors.blackColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      subtitle: TextView(
                        text: data['phone'],
                        textColor: AppColors.blackColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                      ),
                      trailing: IconButton(
                        onPressed: () => controller.callingFunction(
                            phone: data['phone'].toString()),
                        icon: const Icon(Icons.call),
                      ),
                    );
                  })
                  .toList()
                  .cast(),
            );
          },
        );
      }),
    );
  }
}
