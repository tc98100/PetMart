import 'package:cupertino_store/models/product.dart';
import 'package:cupertino_store/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemListRows extends StatelessWidget {
  ItemListRows(this.data);

  final Product data;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.zero,
      // onPressed: () => Navigator.push(context, new MaterialPageRoute(
      //     builder: (context) => petListing[index].path)
      // ),
      child: Card(
        color: appTheme.scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Row(children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(data.fbsPath),
            ),
          ),
          SizedBox(width: 10),
          Row(children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width / 1.9,
              height: MediaQuery.of(context).size.width / 3,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(2, 10, 5, 0),
                      child: Row(
                        children: <Widget>[
                          Text(data.name,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: appTheme.primaryColor)),
                          Text(
                            "\$" + data.price.toString(),
                            style: TextStyle(color: Colors.green),
                          ),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      ),
                    ),
                    Row(children: <Widget>[
                      Icon(
                        CupertinoIcons.location,
                        color: Colors.blueAccent,
                        size: (20),
                      ),
                      Text(
                        data.location,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent),
                      )
                    ]),
                    Expanded(
                      child: Container(
                        height: MediaQuery.of(context).size.height / 15,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 4.0, top: 4),
                          child: Text(
                            data.description,
                            style: TextStyle(height: 1.25, color: Colors.white),
                            maxLines:
                                (MediaQuery.of(context).size.height / 15 / 20)
                                    .round(),
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                          ),
                        ),
                      ),
                    ),
                  ]),
            ),
            Icon(
              CupertinoIcons.chevron_compact_right,
              color: appTheme.primaryColor,
            )
          ]),
        ]),
      ),
    );
  }
}
