import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:quizzle/controllers/auth_controller.dart';
import 'package:quizzle/firebase/references.dart';
import 'package:quizzle/models/models.dart' show QuizPaperModel;
import 'package:quizzle/screens/screens.dart' show QuizeScreen;
import 'package:quizzle/services/firebase/firebasestorage_service.dart';
import 'package:quizzle/utils/logger.dart';

class QuizPaperController extends GetxController {
  @override
  void onReady() {
    getAllPapers();
    super.onReady();
  }

  final allPapers = <QuizPaperModel>[].obs;
  final allPaperImages = <String>[].obs;

  Future<void> getAllPapers() async {
    try {
      QuerySnapshot<Map<String, dynamic>> data = await quizePaperFR.get();
      final paperList =
          data.docs.map((paper) => QuizPaperModel.fromSnapshot(paper)).toList();
      allPapers.assignAll(paperList);

      for (var paper in paperList) {
        final imageUrl =
            await Get.find<FireBaseStorageService>().getImage(paper.title);
        paper.imageUrl = imageUrl;
      }
      allPapers.assignAll(paperList);
    } catch (e) {
      AppLogger.e(e);
    }
  }

  void navigatoQuestions({required QuizPaperModel paper, bool isTryAgain = false}) {
    AuthController _authController = Get.find();

    if (_authController.isLogedIn()) {
      if (isTryAgain) {
        Get.back();
        Get.offNamed(QuizeScreen.routeName, arguments: paper, preventDuplicates: false);
      } else {
        Get.toNamed(QuizeScreen.routeName, arguments: paper);
      }
    } else {
      _authController.showLoginAlertDialog();
    }
  }
}
