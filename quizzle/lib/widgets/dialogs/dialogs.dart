import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Dialogs {
  static final Dialogs _singleton = Dialogs._internal();

  factory Dialogs() {
    return _singleton;
  }

  Dialogs._internal();

  static Widget quizStartDialog({required VoidCallback onTap}) {
    return AlertDialog(
     // title: const Text("Hi.."),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
        
          Text("Hi..", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
          Text("Please login before start the quiz"),
        ],
      ),
      actions: <Widget>[
        TextButton(onPressed: onTap, child: const Text('Okay'))
      ],
    );
  }

  static Future<bool> quizEndDialog() async{
     return (await showDialog(
      context: Get.overlayContext!,
      builder: (context) =>  AlertDialog(
        title:  const Text('Are you sure?'),
        content:  const Text('Do you want to exit the quiz without completing it ?'),
        actions: <Widget>[
          TextButton(
            onPressed: () =>  Get.back(result: false),
            child:  const Text('No'),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child:  const Text('Yes'),
          ),
        ],
      ),
    )) ?? false;

  }
}
