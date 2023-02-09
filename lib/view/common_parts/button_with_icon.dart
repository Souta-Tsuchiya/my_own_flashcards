import 'package:flutter/material.dart';

class ButtonWithIcon extends StatelessWidget {
  final Icon icon;
  final String label;
  final VoidCallback onPressed;
  final Color color;

  ButtonWithIcon({required this.icon, required this.label, required this.onPressed, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: SizedBox(
        width: double.infinity,
        height: 48.0,
        child: ElevatedButton.icon(
          icon: icon,
          label: Text(label, style: TextStyle(fontSize: 20.0),),
          style: ElevatedButton.styleFrom(
            primary: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              ),
            ),
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
