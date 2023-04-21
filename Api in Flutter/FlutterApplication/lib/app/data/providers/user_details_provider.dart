import 'package:get/get.dart';

import '../models/user_details_model.dart';

class UserDetailsProvider extends GetConnect {

   UserDetailsProvider() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return UserDetails.fromJson(map);
      if (map is List) {
        return map.map((item) => UserDetails.fromJson(item)).toList();
      }
    };
    httpClient.baseUrl = "http://192.168.105.229:3000/";
  }

  Future<List<UserDetails?>> getUserDetails() async {
    final response = await get("userDetails/");

    if (response.statusCode == 200) {
      final userDetailsList = List<UserDetails>.from(response.body);
      return userDetailsList;
    } else {
      Get.snackbar("Response", "Server issue or sometimes wifi internet also block to hit api");
      return <UserDetails>[];
    }
  }

   Future<Response<UserDetails>> postUserDetails(UserDetails userDetails) async {
     var response = await post('userDetails/add', userDetails.toJson());

     if(response.statusCode == 200){
       Get.snackbar("Response", "User added Successfully");
       return Response<UserDetails>(
         statusCode: response.statusCode,
         body: UserDetails.fromJson(response.body),
         headers: response.headers,);
     } else{
       throw Get.snackbar("Response", "Server Down");
     }
   }

  Future<Response?> deleteUserDetails(int id) async{
    var response = await delete('userDetails/delete/$id');

    if(response.statusCode == 204){
      return null;
    } else{
      throw Get.snackbar("Response", "Server Down");
    }
  }

}
