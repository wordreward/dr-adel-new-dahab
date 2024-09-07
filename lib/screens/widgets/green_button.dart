import 'package:adelnewversion/core/core.dart';
import 'package:flutter/material.dart';

class GreenButton extends StatelessWidget {
  const GreenButton({
    Key? key,
    required this.label,
    required this.icon,
    required this.onPressed,
    this.color,
    this.svg,
  }) : super(key: key);

  final String label;
  final IconData icon;
  final Widget? svg;
  final Color? color;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        overlayColor: MaterialStateProperty.all(color ?? titleTextColor),
        backgroundColor:
            MaterialStateProperty.all(color ?? primaryComponentColor),
      ),
      onPressed: onPressed,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        child: Stack(children: [
          Align(
            alignment: Alignment.centerLeft,
            child: svg ??
                Icon(
                  icon,
                  size: 20,
                  color: Colors.white,
                ),
          ),
          const SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  height: 1.5,
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ]),
      ),
    );
  }
}
