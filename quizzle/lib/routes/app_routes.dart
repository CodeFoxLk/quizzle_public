import 'package:get/get.dart';
import 'package:quizzle/controllers/controllers.dart';
import 'package:quizzle/screens/screens.dart';

class AppRoutes {
  static List<GetPage> pages() => [
        GetPage(
          page: () => const SplashScreen(),
          name: SplashScreen.routeName,
        ),
        GetPage(
          page: () => const AppIntroductionScreen(),
          name: AppIntroductionScreen.routeName,
        ),
        GetPage(
            page: () => const HomeScreen(),
            name: HomeScreen.routeName,
            binding: BindingsBuilder(() {
              Get.put(QuizPaperController());
              Get.put(MyDrawerController());
            })),
        GetPage(page: () => const LoginScreen(), name: LoginScreen.routeName),
        GetPage(
            page: () => const ProfileScreen(),
            name: ProfileScreen.routeName,
            binding: BindingsBuilder(() {
              Get.put(QuizPaperController());
              Get.put(ProfileController());
            })),
        GetPage(
            page: () => LeaderBoardScreen(),
            name: LeaderBoardScreen.routeName,
            binding: BindingsBuilder(() {
              Get.put(LeaderBoardController());
            })),
        GetPage(
            page: () => QuizeScreen(),
            name: QuizeScreen.routeName,
            binding: BindingsBuilder(() {
              Get.put<QuizController>( QuizController());
            })),
        GetPage(
            page: () => const AnswersCheckScreen(),
            name: AnswersCheckScreen.routeName),
        GetPage(
            page: () => const QuizOverviewScreen(),
            name: QuizOverviewScreen.routeName),
        GetPage(page: () => const Resultcreen(), name: Resultcreen.routeName),
      ];
}
