import 'package:demo_app/widgets/toasts.dart';

import '../main.dart';
import '../model/login_response.dart';
import '../services/api_client_service.dart';

class AuthController {
  Future loginUsers(email, pass) async {
    final res = await ApiClient.login(email, pass);
    if (res is Data) {
      sp.setString('access_token', res.jwtToken ?? "");

      return true;
    }

    return false;
  }

  Future registerUsers(Data data) async {
    final res = await ApiClient.registerUser(data: data);
    print(res.msg);
    if (res is LoginResponse && res.msg != null) {
      if (res.msg == "success") {
        showSuccessToast("User resgistered successfully!");
        return true;
      }
      showErrorToast(res.msg);
      return false;
    } else {
      showErrorToast("Some error occured.Please try again.");
      return false;
    }
  }
}
