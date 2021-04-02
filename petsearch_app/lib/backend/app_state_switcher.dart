import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:cupertino_store/forms/login_form.dart';
import 'package:cupertino_store/tabs/profile_tab.dart';

class AppStateSwitcher extends StatelessWidget {
  static const String route = "app_switcher";

  @override
  Widget build(BuildContext context) {
    final userState = Provider.of<User>(context);

    if (userState == null) {
      return LoginForm();
    }
    return ProfileTab();
  }
}
