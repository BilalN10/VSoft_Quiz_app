import 'package:get/get.dart';
import 'package:quizapp/Controllers/userController.dart';
import 'package:quizapp/Controllers/userQuestionController.dart';

class Authbindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserController>(() => UserController());
    Get.lazyPut<UserQuestionController>(() => UserQuestionController());
  }
}
