import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'colors.dart';
class Utils{

  void showSnackBar(String title, String message){
    Get.snackbar(
        title,
        message,
        backgroundColor: MyColors.redColor,
        duration: const Duration(seconds: 5),
        dismissDirection: DismissDirection.horizontal,
    );
  }

  void showToast(String message){
    Fluttertoast.showToast(msg: message, backgroundColor: MyColors.greenColor);
  }
}