import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stesh/login_screen.dart';

class signup_screen extends StatefulWidget {
  const signup_screen({Key? key}) : super(key: key);

  @override
  State<signup_screen> createState() => _signup_screenState();
}

class _signup_screenState extends State<signup_screen> {
  bool _passwordVisible = false;
  bool _isDriver = false;

  final fullnameController = TextEditingController();
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
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
              Column(
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
              Expanded(
                flex: 4,
                child: Container(
                  child: Column(children: [
                    TextField(
                      controller: fullnameController,
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
                          hintText: 'fullname'),
                      style: TextStyle(color: Color(0xff333333)),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.mail,
                            color: Color(0xff333333),
                          ),
                          filled: true,
                          fillColor: Colors.white70,
                          hintStyle:
                              TextStyle(color: Color(0xff333333), fontSize: 16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          hintText: 'email address'),
                      style: TextStyle(color: Color(0xff333333)),
                    ),
                    SizedBox(
                      height: 15,
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
                            value: this._isDriver,
                            onChanged: (bool? value) {
                              setState(() {
                                this._isDriver = value!;
                              });
                            }),
                        Text(
                          "I am a driver",
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
                              'Sign Up',
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "I already have an account | ",
                    style: TextStyle(color: Colors.white),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => login_screen()),
                        );
                      },
                      style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size(40, 30),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          alignment: Alignment.centerLeft),
                      child: Text("Login",
                          style: TextStyle(
                            color: Color.fromRGBO(255, 167, 0, 1),
                          ))),
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
}
