import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../imports.dart';

class ContactsController extends GetxController {
  User? user = FirebaseAuth.instance.currentUser;

  final arg = Get.arguments;
  var docId = '';
  var title = ''.obs;
  var isUpdatedContact = false.obs;
  var isSearching = false.obs;
  final TextEditingController searchController = TextEditingController();
  final FocusNode searchNode = FocusNode();
  var favorites = <String>[].obs;
  RxBool isFavourite = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadFavorites();
  }

  ///Get all contacts List
  Stream<QuerySnapshot> getContacts({String? searchQuery}) async* {
    var contactsQuery = FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('contacts')
        .orderBy('name');
    if (searchQuery != null && searchQuery.isNotEmpty) {
      String searchEnd = '$searchQuery\uf8ff';
      contactsQuery = contactsQuery.where('phone'.toLowerCase(),
          isGreaterThanOrEqualTo: searchQuery, isLessThan: searchEnd);
    }
    var contacts = contactsQuery.snapshots();
    yield* contacts;
  }

  void addToFavorites(String docId) {
    if (!favorites.contains(docId)) {
      favorites.add(docId);
      _saveFavorites();
    }
  }

  void removeFromFavorites(String docId) {
    if (favorites.contains(docId)) {
      favorites.remove(docId);
      _saveFavorites();
    }
  }

  void toggleFavorite(String contactId) {
    if (favorites.contains(contactId)) {
      favorites.remove(contactId);
    } else {
      favorites.add(contactId);
    }
    _saveFavorites();
  }

  bool isFavorite(String contactId) {
    return favorites.contains(contactId);
  }

  callingFunction({required String phone}) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phone);
    await launchUrl(launchUri);
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    SnackBarUtil.showSnackBar(message: Strings.strSignOutSuccessfully);
    Get.offAllNamed(RoutesConsts.signInScreen);
  }

  @override
  void dispose() {
    searchController.clear();
    super.dispose();
  }

  Future<void> _saveFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favorites', favorites.toList());
  }

  Future<void> _loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedFavorites = prefs.getStringList('favorites');
    if (savedFavorites != null) {
      favorites.addAll(savedFavorites);
    }
  }
}
