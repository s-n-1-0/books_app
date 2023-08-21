import 'package:flutter/material.dart';

class ElevatedGradationButton extends ElevatedButton {
  ElevatedGradationButton(
      {Key? key,
      required VoidCallback onPressed,
      required Widget child,
      required LinearGradient gradient})
      : super(
            key: key,
            onPressed: onPressed,
            child: Ink(
                decoration: BoxDecoration(
                  gradient: gradient,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    child: child)),
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero, backgroundColor: Colors.transparent));
}
