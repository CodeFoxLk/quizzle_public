import 'package:flutter/material.dart';

class IconWithText extends StatelessWidget {
  const IconWithText({Key? key, required this.icon, required this.text})
      : super(key: key);

  final Icon icon;
  final Widget text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        icon,
        const SizedBox(
          width: 4,
        ),
        text
      ],
    );
  }
}
