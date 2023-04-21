import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:offline_database/app/data/database_helper.dart';
import 'package:offline_database/app/modules/home/controllers/home_controller.dart';
import '../../../data/models/user_details_model.dart';

class AddUserController extends GetxController {
  String? id;
  String? name;
  String? email;
  String? age;

  final TextEditingController idController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  @override
  void onClose() {
    idController.dispose();
    nameController.dispose();
    emailController.dispose();
    ageController.dispose();
    super.onClose();
  }

  void insertUserDetails() async{

    try {
      final userDetailsData = UserDetails(
        id: int.parse(id!),
        name: name,
        email: email,
        age: int.parse(age!),
      );

      await DatabaseHelper.instance.insert(userDetailsData);
      Get.snackbar("Inserted", "Data is inserted", snackPosition: SnackPosition.BOTTOM, duration: const Duration(seconds: 1),);

    } catch (e){
      Get.snackbar("Error", "Data is not stored", snackPosition: SnackPosition.BOTTOM, duration: const Duration(seconds: 1),);
    }
  }

}
