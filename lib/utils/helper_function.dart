import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

TextStyle createCustomTextStyle({
  double fontSize = 16.0,
  Color color = Colors.black,
  FontWeight fontWeight = FontWeight.normal,
}) {
  return TextStyle(
    fontFamily: 'Poppins',
    fontSize: fontSize,
    color: color,
    fontWeight: fontWeight,
  );
}
hDivider() {
  return const Padding(
    padding: EdgeInsets.all(4.0),
    child: Divider(
      thickness: 0.4,
    ),
  );
}
String formatDateString(String inputDateString) {
  // Parse the input date string
  DateTime dateTime = DateTime.parse(inputDateString);

  // Format the date as "MMMM dd, yyyy"
  String formattedDate = DateFormat('MMMM dd, yyyy').format(dateTime);

  return formattedDate;
}
