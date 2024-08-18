import 'package:contacts_app/app/routes/bindings/contacts_binding.dart';
import 'package:contacts_app/imports.dart';
import 'package:contacts_app/presentation/screens/add_update_contacts/add_update_contact_screen.dart';
import 'package:contacts_app/presentation/screens/contacts/contacts_screen.dart';
import 'package:contacts_app/presentation/screens/home/home_screen.dart';
import 'package:contacts_app/presentation/screens/sign_in/sign_in_screen.dart';
import 'package:contacts_app/presentation/screens/sign_up/sign_up_screen.dart';

import 'bindings/add_update_binding.dart';
import 'bindings/home_binding.dart';
import 'bindings/sign_in_binding.dart';
import 'bindings/sign_up_binding.dart';

class Pages {
  static final pages = [
    // GetPage(
    //   name: Routes.onBoardingScreen,
    //   page: () => const OnBoardingScreen(),
    // ),
    GetPage(
        name: RoutesConsts.signInScreen,
        page: () => const SignInScreen(),
        binding: SignInBinding()),
    GetPage(
        name: RoutesConsts.signUpScreen,
        page: () => const SignUpScreen(),
        binding: SignUpBinding()),
    GetPage(
        name: RoutesConsts.homeScreen,
        page: () => const HomeScreen(),
        binding: HomeBinding()),
    GetPage(
        name: RoutesConsts.contactsScreen,
        page: () => const ContactsScreen(),
        binding: ContactsBinding()),
    GetPage(
        name: RoutesConsts.addUpdateContactScreen,
        page: () => const AddUpdateContactScreen(),
        binding: AddUpdateContactsBinding()),
  ];
}
