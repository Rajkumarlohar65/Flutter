import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:offline_database/app/data/database_helper.dart';
import 'package:offline_database/app/res/colors.dart';
import 'package:offline_database/app/res/string.dart';
import '../../../data/models/user_details_model.dart';
import '../../../res/utils.dart';

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
      Utils().showToast(AddUserPageString.submitSuccessMessage, backgroundColor: AppColors.greenColor);

    } catch (e){
      Utils().showSnackBar(AddUserPageString.submitErrorTitle, AddUserPageString.submitSuccessMessage, backgroundColor: AppColors.redColor);
    }
  }

}
