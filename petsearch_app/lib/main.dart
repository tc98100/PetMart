import 'package:cupertino_store/backend/auth_service.dart';
import 'package:cupertino_store/backend/app_state_switcher.dart';
import 'package:cupertino_store/components/listing_page.dart';
import 'package:cupertino_store/tabs/chat_screen.dart';
import 'package:cupertino_store/forms/login_form.dart';
import 'package:cupertino_store/tabs/create_listing_tab.dart';
import 'package:cupertino_store/tabs/create_review.dart';
import 'package:cupertino_store/tabs/profile_edit.dart';
import 'package:cupertino_store/tabs/profile_settings.dart';
import 'package:cupertino_store/tabs/reviews_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'backend/user_service.dart';
import 'forms/accessory_listing_form.dart';
import 'forms/pet_listing_form.dart';
import 'forms/signup_form.dart';
import 'models/user_model.dart';
import 'tabs/home_tab.dart';
import 'tabs/message_tab.dart';
import 'tabs/profile_tab.dart';
import 'tabs/search_tab.dart';
import 'theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

//  final cameras = await availableCameras();
//  final firstCamera = camexras.first;
  runApp(PetSearchApp());
}

class PetSearchApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // This app is designed only to work vertically, so we limit
    // orientations to portrait up and down.
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    // Create Stream<User> from Auth
    return StreamProvider<User>.value(
      value: AuthService().userState,
      child: StreamProvider<UserModel>(
          create: (_) => null,
          builder: (BuildContext context, Widget widget) {
            // User Stream<User> to create Stream<UserModel>
            return StreamProvider<UserModel>.value(
              value: UserService(Provider.of<User>(context) == null
                      ? ''
                      : Provider.of<User>(context).uid)
                  .userInfo,
              // Run Cupertino Main App
              child: CupertinoApp(
                theme: appTheme,
                home: HomePage(),
                routes: {
                  HomeTab.route: (_) => HomeTab(),
                  LoginForm.route: (_) => LoginForm(),
                  SignUpForm.route: (_) => SignUpForm(),
                  ProfileTab.route: (_) => ProfileTab(),
                  ProfileEdit.route: (_) => ProfileEdit(),
                  ProfileSettings.route: (_) => ProfileSettings(),
                  CreatePetListingForm.route: (_) => CreatePetListingForm(),
                  CreateAccessoryListingForm.route: (_) =>
                      CreateAccessoryListingForm(),
                  ChatScreen.route: (_) => ChatScreen(),
                  ReviewScreen.route: (_) => ReviewScreen(),
                  AppStateSwitcher.route: (_) => AppStateSwitcher(),
                  CreateReview.route: (_) => CreateReview(),
                  ListingPageBase.route: (_) => ListingPageBase(),
                },
              ),
            );
          }),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey formKey = GlobalKey<FormState>();

  List<BottomNavigationBarItem> navbar = [
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.home)),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.search)),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.plus_circled)),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.mail)),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.person)),
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
        tabBuilder: (BuildContext context, int index) {
          CupertinoTabView returnValue;
          switch (index) {
            case 0:
              returnValue = CupertinoTabView(builder: (context) {
                return CupertinoPageScaffold(
                  child: HomeTab(),
                );
              });
              break;
            case 1:
              returnValue = CupertinoTabView(builder: (context) {
                return CupertinoPageScaffold(
                  child: SearchTab(),
                );
              });
              break;
            case 2:
              returnValue = CupertinoTabView(builder: (context) {
                return CupertinoPageScaffold(
                  child: ListingTypeSelection(),
                );
              });
              break;
            case 3:
              returnValue = CupertinoTabView(builder: (context) {
                return CupertinoPageScaffold(
                  child: MessageTab(),
                );
              });
              break;
            case 4:
              returnValue = CupertinoTabView(builder: (context) {
                return CupertinoPageScaffold(
                  child: AppStateSwitcher(),
                );
              });
              break;
            default:
              return CupertinoTabView(builder: (context) {
                return CupertinoPageScaffold(
                  child: HomeTab(),
                );
              });
          }
          return returnValue;
        },
        tabBar: CupertinoTabBar(
          backgroundColor: appTheme.scaffoldBackgroundColor,
          items: navbar,
          activeColor: appTheme.primaryColor,
          iconSize: 25,
        ));
  }
}
