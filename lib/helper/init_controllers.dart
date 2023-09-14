import 'package:get/get.dart';
import '../controllers/mezmur_controller.dart';

Future<void> initControllers() async {
  Get.lazyPut(() => MezmurController());
}
