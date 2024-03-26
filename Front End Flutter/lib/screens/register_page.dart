import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:project/screens/item_display.dart';
import 'package:project/screens/login_page.dart';
import 'package:project/services/auth_service.dart';

class RegistrationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegistrationPageState();
  }
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isObscure1 = true;
  bool _isObscure2 = true;
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  String _password = '';
  String _confirmPassword = '';

  final customTextColor = Color(0xFFFF9F68);
  TextEditingController pwdController = TextEditingController();
  TextEditingController retypePwdController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    var len = _confirmPassword!.length;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Registration'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      RichText(
                        text: TextSpan(
                            text: 'Have an account? ',
                            style: TextStyle(color: Colors.black),
                            children: <TextSpan>[
                              TextSpan(
                                  text: ' Log in',
                                  style: TextStyle(
                                      color: customTextColor,
                                      fontWeight: FontWeight.bold),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Get.to(() => LoginScreen(), transition: Transition.rightToLeft, curve: Curves.easeInCubic, duration: const Duration(milliseconds: 800));

                                      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                                    })
                            ]),
                      )
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                    child: Center(
                      child: Text(
                        'Hi!',
                        style: TextStyle(fontSize: 60),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: Center(
                      child: Text(
                        'Register a New Account',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                    child: Form(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        children: [
                          TextFormField(
                            textAlign: TextAlign.center,
                            controller: userNameController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: 'Username',
                              hintText: 'Enter a User Name',
                              icon: Icon(Icons.person),
                            ),
                            onChanged: (String value) {},
                            validator: (value) {
                              return value!.isEmpty
                                  ? 'Enter a User Name'
                                  : null;
                            },
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            textAlign: TextAlign.center,
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              hintText: 'Enter your email',
                              icon: Icon(Icons.email),
                            ),
                            onChanged: (String value) {},
                            validator: (value) {
                              return value!.isEmpty
                                  ? 'Please enter email'
                                  : null;
                            },
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: _isObscure1,
                            controller: pwdController,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              hintText: 'Enter your password',
                              icon: Icon(Icons.password),
                              suffixIcon: IconButton(
                                icon: Icon(_isObscure1
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    _isObscure1 = !_isObscure1;
                                  });
                                },
                              ),
                            ),
                            onChanged: (value) {
                              _password = value;
                            },
                            validator: (value) {
                              if (value != null && value.isEmpty) {
                                return 'Password is required please enter';
                              }
                            },
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: _isObscure2,
                            controller: retypePwdController,
                            decoration: InputDecoration(
                              labelText: 'Re-enter Password',
                              hintText: 'Re-enter your password',
                              icon: Icon(Icons.password),
                              suffixIcon: IconButton(
                                icon: Icon(_isObscure2
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    _isObscure2 = !_isObscure2;
                                  });
                                },
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                _confirmPassword = value;
                              });
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Confirm password is required please enter';
                              }
                              if (value != _password) {
                                return 'Confirm password not matching';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          MaterialButton(
                            minWidth: 200,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(22.0)),
                            elevation: 6,
                            onPressed: () async {

                               try {
                                  final response = await _authService.register(
                                    userNameController.text,
                                    emailController.text,
                                    pwdController.text,
                                  );
                              print(response);
                                  if (response.isNotEmpty) {

                                    Navigator.push(
                                      context,

                                      MaterialPageRoute(builder: (context) => LoginScreen()),
                                    );


                                    print(response);
                                  } else {

                                    print('Login failed: ${response['message']}');
                                  }
                                } catch (error) {
                                  // Handle errors, e.g., show a generic error message
                                  print('Error: $error');
                                }

                            },

                            child: Text('CONTINUE'),
                            color: customTextColor,
                            textColor: Colors.white,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Divider(),
                          const SizedBox(
                            height: 15,
                          ),

                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildIndicator(bool isSelected) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1),
      child: Container(
        height: isSelected ? 12 : 8,
        width: isSelected ? 12 : 8,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? Colors.red : Colors.grey,
        ),
      ),
    );
  }
}
