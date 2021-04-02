import 'package:cupertino_store/forms/accessory_listing_form.dart';
import 'package:cupertino_store/forms/pet_listing_form.dart';
import 'package:cupertino_store/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../theme.dart';

class ListingTypeSelection extends StatelessWidget {
  static const String route = 'listing_type';

  @override
  Widget build(BuildContext context) {
    return Container(
      color: appTheme.scaffoldBackgroundColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Create a New Listing",
              style: gradientText(30),
            ),
            SizedBox(height: 50.0),
            GestureDetector(
              onTap: () {
                Navigator.of(context, rootNavigator: true)
                    .pushNamed(CreatePetListingForm.route);
              },
              child: Container(
                  height: 100,
                  width: 300,
                  decoration: gradientBorder,
                  child: Center(child: Text('Pet', style: title(18)))),
            ),
            SizedBox(height: 15.0),
            GestureDetector(
              onTap: () {
                Navigator.of(context, rootNavigator: true)
                    .pushNamed(CreateAccessoryListingForm.route);
              },
              child: Container(
                  height: 100,
                  width: 300,
                  decoration: gradientBorder,
                  child: Center(child: Text("Accessories", style: title(18)))),
            ),
          ],
        ),
      ),
    );
  }
}
