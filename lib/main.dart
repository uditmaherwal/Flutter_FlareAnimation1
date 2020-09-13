import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:loginFlare/loginPage.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> password = ['password', 'katta', 'udit'];
  String animationType = 'idle';
  String username;

  final key = GlobalKey<FormState>();

  final passwordController = TextEditingController();
  final passwordFocusNode = FocusNode();
  final userController = TextEditingController();
  final userFocusNode = FocusNode();

  void initState() {
    super.initState();
    passwordController.addListener(() {
      if (passwordFocusNode.hasFocus) {
        setState(() {
          animationType = 'test';
        });
      } else {
        setState(() {
          animationType = 'idle';
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 150,
            ),
            Center(
              child: Container(
                height: 300,
                width: 300,
                child: FlareActor(
                  'assets/Teddy.flr',
                  alignment: Alignment.center,
                  fit: BoxFit.contain,
                  shouldClip: false,
                  animation: animationType,
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 5,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              padding: EdgeInsets.all(18.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Form(
                key: key,
                child: Column(
                  children: [
                    TextFormField(
                      controller: userController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter your username';
                        }
                        key.currentState.save();
                        return null;
                      },
                      onSaved: (newValue) {
                        username = newValue;
                      },
                      toolbarOptions: ToolbarOptions(
                          copy: true, cut: true, paste: true, selectAll: true),
                      autofocus: true,
                      focusNode: userFocusNode,
                      onTap: () {
                        setState(() {
                          animationType = 'idle';
                        });
                      },
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 19.0,
                      ),
                      decoration: InputDecoration(
                          fillColor: Colors.black,
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(10.0),
                          hintText: 'Username',
                          hintStyle: TextStyle(
                            color: Colors.black26,
                          )),
                    ),
                    Divider(
                      color: Colors.black,
                    ),
                    TextFormField(
                      autofocus: true,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 19.0,
                      ),
                      controller: passwordController,
                      onTap: () {
                        setState(() {
                          animationType = 'test';
                        });
                      },
                      focusNode: passwordFocusNode,
                      obscureText: true,
                      validator: (value) {
                        if (value.length < 7) {
                          return 'Password should be minimum 7 characters';
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10.0),
                          border: InputBorder.none,
                          hintText: 'Password',
                          hintStyle: TextStyle(
                            color: Colors.black26,
                          )),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: 530,
              height: 70,
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.only(top: 20),
              child: RaisedButton(
                color: Color(0xfff01c62),
                onPressed: () {
                  key.currentState.save();
                  if (password.contains(passwordController.text)) {
                    setState(() {
                      animationType = 'success';
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return LoginPage(
                            username: username,
                          );
                        },
                      ));
                    });
                  } else {
                    setState(() {
                      animationType = 'fail';
                    });
                  }
                },
                child: Text(
                  'Submit',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
