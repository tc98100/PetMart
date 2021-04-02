import 'package:cupertino_store/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomButton extends StatefulWidget {
  final Widget child;
  final Function onPressed;

  const CustomButton({@required this.child, @required this.onPressed});

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      child: widget.child,
      onPressed: widget.onPressed,
      color: appTheme2.accentColor,
      padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.height * 0.04, 0,
          MediaQuery.of(context).size.height * 0.04, 0),
    );
  }
}

class AlertBox {
  final String title;
  final String content;

  AlertBox({this.title, this.content});

  void dialog(BuildContext context) {
    showCupertinoDialog(
        context: context,
        builder: (BuildContext context) => Theme(
              data: ThemeData.dark(),
              child: CupertinoAlertDialog(
                title: Text(
                  title,
                  style: gradientText(20),
                ),
                content: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    content,
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                actions: [
                  CupertinoDialogAction(
                    isDefaultAction: true,
                    child: Text('Close', style: gradientText(20)),
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop("close");
                    },
                  )
                ],
              ),
            ),
        barrierDismissible: false);
  }
}

class LoadingScreen extends StatelessWidget {
  final String message;

  LoadingScreen({this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SpinKitWave(
            color: Colors.red,
            size: MediaQuery.of(context).size.height * titleSize,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * padding,
          ),
          Text(
            message,
            style: gradientText(MediaQuery.of(context).size.height * titleSize),
          )
        ],
      )),
    );
  }
}

class DarkTextField extends StatefulWidget {
  final String placeholder;
  final Widget prefix;
  final bool obscureText;
  final void Function(String) onChanged;
  final TextInputType keyboardType;
  final int maxLines;
  final TextEditingController controller;
  final void Function(String) onSubmitted;
  final FocusNode focusNode;
  final TextStyle textStyle;

  const DarkTextField(
      {this.placeholder,
      this.prefix,
      this.obscureText,
      this.keyboardType,
      this.maxLines,
      this.onChanged,
      this.controller,
      this.onSubmitted,
      this.focusNode,
      this.textStyle});

  @override
  _DarkTextFieldState createState() => _DarkTextFieldState();
}

class _DarkTextFieldState extends State<DarkTextField> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.2),
          border: Border.all(width: 4, color: Colors.grey.withOpacity(0)),
          borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.fromLTRB(5, 10, 15, 10),
      placeholderStyle: placeholder,
      cursorColor: appTheme.primaryColor,
      placeholder: widget.placeholder,
      prefix: widget.prefix,
      obscureText: widget.obscureText,
      keyboardType: widget.keyboardType,
      onChanged: widget.onChanged,
      maxLines: widget.maxLines,
      controller: widget.controller,
      onSubmitted: widget.onSubmitted,
      focusNode: widget.focusNode,
      style: widget.textStyle,
    );
  }
}
