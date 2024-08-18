import 'package:contacts_app/presentation/screens/contacts/contacts_screen.dart';
import 'package:contacts_app/presentation/screens/favourite/favorites_screen.dart';

import '../../../../imports.dart';

class HomeController extends GetxController {
  RxInt currentIndex = 0.obs;

  final List<Widget> screens = [
    const ContactsScreen(),
    const FavoritesScreen(),
  ];
}
