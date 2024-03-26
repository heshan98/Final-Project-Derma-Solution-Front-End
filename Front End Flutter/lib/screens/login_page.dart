import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:project/screens/item_display.dart';
import 'package:project/screens/register_page.dart';
import 'package:project/services/auth_service.dart';

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
  final customTextColor = Color(0xFFFF9F68);
  final AuthService _authService = AuthService();

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
                      const Text(
                        "Welcome Back!",
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
                      ),
                      Hero(
                        tag: 'logo',
                        child: Image.asset(
                          'assets/images/logo.png',
                          height: 300,
                          width: 300,
                          fit: BoxFit.cover,
                          alignment: Alignment.topCenter,
                        ),
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
                                  keyboardType: TextInputType.text,
                                  decoration: ThemeHelper().textInputStyle(const Icon(Icons.email), 'Username', 'Enter your username'),
                                  onChanged: (String value) {},
                                  validator: (value) {
                                    return value!.isEmpty ? 'Please enter username' : null;
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
                                      '',
                                    ),
                                    onTap: () {
                                      // Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordPage()));
                                    },
                                  ),
                                ),

                                MaterialButton(
                                  minWidth: 200,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.0), side: BorderSide(color: customTextColor, width: 2)),
                                  elevation: 10,
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      try {
                                        final response = await _authService.login(
                                          emailController.text,
                                          pwdController.text,
                                        );

                                        if (response.isNotEmpty) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => MainScreen()),
                                          );
                                          // Login was successful

                                          print(response);
                                        } else {

                                          print('Login failed: ${response['message']}');
                                        }
                                      } catch (error) {
                                        // Handle errors, e.g., show a generic error message
                                        print('Error: $error');
                                      }
                                    }
                                  },
                                  color: const Color(0xffffffff),

                                  // color: const Color(0xffE4032F),
                                  textColor: customTextColor,
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






                                const SizedBox(
                                  height: 15,
                                ),
                                RichText(
                                  text: TextSpan(text: 'No Account? ', style: const TextStyle(color: Colors.black), children: <TextSpan>[
                                    TextSpan(
                                        text: 'Sign Up Here',
                                        style: TextStyle(color: customTextColor, fontWeight: FontWeight.bold),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Get.to(() => RegistrationPage(), transition: Transition.rightToLeft, curve: Curves.easeInCubic, duration: const Duration(milliseconds: 800));

                                            Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationPage()));
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
