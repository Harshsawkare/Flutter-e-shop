import 'package:flutter/material.dart';

const Color primaryLight = Color(0xFFF5F9FD);
const Color primaryDark = Color(0xFFCED3DC);
const Color secondaryLight = Color(0xFF0C54BE);
const Color secondaryDark = Color(0xFF303F60);

const registerInputDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 7, horizontal: 20),
  border: InputBorder.none,
  hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.transparent),
    borderRadius: BorderRadius.all(Radius.circular(10)),
  ),
  disabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.transparent),
    borderRadius: BorderRadius.all(Radius.circular(10)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.transparent),
    borderRadius: BorderRadius.all(Radius.circular(10)),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.transparent),
    borderRadius: BorderRadius.all(Radius.circular(10)),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.transparent),
    borderRadius: BorderRadius.all(Radius.circular(10)),
  ),
  filled: true,
  fillColor: primaryLight,
);