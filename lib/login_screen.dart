import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:stesh/signup_screen.dart';

class login_screen extends StatefulWidget {
  const login_screen({super.key});

  @override
  State<login_screen> createState() => _login_screenState();
}

class _login_screenState extends State<login_screen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  bool _passwordVisible = false;
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          height: MediaQuery.of(context).size.height,
          color: Color.fromRGBO(51, 51, 51, 1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        child: Image.asset(
                      "assets/images/logo.png",
                      width: 100,
                      fit: BoxFit.fill,
                    )),
                    SizedBox(
                      height: 20,
                    ),
                    RichText(
                        text: TextSpan(
                            text: 'Stesh!',
                            style: TextStyle(
                              color: Color.fromRGBO(255, 167, 0, 1),
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                            )))
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  child: Column(children: [
                    SizedBox(
                      height: 50,
                    ),
                    TextField(
                      controller: usernameController,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.person,
                            color: Color(0xff333333),
                          ),
                          filled: true,
                          fillColor: Colors.white70,
                          hintStyle:
                              TextStyle(color: Color(0xff333333), fontSize: 16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          hintText: 'username'),
                      style: TextStyle(color: Color(0xff333333)),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Color(0xff333333),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                                _passwordVisible
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Color(0xff333333)),
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                          ),
                          filled: true,
                          fillColor: Colors.white70,
                          hintStyle:
                              TextStyle(color: Color(0xff333333), fontSize: 16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          hintText: 'password'),
                      style: TextStyle(color: Color(0xff333333)),
                      obscureText: !_passwordVisible,
                    ),
                    Row(
                      children: [
                        Checkbox(
                            activeColor: Color.fromRGBO(255, 167, 0, 1),
                            value: this._rememberMe,
                            onChanged: (bool? value) {
                              setState(() {
                                this._rememberMe = value!;
                              });
                            }),
                        Text(
                          "Remember Me",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(255, 167, 0, 1)),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            shape: StadiumBorder(),
                            elevation: 0,
                            primary: Color.fromRGBO(255, 167, 0, 1),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              'Login',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xff333333),
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        )),
                      ],
                    ),
                  ]),
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("I do not have an account | "),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => signup_screen()),
                          );
                        },
                        style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size(40, 30),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            alignment: Alignment.centerLeft),
                        child: Text("Register",
                            style: TextStyle(
                              color: Color.fromRGBO(255, 167, 0, 1),
                            ))),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
