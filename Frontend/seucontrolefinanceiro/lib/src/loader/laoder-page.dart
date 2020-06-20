import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:seucontrolefinanceiro/src/home/home-page.dart';
import 'package:seucontrolefinanceiro/src/loader/loader.dart';
import 'package:seucontrolefinanceiro/src/login/login-page.dart';
import 'package:seucontrolefinanceiro/src/login/login-service.dart';
import 'package:seucontrolefinanceiro/src/model/auth-model.dart';
import 'package:seucontrolefinanceiro/src/model/login-model.dart';

class LoaderPage extends StatefulWidget {
  LoginModel loginModel;
  LoaderPage(LoginModel loginModel) {
    this.loginModel = loginModel;
  }

  @override
  _LoaderPageState createState() => _LoaderPageState(loginModel);
}

class _LoaderPageState extends State<LoaderPage> {
  LoginModel loginModel;
  _LoaderPageState(loginModel) {
    this.loginModel = loginModel;
  }

  /*
  var auth = await LoginService.login(loginModel);

    if (auth != null) {
      _navigateHomePage(context);
    } else {
      _ctrlPassword.text = '';
      _ctrlUser.text = '';
      alert(context, 'USUÁRIO OU SENHA INVÁLIDOS');
    }*/
  @override
  Widget build(BuildContext context) {
    print(Offset(0.0, -3).distanceSquared - Offset(0.0, 0.0).distanceSquared);
    print('Loader: ' + this.loginModel.user);
    Future<AuthModel> auth = LoginService.login(loginModel);
    return FutureBuilder(
        future: auth,
        builder: (context, snapshot) {
          print('AUTH ' + snapshot.data.toString());
          if (!snapshot.hasData) {
            return Loader.load();
            /*
            Navigator.pushReplacement(
                context,
                CupertinoPageRoute(
                    builder: (BuildContext context) => LoginPage()));*/
          } else if (snapshot.hasError) {
            print('deu erro classe: loader-page');
            Loader.load();
          } else {
            return HomePage();
            /*
            Navigator.pushReplacement(
                context,
                CupertinoPageRoute(
                    builder: (BuildContext context) => HomePage()));*/
          }
        });
  }
}