import 'package:get/get.dart';
import 'package:quizzle/controllers/controllers.dart';
import 'package:quizzle/services/services.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ThemeController());
    //Get.put(PapersDataUploader());
    Get.put(AuthController(), permanent: true);
    Get.put(NotificationService());
    Get.lazyPut(() =>  FireBaseStorageService());
  }
}
