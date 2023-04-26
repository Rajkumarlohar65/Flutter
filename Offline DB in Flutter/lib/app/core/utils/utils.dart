import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:offline_database/app/core/values/app_color.dart';

class Utils{

  void showSnackBar(String title, String message, {Color backgroundColor = AppColors.transparentColor /* Optional*/}){
    Get.snackbar(
        title,
        message,
        backgroundColor: backgroundColor,
        duration: const Duration(seconds: 5),
        dismissDirection: DismissDirection.horizontal,
    );
  }

  void showToast(String message, {Color backgroundColor = AppColors.transparentColor}){
    Fluttertoast.showToast(
        msg: message,
        backgroundColor: backgroundColor
    );
  }
}