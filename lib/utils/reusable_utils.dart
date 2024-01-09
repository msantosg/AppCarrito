import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

ButtonIcon(BuildContext context, Function onTap, IconData iconButton,
    String labelButton) {
  return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
      child: ElevatedButton.icon(
          onPressed: () {
            onTap();
          },
          icon: Icon(
            iconButton,
            size: 24.0,
            color: Colors.white,
          ),
          label: Text(labelButton,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16)),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith((states) {
                return Colors.red;
              }),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30))))));
}

ButtonIcon2(BuildContext context, Function onTap, IconData iconButton,
    String labelButton) {
  return Container(
      width: 350,
      height: 50,
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
      child: ElevatedButton.icon(
          onPressed: () {
            onTap();
          },
          icon: Icon(
            iconButton,
            size: 24.0,
            color: Colors.white,
          ),
          label: Text(labelButton,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16)),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith((states) {
                return Colors.red;
              }),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30))))));
}
