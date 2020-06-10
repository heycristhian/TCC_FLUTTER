import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:seucontrolefinanceiro/src/model/auth-model.dart';
import 'package:seucontrolefinanceiro/src/model/login-model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginService {
  static Future<AuthModel> login(LoginModel loginModel) async {
    var url = 'http://192.168.0.148:8080/auth';

    var prefs = await SharedPreferences.getInstance();
    var header = {"Content-Type": "application/json"};

    Map params = {"email": loginModel.user, "password": loginModel.password};

    var _body = json.encode(params);
    print('Json enviado $_body');

    var response = await http.post(url, headers: header, body: _body);

    print('Response status: ${response.statusCode}');

    try {
      Map mapResponse = json.decode(response.body);
      final auth = AuthModel.fromJson(mapResponse);
      prefs.setString('token', mapResponse['token']);
      prefs.setString('type', mapResponse['type']);
      prefs.setString('user', loginModel.user);
      return auth; 
    } on Exception {
      return null;
    }
  }
}