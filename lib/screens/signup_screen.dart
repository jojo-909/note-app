import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/signup_form.dart';
import './subscription_screen.dart';
import '../providers/auth.dart';

enum AuthMode { Signup, Login }

class SignupScreen extends StatefulWidget {
  static const routeName = '/signup';
  final signupState;
  const SignupScreen(this.signupState, {Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  AuthMode _authMode = AuthMode.Signup;
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();

  bool isPasswordVisible = false;
  bool isloading = false;

  Map<String, String> _authData = {'username': '', 'email': '', 'password': ''};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.signupState == true) {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    _usernameController.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() {
      isloading = true;
    });
    _formKey.currentState?.save();
    try {
      if (_authMode == AuthMode.Signup) {
        await Provider.of<Auth>(context, listen: false).signUp(
            _authData['username']!,
            _authData['email']!,
            _authData['password']!);
      } else {
        await Provider.of<Auth>(context, listen: false)
            .signIn(_authData['email']!, _authData['password']!);
      }
      setState(() {
        isloading = false;
      });
      // Navigator.of(context).pushReplacementNamed('/first_note');
    } catch (error) {
      setState(() {
        isloading = false;
      });
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    // SignupForm form = SignupForm(_authMode == AuthMode.Signup ? true : false);
    return Scaffold(
      backgroundColor: Color.fromRGBO(248, 238, 226, 1),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'NOTELY',
                style: TextStyle(
                    fontFamily: 'TitanOne',
                    fontWeight: FontWeight.bold,
                    fontSize: 24),
              ),
              Expanded(
                child: form(_authMode == AuthMode.Signup ? true : false),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 40),
                width: double.infinity,
                height: 70,
                child: TextButton(
                  onPressed: () => _submit(),
                  // Navigator.of(context).push(MaterialPageRoute(
                  //   builder: (context) => SubscriptionScreen())),
                  child: isloading
                    ? CircularProgressIndicator(
                      color: Colors.white,
                    )
                    : Text(
                    _authMode == AuthMode.Signup ? 'Create Account' : 'Sign In',
                    style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        color: Color.fromARGB(255, 255, 251, 250)),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 217, 97, 76)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                  ),
                ),
              ),
              SizedBox(height: 15),
              GestureDetector(
                onTap: () => setState(() {
                  if (_authMode == AuthMode.Signup) {
                    _authMode = AuthMode.Login;
                  } else {
                    _authMode = AuthMode.Signup;
                  }
                }),
                child: Text(
                  _authMode == AuthMode.Signup
                      ? 'Already have an account?'
                      : 'Create Account',
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w800,
                      color: Color.fromARGB(255, 217, 97, 76)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget form(bool signup) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40),
      width: double.infinity,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Create a free account',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w900,
                    color: Color.fromRGBO(64, 59, 54, 1),
                    fontSize: 24)),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Join Notely for free. Create and share unlimited notes with your friends.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w700,
                  color: Color.fromRGBO(89, 85, 80, 1),
                  fontSize: 16),
            ),
            const SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (signup)
                    Container(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          const Text(
                            'Full Name',
                            style: TextStyle(
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.w700,
                                fontSize: 14),
                          ),
                          SizedBox(height: 5),
                          TextFormField(
                            controller: _usernameController,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                                hintText: 'John Doe',
                                filled: true,
                                fillColor: Colors.white,
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.cancel_outlined),
                                  onPressed: () {
                                    _usernameController.clear();
                                  },
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                )),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter full name";
                              }
                            },
                            onSaved: (value) {
                              _authData['username'] = _usernameController.text;
                            },
                          ),
                        ])),
                  SizedBox(height: 20),
                  Container(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        const Text(
                          'Email',
                          style: TextStyle(
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.w700,
                              fontSize: 14),
                        ),
                        SizedBox(height: 5),
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                              hintText: 'johndoe@email.com',
                              filled: true,
                              fillColor: Colors.white,
                              suffixIcon: IconButton(
                                icon: Icon(Icons.cancel_outlined),
                                onPressed: () {
                                  _emailController.clear();
                                },
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              )),
                          validator: (value) {
                            if (value!.isEmpty || !value.contains('@')) {
                              return 'Invalid Email';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _authData['email'] = _emailController.text;
                          },
                        ),
                      ])),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        const Text(
                          'Password',
                          style: TextStyle(
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.w700,
                              fontSize: 14),
                        ),
                        SizedBox(height: 5),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: !isPasswordVisible,
                          obscuringCharacter: '#',
                          validator: (value) {
                            if (value!.isEmpty || value.length < 5) {
                              return 'Password is too short';
                            }
                          },
                          onSaved: (value) {
                            _authData['password'] = _passwordController.text;
                          },
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                icon: isPasswordVisible
                                    ? Icon(Icons.visibility_off)
                                    : Icon(Icons.visibility),
                                onPressed: () {
                                  setState(() {
                                    isPasswordVisible = !isPasswordVisible;
                                  });
                                },
                              ),
                              hintText: '########',
                              filled: true,
                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              )),
                        ),
                      ])),
                ],
              ),
            )
          ]),
    );
  }
}
