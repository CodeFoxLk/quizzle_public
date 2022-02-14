import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:quizzle/configs/configs.dart';
import 'package:quizzle/controllers/auth_controller.dart';
import 'package:quizzle/widgets/widgets.dart';

class LoginScreen extends GetView<AuthController> {
  const LoginScreen({Key? key}) : super(key: key);

  static const String routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(),
      body: Container(
          constraints: const BoxConstraints(maxWidth: kTabletChangePoint),
          padding: const EdgeInsets.symmetric(horizontal: 30),
          alignment: Alignment.center,
          decoration: BoxDecoration(gradient: mainGradient(context)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/images/app_splash_logo.svg'),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 60),
                child: Text(
                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: kOnSurfaceTextColor, fontWeight: FontWeight.bold),
                ),
              ),
              MainButton(
                onTap: () {
                  controller.siginInWithGoogle();
                 },
                color: Colors.white,
                child: Stack(
                  children: [
                    Positioned(
                        top: 0,
                        bottom: 0,
                        left: 0,
                        child: SvgPicture.asset(
                          'assets/icons/google.svg',
                        )),
                    Center(
                      child: Text(
                        'Sign in  with google',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
