import 'package:get/get.dart';
import '../controllers/mezmur_controller.dart';
import '../controllers/ui_controller.dart';
import '../controllers/database_controller.dart';

Future<void> initControllers() async {
  Get.lazyPut(() => MezmurController());
  Get.lazyPut(() => UIController());
  Get.lazyPut(() => DatabaseController());
}
