import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';

import '../styles/theme_helper.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  var emailController = TextEditingController(text: "");
  var pwdController = TextEditingController(text: "");
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SafeArea(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      // Hero(
                      //   tag: 'logo',
                      //   child: Image.asset(
                      //     'assets/images/CSlogo_white.png',
                      //     height: 300,
                      //     width: 300,
                      //     fit: BoxFit.cover,
                      //     alignment: Alignment.topCenter,
                      //   ),
                      // ),
                      const Text(
                        "Welcome Back!",
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
                      ),

                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                        child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  // inputFormatters: [
                                  //   FilteringTextInputFormatter.deny(RegExp('[ ]')),
                                  // ],
                                  textAlign: TextAlign.center,
                                  controller: emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: ThemeHelper().textInputStyle(const Icon(Icons.email), 'Email', 'Enter your email'),
                                  onChanged: (String value) {},
                                  validator: (value) {
                                    return value!.isEmpty ? 'Please enter email' : null;
                                  },
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                TextFormField(
                                  controller: pwdController,
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: _isObscure,
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    hintText: 'Enter your password',
                                    fillColor: Colors.white,
                                    filled: true,
                                    prefixIcon: const Icon(Icons.password),
                                    suffixIcon: IconButton(
                                      icon: Icon(_isObscure ? Icons.visibility : Icons.visibility_off),
                                      onPressed: () {
                                        setState(() {
                                          _isObscure = !_isObscure;
                                        });
                                      },
                                    ),
                                    contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.0), borderSide: const BorderSide(color: Colors.grey)),
                                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.0), borderSide: BorderSide(color: Colors.grey.shade400)),
                                    errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.0), borderSide: const BorderSide(color: Colors.red)),
                                  ),
                                  onChanged: (String value) {},
                                  validator: (value) {
                                    return value!.isEmpty ? 'Please enter password' : null;
                                  },
                                ),
                                const SizedBox(height: 15.0),
                                Container(
                                  margin: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                                  alignment: Alignment.topRight,
                                  child: InkWell(
                                    child: const Text(
                                      'Forgot Password?',
                                    ),
                                    onTap: () {
                                      // Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordPage()));
                                    },
                                  ),
                                ),

                                MaterialButton(
                                  minWidth: 200,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.0), side: BorderSide(color: Colors.red, width: 2)),
                                  elevation: 10,
                                  onPressed: () {},
                                  color: const Color(0xffffffff),
                                  // color: const Color(0xffE4032F),
                                  textColor: Colors.red,
                                  child: const Text(
                                    'LOGIN',
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                const Text('━━━━━━━ or ━━━━━━━'),
                                const SizedBox(
                                  height: 15,
                                ),
                                // const Text('Continue with singpass'),

                                // Column(
                                //   children: [
                                //     GestureDetector(
                                //       onTap: () {
                                //        },
                                //       child: Image.asset(
                                //         'assets/images/singpass_button.jpeg',
                                //         width: 200,
                                //       ),
                                //     ),
                                //     Text("For registered construcshare account users. One time linking is required", textAlign: TextAlign.center, style: TextStyle(fontSize: 11),)
                                //   ],
                                // ),
                                //     GestureDetector(
                                //   onTap: () {
                                //     openHandleSingpass2();
                                //   },
                                //   child: Text('WEBVIEW 2'),
                                // ),





                                const SizedBox(
                                  height: 15,
                                ),
                                RichText(
                                  text: TextSpan(text: 'No Account? ', style: const TextStyle(color: Colors.black), children: <TextSpan>[
                                    TextSpan(
                                        text: 'Sign Up Here',
                                        style: TextStyle(color: Colors.red[600], fontWeight: FontWeight.bold),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            // Get.to(() => RegistrationPage(), transition: Transition.rightToLeft, curve: Curves.easeInCubic, duration: const Duration(milliseconds: 800));

                                            // Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationPage()));
                                          })
                                  ]),
                                )
                              ],
                            )),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ));;
  }
}
