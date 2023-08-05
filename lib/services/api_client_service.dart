import 'package:demo_app/model/location.dart';
import 'package:demo_app/model/role.dart';
import 'package:demo_app/widgets/toasts.dart';
import 'package:dio/dio.dart';

import '../helpers/dio_client.dart';
import '../helpers/env.dart';
import '../model/login_response.dart';

class ApiClient {
  static AuthDioClient authdioClient = AuthDioClient();
  static UserDioClient userdioClient = UserDioClient();

  static Future registerUser({required Data data}) async {
    try {
      Response response = await authdioClient.dio.post(EndPoints.register,
          data: FormData.fromMap(
            data.toJson(),
          ),
          options: Options(contentType: 'multipart/form-data'));

      if (response.statusCode == 200) {
        print(response);
        final res = LoginResponse.fromJson(response.data);
        return res;
      }
    } on DioException catch (e) {
      final res = LoginResponse.fromJson(e.response?.data);
      showErrorToast(res.msg);
      return res;
    }
  }

  static Future login(
    String email,
    String password,
  ) async {
    Map<String, String> params = {};
    params['userName'] = email;
    params['password'] = password;

    try {
      Response response = await authdioClient.dio.post(
        EndPoints.login,
        data: params,
      );

      if (response.statusCode == 200) {
        final loginResponse = LoginResponse.fromJson(response.data);
        return loginResponse.data;
      }
    } on DioException catch (e) {
      final res = LoginResponse.fromJson(e.response?.data);
      showErrorToast(res.msg);
    }
  }

  static Future<List<Role>?> getUserRole() async {
    Response response = await authdioClient.dio.get(EndPoints.role);

    if (response.statusCode == 200) {
      final roleResponse = RoleResponse.fromJson(response.data);

      return roleResponse.data;
    }
    return [];
  }

  static Future<List<LocationData>?> getLocation() async {
    Response response = await userdioClient.dio.get(EndPoints.location);

    if (response.statusCode == 200) {
      final locationResponse = LocationResponse.fromJson(response.data);

      return locationResponse.data;
    }
    return [];
  }
}
