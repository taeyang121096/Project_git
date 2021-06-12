import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:honeyroom/pages/hexagon.dart';

import 'custom_route.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/auth';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _success;
  String _userEmail = '';
  Duration get loginTime => Duration(milliseconds: timeDilation.ceil() * 2250);
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> _signinUser(LoginData data) async {
    return Future.delayed(loginTime).then((_) async {
      try {
        final User user = (await _auth.signInWithEmailAndPassword(
          email: data.name,
          password: data.password,
        ))
            .user;
        return null;
      } catch (e) {
        return '일치하지 않는 회원정보 입니다.';
      }
    });
  }

  Future<void> _recoverPassword(String name) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: name);
  }

  Future<void> _register(LoginData data) async {
    final User user = (await _auth.createUserWithEmailAndPassword(
      email: data.name,
      password: data.password,
    ))
        .user;
    if (user != null) {
      setState(() {
        _success = true;
        _userEmail = user.email;
      });
    } else {
      _success = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.brown),
      body: FlutterLogin(
        title: '꿀방',
        logo: 'assets/images/RoomGowithB.png',
        logoTag: 'Honey Room',
        titleTag: 'Honey Room',
        emailValidator: (value) {
          if (!value.contains('@') || !value.endsWith('.com')) {
            return "Email must contain '@' and end with '.com'";
          }
          return null;
        },
        passwordValidator: (value) {
          if (value.isEmpty) {
            return 'Password is empty';
          }
          return null;
        },
        onLogin: (loginData) {
          print('Login info');
          print('Name: ${loginData.name}');
          print('Password: ${loginData.password}');
          return _signinUser(loginData);
        },
        onSignup: (loginData) {
          print('Signup info');
          print('Name: ${loginData.name}');
          print('Password: ${loginData.password}');
          return _register(loginData);
        },
        onSubmitAnimationCompleted: () {
          Navigator.of(context).pushReplacement(FadePageRoute(
            builder: (context) => MyHomePage(),
          ));
          //Navigator.pop(context);
        },
        onRecoverPassword: (name) {
          print('Recover password info');
          print('Name: $name');
          return _recoverPassword(name);
          // Show new password dialog
        },
        showDebugButtons: false,
      ),
    );
  }
}
