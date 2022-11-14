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
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: buttonTapped,
      child: Padding(
        padding: EdgeInsets.all(w / 75),
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.all(w / 75),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(w / 16),
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
                  color: txtColor,
                  fontSize: w / 17,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }
}
