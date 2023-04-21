import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:api_integration/app/data/providers/user_details_provider.dart';
import 'package:api_integration/app/data/models/user_details_model.dart';

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

  void startAnimation() {
    isAnimating.value = true;
    animationController.forward().whenComplete(() {
      animationController.reset();
      isAnimating.value = false;
    });

  }

  void fetchData() async{
    var userDetails = await UserDetailsProvider().getUserDetails();
    data.value = userDetails as List<UserDetails>;
    startAnimation();
  }

  void deleteUserDetails(int id) async{
    try{
      await UserDetailsProvider().deleteUserDetails(id);
    }catch(e){
      Get.snackbar("Response", "User not Deleted");
    }
  }

}
