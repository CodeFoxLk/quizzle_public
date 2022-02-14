import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:quizzle/controllers/auth_controller.dart';
import 'package:quizzle/firebase/loading_status.dart';
import 'package:quizzle/firebase/references.dart';
import 'package:quizzle/models/models.dart';
import 'package:quizzle/utils/logger.dart';

class LeaderBoardController extends GetxController {
  final leaderBoard = <LeaderBoardData>[].obs;
  final myScores = Rxn<LeaderBoardData>();
  final loadingStatus = LoadingStatus.completed.obs;

  void getAll(String paperId) async {
   loadingStatus.value = LoadingStatus.loading;
    try {
      final QuerySnapshot<Map<String, dynamic>> _leaderBoardSnapShot =
          await getleaderBoard(paperId: paperId)
              .orderBy("points", descending: true)
              .limit(50)
              .get();
      final allData = _leaderBoardSnapShot.docs
          .map((score) => LeaderBoardData.fromSnapShot(score))
          .toList();

      for (var data in allData) {
        final userSnapshot = await userFR.doc(data.userId).get();
        data.user = UserData.fromSnapShot(userSnapshot);
      }

      leaderBoard.assignAll(allData);
      loadingStatus.value = LoadingStatus.completed;
    } catch (e) {
      loadingStatus.value = LoadingStatus.error;
      AppLogger.e(e);
    }
  }

  void getMyScores(String paperId) async{
    final user = Get.find<AuthController>().getUser();
    
    if(user == null){
      return;
    }
    try {
      final DocumentSnapshot<Map<String, dynamic>> _leaderBoardSnapShot = await getleaderBoard(paperId: paperId).doc(user.email).get();
      final _myScores =  LeaderBoardData.fromSnapShot(_leaderBoardSnapShot);
      _myScores.user = UserData(
        name: user.displayName!,
        image: user.photoURL
      );
      myScores.value = _myScores;
    } catch (e) {
      AppLogger.e(e);
    }
  }
}
