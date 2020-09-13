import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final String username;
  LoginPage({this.username});
  @override
  _LoginPageState createState() => _LoginPageState(username: username);
}

class _LoginPageState extends State<LoginPage> {
  String username;
  _LoginPageState({this.username});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(20.0),
                height: MediaQuery.of(context).size.height / 5,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Text(
                    "Welcome $username",
                    style: TextStyle(
                      color: Color(0xfff01c62),
                      fontSize: 22.0,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
