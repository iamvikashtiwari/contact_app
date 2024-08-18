import 'package:contacts_app/imports.dart';

import 'controller/contacts_controller.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  ContactsController get controller => Get.put(ContactsController());
  late Stream<QuerySnapshot> _stream;

  @override
  void initState() {
    super.initState();
    _stream = controller.getContacts();
  }

  onSearchChanged(String search) {
    _stream = controller.getContacts(searchQuery: search);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => controller.isSearching.value
            ? TextField(
                controller: controller.searchController,
                focusNode: controller.searchNode,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: 'Search contacts...',
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  onSearchChanged(value);
                  setState(() {});
                },
              )
            : TextView(
                text: Strings.strContacts,
                textColor: AppColors.blackColor,
                fontSize: 22,
                fontWeight: FontWeight.w800,
              )),
        actions: [
          IconButton(
            icon: Obx(() => Icon(
                controller.isSearching.value ? Icons.close : Icons.search)),
            onPressed: () {
              if (controller.isSearching.value) {
                controller.searchNode.unfocus();
                controller.isSearching.value = false;
                controller.searchController.clear();
                _stream = controller.getContacts();
                setState(() {});
              } else {
                controller.isSearching.value = true;
              }
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  child: TextView(
                    text: FirebaseAuth.instance.currentUser!.email
                        .toString()[0]
                        .toUpperCase(),
                    fontSize: 22,
                  ),
                ),
                const Gap(10),
                TextView(
                  text: FirebaseAuth.instance.currentUser!.email.toString(),
                  textColor: AppColors.blackColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ],
            )),
            ListTile(
              onTap: () => controller.signOut(),
              leading: const Icon(Icons.logout_outlined),
              title: TextView(
                text: Strings.strSignOut,
                textColor: AppColors.blackColor,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Get.toNamed(RoutesConsts.addUpdateContactScreen, arguments: {
          'isUpdatedContact': false,
        }),
        backgroundColor: AppColors.colorBECACC,
        child: const Icon(Icons.add), // Customize FAB background color
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _stream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const TextView(text: 'Something Went Wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const TextView(text: 'Loading');
          }
          return snapshot.data!.docs.isEmpty
              ? Center(
                  child: TextView(
                    text: 'Contacts Not Available',
                    textColor: AppColors.greyColor,
                    fontWeight: FontWeight.w200,
                    fontSize: 18,
                    textAlign: TextAlign.center,
                  ),
                )
              : ListView(
                  children: snapshot.data!.docs
                      .map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data()! as Map<String, dynamic>;
                        String contactId = document.id;
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
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Obx(() {
                                bool isFavorite =
                                    controller.isFavorite(contactId);
                                return IconButton(
                                  icon: Icon(
                                    isFavorite ? Icons.star : Icons.star_border,
                                    color:
                                        isFavorite ? AppColors.redColor : null,
                                  ),
                                  onPressed: () {
                                    controller.toggleFavorite(document.id);
                                    // setState(() {});
                                  },
                                );
                              }),
                              IconButton(
                                onPressed: () => controller.callingFunction(
                                    phone: data['phone'].toString()),
                                icon: const Icon(Icons.call),
                              ),
                            ],
                          ),
                        );
                      })
                      .toList()
                      .cast(),
                );
        },
      ),
    );
  }
}
