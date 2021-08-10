import 'package:flutter/material.dart';

final appTheme = ThemeData(
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: Colors.grey[100],
    cardTheme: CardTheme(
        elevation: 3,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)),
        shadowColor: Colors.grey[350],
        margin: EdgeInsets.fromLTRB(8, 8, 8, 0)),
    bottomSheetTheme: BottomSheetThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
        )),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        )),
    appBarTheme: AppBarTheme(
      centerTitle: true,
    ),
    inputDecorationTheme: InputDecorationTheme(
      alignLabelWithHint: true,
      filled: true,
      contentPadding: EdgeInsets.all(8),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 0.2, color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      floatingLabelBehavior: FloatingLabelBehavior.always,
    ));