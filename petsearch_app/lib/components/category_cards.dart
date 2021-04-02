import 'package:cupertino_store/components/listing_page.dart';
import 'package:cupertino_store/models/category_card_data.dart';
import 'package:cupertino_store/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryCards extends StatelessWidget {
  CategoryCards(this.data);
  final CategoryCardData data;
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.zero,
      onPressed: () => data.path == null
          ? Navigator.of(context, rootNavigator: true)
              .pushNamed(ListingPageBase.route, arguments: {
              "title": data.cardName,
              "petName": data.dataBaseName,
              "size": data.petSize,
              "isItem": data.isItem == null ? false : true,
            })
          : Navigator.push(
              context, new MaterialPageRoute(builder: (context) => data.path)),
      child: Card(
        color: appTheme.scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Column(children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              "${data.imgPath}",
              width: MediaQuery.of(context).size.width / 2.4,
              height: MediaQuery.of(context).size.width / 2.4,
              fit: BoxFit.fill,
              alignment: Alignment.topCenter,
            ),
          ),
          SizedBox(
            height: 3.8,
          ),
          Padding(
              padding: EdgeInsets.zero,
              child: Text(
                "${data.cardName}",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.normal),
              )),
        ]),
      ),
    );
  }
}
