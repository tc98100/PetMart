import 'package:cupertino_store/models/listing_page_data.dart';
import 'package:cupertino_store/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../theme.dart';

class SearchBar extends StatefulWidget {
  final Function(bool, List<String>) getResult;
  final int textState;

  SearchBar(this.getResult, this.textState);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  ListingPageData searchResults;
  Function(bool, List<String>) getResult;
  bool userInput = false;
  Widget list;
  final TextEditingController _txtTask = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Padding(
      padding: EdgeInsets.all(10),
      child: Container(
          child: DarkTextField(
        obscureText: false,
        controller: _txtTask,
        onChanged: (value) {
          if (_txtTask.text.length == 0) {
            userInput = false;
            widget.getResult(userInput, null);
          } else {
            userInput = true;
            String lowerInput = _txtTask.text.toLowerCase();
            List<String> input = lowerInput.split(" ");
            widget.getResult(userInput, input);
          }
        },
        prefix: Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Icon(
            CupertinoIcons.search,
            color: appTheme.primaryColor,
          ),
        ),
        placeholder: widget.textState == 0
            ? 'Search for pets'
            : 'Search for accessories',
      )),
    ));
  }
}
