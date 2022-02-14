import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:quizzle/controllers/auth_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class MyDrawerController extends GetxController {
  final zoomDrawerController = ZoomDrawerController();
  Rxn<User?> user = Rxn();

  void toggleDrawer() {
    zoomDrawerController.toggle?.call();
    update();
  }

  void signOut() {
    Get.find<AuthController>().signOut();
  }

  void signIn() {
    Get.find<AuthController>().navigateToLogin();
  }

  void github() {
    _launch('https://github.com/CodeFoxLk');
  }

  void email() {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'codefoxlk@gmail.com',
    );
    _launch(emailLaunchUri.toString());
  }

  void downloadSourceCode() {
    _launch('https://github.com/CodeFoxLk/quizzle_public.git');
  }

  @override
  void onReady() {
    user.value = Get.find<AuthController>().getUser();
    super.onReady();
  }

  Future<void> _launch(String url) async {
    if (!await launch(
      url,
    )) {
      throw 'Could not launch $url';
    }
  }
}
