import 'package:api_integration/app/data/providers/user_details_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

  void saveUserDetails() async{
    try{
      final userDetailsData = UserDetails(
        id: int.parse(id!),
        name: name,
        email: email,
        age: int.parse(age!),
      );

      await UserDetailsProvider().postUserDetails(userDetailsData);
    }catch(e){
      print(e);
    }

  }

}
