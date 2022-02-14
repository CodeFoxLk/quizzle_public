import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizzle/configs/configs.dart';
import 'package:quizzle/controllers/controllers.dart';
import 'package:quizzle/widgets/widgets.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({Key? key}) : super(key: key);

  static const String routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    final AuthController _auth = Get.find<AuthController>();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(),
      body: BackgroundDecoration(
        showGradient: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: UIParameters.screenPadding.copyWith(top: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children:  [
                      CircleAvatar(
                        radius: 35,
                        foregroundImage: NetworkImage(_auth.getUser()!.photoURL!),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        _auth.getUser()!.displayName ?? '',
                        style: kHeaderTS,
                      )
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text(
                      'My recent tests ',
                      style: TextStyle(
                          color: kOnSurfaceTextColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Obx(
               () =>  ContentArea(
                  addPadding: false,
                  child: ListView.separated(
                   padding: UIParameters.screenPadding,
                    itemCount: controller.allRecentTest.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(
                        height: 15,
                      );
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return RecentQuizCard(recentTest: controller.allRecentTest[index]);
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
