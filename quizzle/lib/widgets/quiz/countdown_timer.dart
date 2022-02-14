import 'package:flutter/material.dart';
import 'package:quizzle/configs/configs.dart';

class CountdownTimer extends StatelessWidget {
  const CountdownTimer({Key? key, this.color, required this.time})
      : super(key: key);

  final Color? color;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.timer,
          color: color ?? Theme.of(context).primaryColor,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          time,
          style: countDownTimerTs(context).copyWith(color: color)
        )
      ],
    );
  }
}
