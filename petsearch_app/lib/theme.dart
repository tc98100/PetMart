import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final double headerSize = 0.04;
final double titleSize = 0.03;
final double subtitleSize = 0.025;
final double normalSize = 0.02;
final double smallSize = 0.015;
final double padding = 0.01;
final double morePadding = padding * 2;
final double separatorPadding = morePadding * 2;
final double sectionPadding = 0.1;
final double allPadding = padding / 2;

final CupertinoThemeData appTheme = CupertinoThemeData(
    primaryColor: Colors.redAccent,
    primaryContrastingColor: Colors.orangeAccent,
    scaffoldBackgroundColor: Colors.grey[900],
    barBackgroundColor: Colors.grey[700],
    textTheme: CupertinoTextThemeData(
        textStyle: TextStyle(color: Colors.white, fontSize: 16)));

TextStyle regularFont(double fontSize) {
  return TextStyle(
    color: Colors.white,
    fontSize: fontSize,
  );
}

final ThemeData appTheme2 = ThemeData(
  accentColor: Colors.redAccent,
  backgroundColor: Colors.grey[900],
);

//Gradients
final Shader linearGradient = LinearGradient(
  colors: <Color>[Colors.redAccent, Colors.orangeAccent],
).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

TextStyle gradientText(double fontSize) {
  return TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      decoration: TextDecoration.none,
      foreground: Paint()..shader = linearGradient);
}

final BoxDecoration gradientOpacity = BoxDecoration(
    gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [Colors.orangeAccent, Colors.redAccent]));

final BoxDecoration gradientBorder = BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(15)),
    gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [Colors.orangeAccent, Colors.redAccent]));

//Text

final TextStyle header = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
);

final TextStyle headerRed = TextStyle(
    fontSize: 20, fontWeight: FontWeight.bold, color: Colors.redAccent);

TextStyle title(double fontSize) {
  return TextStyle(
    fontSize: fontSize,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
}

final TextStyle placeholder = TextStyle(
  color: Colors.grey[600],
);

final TextStyle shadow = TextStyle(color: Colors.grey[500], fontSize: 16);

TextStyle subShadow(double fontSize) {
  return TextStyle(
    color: Colors.grey[500],
    fontSize: fontSize,
  );
}

final TextStyle highlight = TextStyle(
  color: appTheme2.accentColor,
);

final BoxDecoration chatBubbleOther = BoxDecoration(
    // color: appTheme2.backgroundColor.withOpacity(0.4),
    // border: Border.all(
    //   color: appTheme2.backgroundColor,
    //   width: 10,
    // ),
    // borderRadius: BorderRadius.circular(16.0),
    color: Colors.grey.withOpacity(0.2),
    border: Border.all(width: 4, color: Colors.grey.withOpacity(0)),
    borderRadius: BorderRadius.circular(16));

Color lighterOrange = Colors.orangeAccent[100];

final BoxDecoration chatBubbleSelf = BoxDecoration(
  gradient: LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [Colors.orangeAccent, Colors.redAccent]),
  border: Border.all(
    color: lighterOrange.withOpacity(0),
    width: 5,
  ),
  borderRadius: BorderRadius.circular(16.0),
);
