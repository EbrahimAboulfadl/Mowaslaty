import 'package:flutter/cupertino.dart';

Color kMainColor = Color(0xFFf47f20);
Color kSecColor = Color(0xFF275c53);
String? validator(String value) {
  if (value.isEmpty) {
    return ('Name must be not empty');
  } else if (value.isNotEmpty) {
    return null;
  }
}
