// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cupertino_store/components/category_list.dart';
import 'package:cupertino_store/components/category_page.dart';
import 'package:cupertino_store/components/category_subtitle.dart';
import 'package:cupertino_store/components/item_list.dart';
import 'package:cupertino_store/components/listing_page.dart';
import 'package:cupertino_store/components/search_bar.dart';
import 'package:cupertino_store/components/segmented_control.dart';
import 'package:cupertino_store/forms/accessory_listing_form.dart';
import 'package:cupertino_store/forms/login_form.dart';
import 'package:cupertino_store/forms/pet_listing_form.dart';
import 'package:cupertino_store/forms/signup_form.dart';
import 'package:cupertino_store/models/category_list_data.dart';
import 'package:cupertino_store/models/listing_page_data.dart';
import 'package:cupertino_store/tabs/create_listing_tab.dart';
import 'package:cupertino_store/tabs/create_review.dart';
import 'package:cupertino_store/tabs/home_tab.dart';
import 'package:cupertino_store/tabs/message_tab.dart';
import 'package:cupertino_store/tabs/profile_edit.dart';
import 'package:cupertino_store/tabs/profile_settings.dart';
import 'package:cupertino_store/tabs/profile_tab.dart';
import 'package:cupertino_store/tabs/reviews_screen.dart';
import 'package:cupertino_store/tabs/search_tab.dart';
import 'package:mockito/mockito.dart';
import 'package:cupertino_store/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class MockFirestore extends Mock implements FirebaseFirestore {}

final UserModel dummyUserA = UserModel(
    userId: 'a',
    firstName: 'first-a',
    lastName: 'last-a',
    username: 'user-a',
    sumRatings: 1,
    countRatings: 2,
    profilePhoto: File('profilePhoto-a'),
    profilePath: 'profilePath-a',
    bio: 'bio-a');

final UserModel dummyUserB = UserModel(
    userId: 'b',
    firstName: 'first-b',
    lastName: 'last-b',
    username: 'user-b',
    sumRatings: 5,
    countRatings: 5,
    profilePhoto: File('profilePhoto-b'),
    profilePath: 'profilePath-b',
    bio: 'bio-b');

Widget createMaterialApp(Widget child) {
  return MaterialApp(
    home: child,
  );
}

Widget createMediaQueryApp(Widget child) {
  return MediaQuery(
    data: MediaQueryData(),
    child: createMaterialApp(child),
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Widget Test: SearchBar', (WidgetTester tester) async {
    createMaterialApp(SearchBar((a, b) => {}, 0));
  });

  testWidgets('Widget Test: ItemList', (WidgetTester tester) async {
    ListingPageData listingPageData = ListingPageData(
      products: [],
      title: "title",
    );
    createMaterialApp(ItemList(listingPageData));
  });

  testWidgets('Widget Test: CategoryList', (WidgetTester tester) async {
    CategoryListData categoryListData = CategoryListData(
      cards: [],
      title: "title",
    );
    createMaterialApp(CategoryList(categoryListData));
  });

  testWidgets('Widget Test: CategoryPage', (WidgetTester tester) async {
    CategoryListData categoryListData = CategoryListData(
      cards: [],
      title: "title",
    );
    createMaterialApp(
        CategoryPage('title', categoryListData, categoryListData));
  });

  testWidgets('Widget Test: CategorySubtitle', (WidgetTester tester) async {
    createMaterialApp(CategorySubtitle('Subtitle'));
  });

  testWidgets('Widget Test: ListingPage', (WidgetTester tester) async {
    createMaterialApp(ListingPage('category'));
  });

  testWidgets('Widget Test: SegmentedControl', (WidgetTester tester) async {
    createMaterialApp(SegmentedControl((a) => {}, 0));
  });

  testWidgets('Widget Test: CreateAccessoryListingForm',
      (WidgetTester tester) async {
    createMaterialApp(CreateAccessoryListingForm());
  });

  testWidgets('Widget Test: LoginForm', (WidgetTester tester) async {
    createMaterialApp(LoginForm());
  });

  testWidgets('Widget Test: CreatePetListingForm', (WidgetTester tester) async {
    createMaterialApp(CreatePetListingForm());
  });

  testWidgets('Widget Test: SignUpForm', (WidgetTester tester) async {
    createMaterialApp(SignUpForm());
  });

  testWidgets('Widget Test: ListingTypeSelection', (WidgetTester tester) async {
    createMaterialApp(ListingTypeSelection());
  });

  testWidgets('Widget Test: CreateReview', (WidgetTester tester) async {
    createMaterialApp(CreateReview());
  });

  testWidgets('Widget Test: HomeTab', (WidgetTester tester) async {
    createMaterialApp(HomeTab());
  });

  testWidgets('Widget Test: MessageTab', (WidgetTester tester) async {
    createMaterialApp(MessageTab());
  });

  testWidgets('Widget Test: ProfileEdit', (WidgetTester tester) async {
    createMaterialApp(ProfileEdit());
  });

  testWidgets('Widget Test: ProfileSettings', (WidgetTester tester) async {
    createMaterialApp(ProfileSettings());
  });

  testWidgets('Widget Test: ProfileTab', (WidgetTester tester) async {
    createMaterialApp(ProfileTab());
  });

  testWidgets('Widget Test: ReviewScreen', (WidgetTester tester) async {
    createMaterialApp(ReviewScreen());
  });

  testWidgets('Widget Test: SearchTab', (WidgetTester tester) async {
    createMaterialApp(SearchTab());
  });

  /*
  testWidgets('Widget Test: PetSearchApp - Create new app.', (WidgetTester tester) async {
    // Does not work with current firebase setup.

    // Build our app and trigger a frame.
    await tester.pumpWidget(PetSearchApp());
    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);

  });
  */
}
