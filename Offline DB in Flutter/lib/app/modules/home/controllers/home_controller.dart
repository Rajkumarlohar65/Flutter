import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:offline_database/app/services/database_helper.dart';

import '../../../data/models/user_details_model.dart';

class HomeController extends GetxController with GetTickerProviderStateMixin{
  late AnimationController animationController;
  RxBool isAnimating = false.obs;
  final data = <UserDetails>[].obs;

  @override
  void onInit() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(seconds: 1)
    );
    fetchData();
    super.onInit();
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onInit();
  }

  void startAnimation() {
    isAnimating.value = true;
    animationController.forward().whenComplete(() {
      animationController.reset();
      isAnimating.value = false;
    });

  }

  void fetchData() async{
    var userDetails = await DatabaseHelper.instance.get();
    data.value = userDetails;
    startAnimation();
  }

  void deleteUserDetails(int id) async{
    await DatabaseHelper.instance.delete(id);
    fetchData();
  }
}
