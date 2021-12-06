import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:delivery/theme.dart';
import 'package:delivery/widgets/snackbar.dart';
import 'dart:convert' as Convert;
import 'package:http/http.dart' as http;
import 'package:delivery/pages/login_page.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key ? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final FocusNode focusNodePassword = FocusNode();
  final FocusNode focusNodeConfirmPassword = FocusNode();
  final FocusNode focusNodeAddress = FocusNode();
  final FocusNode focusNodeName = FocusNode();

  final FocusNode focusNodeNickname = FocusNode();
  final FocusNode focusNodeTel = FocusNode();


  bool _obscureTextPassword = true;
  bool _obscureTextConfirmPassword = true;

  TextEditingController signupAddressController = TextEditingController();
  TextEditingController signupNameController = TextEditingController();
  TextEditingController signupPasswordController = TextEditingController();
  TextEditingController signupConfirmPasswordController = TextEditingController();

  TextEditingController signupNicknameController = TextEditingController();
  TextEditingController signupTelController = TextEditingController();

  @override
  void dispose() {
    focusNodePassword.dispose();
    focusNodeConfirmPassword.dispose();
    focusNodeAddress.dispose();
    focusNodeName.dispose();
    focusNodeNickname.dispose();
    focusNodeTel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 18.0),
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              Card(
                elevation: 2.0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  width: 300.0,
                  height: 360.0,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 5.0, bottom: 5.0, left: 25.0, right: 25.0),
                        child: TextField(
                          focusNode: focusNodeName,
                          controller: signupNameController,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.words,
                          autocorrect: false,
                          style: const TextStyle(
                              fontFamily: 'WorkSansSemiBold',
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              FontAwesomeIcons.user,
                              color: Colors.black,
                            ),
                            hintText: 'Name',
                            hintStyle: TextStyle(
                                fontFamily: 'WorkSansSemiBold', fontSize: 16.0),
                          ),
                          onSubmitted: (_) {
                            focusNodeNickname.requestFocus();
                          },
                        ),
                      ),
                      Container(
                        width: 250.0,
                        height: 1.0,
                        color: Colors.grey[400],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 5.0, bottom: 5.0, left: 25.0, right: 25.0),
                        child: TextField(
                          focusNode: focusNodeNickname,
                          controller: signupNicknameController,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.words,
                          autocorrect: false,
                          style: const TextStyle(
                              fontFamily: 'WorkSansSemiBold',
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              FontAwesomeIcons.user,
                              color: Colors.black,
                            ),
                            hintText: 'NickName',
                            hintStyle: TextStyle(
                                fontFamily: 'WorkSansSemiBold', fontSize: 16.0),
                          ),
                          onSubmitted: (_) {
                            focusNodeAddress.requestFocus();
                          },
                        ),
                      ),
                      Container(
                        width: 250.0,
                        height: 1.0,
                        color: Colors.grey[400],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 5.0, bottom: 5.0, left: 25.0, right: 25.0),
                        child: TextField(
                          focusNode: focusNodeAddress,
                          controller: signupAddressController,
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          style: const TextStyle(
                              fontFamily: 'WorkSansSemiBold',
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              FontAwesomeIcons.envelope,
                              color: Colors.black,
                            ),
                            hintText: 'Address',
                            hintStyle: TextStyle(
                                fontFamily: 'WorkSansSemiBold', fontSize: 16.0),
                          ),
                          onSubmitted: (_) {
                            focusNodeTel.requestFocus();
                          },
                        ),
                      ),
                      Container(
                        width: 250.0,
                        height: 1.0,
                        color: Colors.grey[400],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 5.0, bottom: 5.0, left: 25.0, right: 25.0),
                        child: TextField(
                          focusNode: focusNodeTel,
                          controller: signupTelController,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.words,
                          autocorrect: false,
                          style: const TextStyle(
                              fontFamily: 'WorkSansSemiBold',
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              FontAwesomeIcons.user,
                              color: Colors.black,
                            ),
                            hintText: 'Tel',
                            hintStyle: TextStyle(
                                fontFamily: 'WorkSansSemiBold', fontSize: 16.0),
                          ),
                          onSubmitted: (_) {
                            focusNodePassword.requestFocus();
                          },
                        ),
                      ),
                      Container(
                        width: 250.0,
                        height: 1.0,
                        color: Colors.grey[400],
                      ),

                      Padding(
                        padding: const EdgeInsets.only(
                            top: 5.0, bottom: 5.0, left: 25.0, right: 25.0),
                        child: TextField(
                          focusNode: focusNodePassword,
                          controller: signupPasswordController,
                          obscureText: _obscureTextPassword,
                          autocorrect: false,
                          style: const TextStyle(
                              fontFamily: 'WorkSansSemiBold',
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: const Icon(
                              FontAwesomeIcons.lock,
                              color: Colors.black,
                            ),
                            hintText: 'Password',
                            hintStyle: const TextStyle(
                                fontFamily: 'WorkSansSemiBold', fontSize: 16.0),
                            suffixIcon: GestureDetector(
                              onTap: _toggleSignup,
                              child: Icon(
                                _obscureTextPassword
                                    ? FontAwesomeIcons.eye
                                    : FontAwesomeIcons.eyeSlash,
                                size: 15.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          onSubmitted: (_) {
                            focusNodeConfirmPassword.requestFocus();
                          },
                        ),
                      ),
                      Container(
                        width: 250.0,
                        height: 1.0,
                        color: Colors.grey[400],
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(
                      //       top: 5.0, bottom: 5.0, left: 25.0, right: 25.0),
                      //   child: TextField(
                      //     focusNode: focusNodeConfirmPassword,
                      //     controller: signupConfirmPasswordController,
                      //     obscureText: _obscureTextConfirmPassword,
                      //     autocorrect: false,
                      //     style: const TextStyle(
                      //         fontFamily: 'WorkSansSemiBold',
                      //         fontSize: 16.0,
                      //         color: Colors.black),
                      //     decoration: InputDecoration(
                      //       border: InputBorder.none,
                      //       icon: const Icon(
                      //         FontAwesomeIcons.lock,
                      //         color: Colors.black,
                      //       ),
                      //       hintText: 'Confirmation',
                      //       hintStyle: const TextStyle(
                      //           fontFamily: 'WorkSansSemiBold', fontSize: 16.0),
                      //       suffixIcon: GestureDetector(
                      //         onTap: _toggleSignupConfirm,
                      //         child: Icon(
                      //           _obscureTextConfirmPassword
                      //               ? FontAwesomeIcons.eye
                      //               : FontAwesomeIcons.eyeSlash,
                      //           size: 15.0,
                      //           color: Colors.black,
                      //         ),
                      //       ),
                      //     ),
                      //     onSubmitted: (_) {
                      //       _toggleSignUpButton();
                      //     },
                      //     textInputAction: TextInputAction.go,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 305.0),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: CustomTheme.loginGradientStart,
                      offset: Offset(1.0, 6.0),
                      blurRadius: 20.0,
                    ),
                    BoxShadow(
                      color: CustomTheme.loginGradientEnd,
                      offset: Offset(1.0, 6.0),
                      blurRadius: 20.0,
                    ),
                  ],
                  gradient: LinearGradient(
                      colors: <Color>[
                        CustomTheme.loginGradientEnd,
                        CustomTheme.loginGradientStart
                      ],
                      begin: FractionalOffset(0.2, 0.2),
                      end: FractionalOffset(1.0, 1.0),
                      stops: <double>[0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
                child: MaterialButton(
                  highlightColor: Colors.transparent,
                  splashColor: CustomTheme.loginGradientEnd,
                  //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 5.0, horizontal: 21.0),
                    child: Text(
                      'SIGN UP',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontFamily: 'WorkSansBold'),
                    ),
                  ),
                  onPressed: ()async{
                    // if (signupPasswordController.text!=signupConfirmPasswordController.text){
                    //   CustomSnackBar(
                    //       context, const Text('两次密码不一致，请重新修改'));
                    // }
                    // CustomSnackBar(
                    //     context, const Text('Login button pressed'));

                    var baseUrl = "http://42.192.60.125";
                    var uri = "/api/register/";
                    var body = {"userName": signupNameController.text, "userPassword": signupPasswordController.text,
                                "userNickName": signupNicknameController.text,
                                "userTel": signupTelController.text,
                                "userAddress": signupAddressController.text};
                    http.Response response = await http.post(Uri.parse(baseUrl + uri), body: Convert.jsonEncode(body));
                    final statusCode = response.statusCode;
                    final responseBody = response.body;
                    var result = Convert.jsonDecode(responseBody);
                    //print('[uri=$uri][statusCode=$statusCode][response=$responseBody]');

                    //var http =  HttpRequest("http://delivery.mcatk.com");

                    //Map<String, String> ret = http.post("/api/login/", body) as Map<String, String>;
                    //String? userID = ret["userID"];
                    var userID = result["userID"];
                    print(userID);
                    String str = result["message"];
                    while (str!="注册成功"){
                      if (str == "用户名未输入"){
                        CustomSnackBar(
                            context, const Text('用户名未输入'));
                      }
                      if (str == "请求异常"){
                        CustomSnackBar(
                            context, const Text('请求异常'));
                      }
                      var baseUrl = "http://42.192.60.125";
                      var uri = "/api/register/";
                      var body = {"userName": signupNameController.text, "userPassword": signupPasswordController.text,
                        "userNickName": signupNicknameController.text,
                        "userTel": signupTelController.text,
                        "userAddress": signupAddressController.text};
                      http.Response response = await http.post(Uri.parse(baseUrl + uri), body: Convert.jsonEncode(body));
                      final statusCode = response.statusCode;
                      final responseBody = response.body;
                      var result = Convert.jsonDecode(responseBody);
                      //print('[uri=$uri][statusCode=$statusCode][response=$responseBody]');

                      //var http =  HttpRequest("http://delivery.mcatk.com");

                      //Map<String, String> ret = http.post("/api/login/", body) as Map<String, String>;
                      //String? userID = ret["userID"];
                      var userID = result["userID"];
                      // print(userID);
                      print(result["message"]);
                      str = result["message"];
                    }

                    // Navigator.pushNamed(context, "/login", arguments: userID);
                    // (context) => new LoginPage();

                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  void _toggleSignUpButton() {
    CustomSnackBar(context, const Text('SignUp button pressed'));
  }

  void _toggleSignup() {
    setState(() {
      _obscureTextPassword = !_obscureTextPassword;
    });
  }

  void _toggleSignupConfirm() {
    setState(() {
      _obscureTextConfirmPassword = !_obscureTextConfirmPassword;
    });
  }
}
