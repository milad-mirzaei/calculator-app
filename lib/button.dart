import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String btn;
  final Color color;
  final Color txtColor;
  final Color shadowColor;
  final VoidCallback buttonTapped;

  const Button(
      {Key? key,
      required this.btn,
      required this.color,
      required this.txtColor,
      required this.shadowColor,
      required this.buttonTapped})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonTapped,
      child: Padding(
        padding: const EdgeInsets.all(7.0),
        child: Container(
          margin: const EdgeInsets.all(7),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: color,
              border: Border.all(color: Colors.white, width: 2),
              boxShadow: [
                BoxShadow(
                    offset: const Offset(3, 3),
                    blurRadius: 5.0,
                    spreadRadius: 3.0,
                    color: shadowColor)
              ]),
          child: Center(
            child: Text(
              btn,
              style: TextStyle(
                  color: txtColor, fontSize: 33, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }
}
