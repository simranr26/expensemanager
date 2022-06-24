import 'package:flutter/material.dart';
import 'package:manage_expense/screens/registration.dart';
import 'package:shared_preferences/shared_preferences.dart';

class login {
  dynamic emailField;
  dynamic passwordField;

  login(dynamic emailField, dynamic passwordField) {
    this.passwordField = passwordField;
    this.emailField = emailField;
  }
}

final TextEditingController emailController = TextEditingController();

final TextEditingController passwordController = TextEditingController();

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isLogin = false;
  String email = '';
  final _formKey = GlobalKey<FormState>();
  _LoginState();

  void initState() {
    super.initState();
    checkLogin();
  }

  checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final dynamic emailData = prefs.getString('email');
    final dynamic passwordData = prefs.getString('password');
    if (emailData != null || passwordData != null) {
      setState(() {
        isLogin = true;
        email = emailController.text;
      });
      return;
    }
    await prefs.clear();
    isLogin = false;
    return;
  }

  getLoginInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', emailController.text);
    prefs.setString('password', passwordController.text);

    setState(() {
      isLogin = true;
      email = emailController.text;
    });
    emailController.clear();
    passwordController.clear();
  }

  LogOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  //checkloginfunction

  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      autofocus: false,
      keyboardType: TextInputType.emailAddress,
      onSaved: (value) {
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      controller: emailController,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'Email',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordController,
      obscureText: true,
      onSaved: (value) {
        passwordController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: 'Password',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.blue,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(
          20,
          15,
          20,
          15,
        ),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          getLoginInfo();
        },
        child: Text(
          'Login',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: !isLogin
              ? SingleChildScrollView(
                  child: Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(36.0),
                      child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                height: 45,
                              ),
                              emailField,
                              SizedBox(
                                height: 45,
                              ),
                              passwordField,
                              SizedBox(
                                height: 45,
                              ),
                              loginButton,
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Don't have an account?"),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  RegistrationPage()));
                                    },
                                    child: Text(
                                      'SignUp',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                          color: Colors.blue),
                                    ),
                                  )
                                ],
                              )
                            ],
                          )),
                    ),
                  ),
                )
              : ElevatedButton(
                  onPressed: () {
                    LogOut();
                  },
                  child: Text('loginSuccess'))),
    );
  }
}
