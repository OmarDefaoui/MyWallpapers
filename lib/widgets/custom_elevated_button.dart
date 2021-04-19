import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  const CustomElevatedButton({
    this.child,
    this.onPressed,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(90.0),
        ),
        textStyle: TextStyle(
          color: Colors.white,
        ),
      ),
      child: child,
      onPressed: onPressed,
    );
  }
}
