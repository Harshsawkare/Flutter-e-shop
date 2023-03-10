import 'package:eshop/Screens/Homepage.dart';
import 'package:eshop/Screens/Signup.dart';
import 'package:eshop/Services/AuthService.dart';
import 'package:eshop/constants.dart';
import 'package:eshop/helper.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  bool loading = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    setState(() {
      loading = false;
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: primaryDark,
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20) + EdgeInsets.symmetric(vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                ///top bar
                Text("e-Shop",
                  style: TextStyle(
                      color: secondaryLight,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontFamily: "poppins"
                  ),
                ),
                Expanded(child: SizedBox()),

                ///login
                Text("Login",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: "poppins"
                  ),
                ),
                SizedBox(
                  height: 22,
                ),

                ///email
                TextFormField(
                  onEditingComplete: () {
                    FocusScope.of(context).nextFocus();
                  },
                  controller: emailController,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: "poppins"
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter your email";
                    }
                    if (!Validator.isEmail(value)) {
                      return "Invalid Email";
                    }
                    return null;
                  },
                  decoration: registerInputDecoration.copyWith(
                    hintText: 'Enter your email',
                    fillColor: primaryLight,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: secondaryLight),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),

                ///password
                TextFormField(
                  onEditingComplete: () {
                    FocusScope.of(context).nextFocus();
                  },
                  controller: passwordController,
                  obscureText: true,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: "poppins"
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter your password";
                    }
                    return null;
                  },
                  decoration: registerInputDecoration.copyWith(
                    hintText: 'Enter your password',
                    fillColor: primaryLight,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: secondaryLight),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
                Expanded(child: SizedBox()),

                ///button
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: loading ?
                    Container(
                        width: 45,
                        height: 45,
                        child: CircularProgressIndicator(color: secondaryLight,)) :
                    Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      height: 45,
                      child:
                      ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();

                              if(emailController.text.isEmpty){
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(content: Text("Email can't be empty")));
                              } else {
                                if(passwordController.text.isEmpty){
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(content: Text("Password can't be empty")));
                                } else {
                                  setState(() {
                                    loading = !loading;
                                  });
                                  await AuthServices().signinUser(
                                      emailController.text,
                                      passwordController.text,
                                      context
                                  ).then((value){
                                    if(!value!){
                                      setState(() {
                                        loading = false;
                                      });
                                    }
                                  });
                                }
                              }
                            }
                          },

                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(secondaryLight),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ))
                          ),
                          child: Text("Login",
                            style: TextStyle(
                                color: primaryLight,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: "poppins"
                            ),
                          )
                      ),
                    ),
                  ),
                ),

                ///new here
                Center(
                  child: RichText(
                    text: TextSpan(
                      style:
                      const TextStyle(fontWeight: FontWeight.w600),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'New here? ',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontFamily: "poppins"
                            )
                        ),
                        TextSpan(
                            text: '  Signup',
                            style: TextStyle(
                                color: secondaryLight,
                                fontSize: 12,
                                fontFamily: "poppins"
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushReplacement(
                                  context, MaterialPageRoute(builder: (context) =>
                                    Signup()
                                ),
                                );
                              }),
                      ],
                    ),
                  ),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
