import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dioR;
import '../models/user_details_model.dart';

class UserDetailsProvider {
  final dio = Dio();

  UserDetailsProvider() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onResponse: (response, handler) {
          final dynamic data = response.data;
          if (data is Map<String, dynamic>) {
            response.data = UserDetails.fromJson(data);
          } else if (data is List) {
            response.data =
                data.map((item) => UserDetails.fromJson(item)).toList();
          }
          return handler.next(response);
        },
      ),
    );
    dio.options.baseUrl = "http://192.168.235.229:3000/";
  }

  Future<List<UserDetails?>> getUserDetails() async {
    final response = await dio.get("userDetails");

    if (response.statusCode == 200) {
      final userDetailsList = List<UserDetails>.from(response.data);
      return userDetailsList;
    } else {
      Get.snackbar("Response",
          "Server issue or sometimes wifi internet also block to hit api");
      return <UserDetails>[];
    }
  }

  Future<dioR.Response<UserDetails>> postUserDetails(
      UserDetails userDetails) async {
    var response =
        await dio.post('userDetails/add', data: userDetails.toJson());

    if (response.statusCode == 200) {
      Get.snackbar("Response", "User added Successfully");
      return dioR.Response<UserDetails>(
          statusCode: response.statusCode,
          data: UserDetails.fromJson(response.data),
          headers: response.headers,
          requestOptions: RequestOptions(path: 'userDetails/add'));
    } else {
      throw Get.snackbar("Response", "Server Down");
    }
  }

  Future<dioR.Response?> deleteUserDetails(int id) async{
    var response = await dio.delete('userDetails/delete/$id');

    if(response.statusCode == 204){
      return null;
    } else{
      throw Get.snackbar("Response", "Server Down");
    }
  }
}
