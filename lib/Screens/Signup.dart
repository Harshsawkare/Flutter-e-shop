import 'package:eshop/Screens/Homepage.dart';
import 'package:eshop/Screens/Login.dart';
import 'package:eshop/constants.dart';
import 'package:eshop/helper.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: primaryDark,
        body: Padding(
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

              ///signup
              Text("Signup",
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

              ///name
              TextFormField(
                onEditingComplete: () {
                  FocusScope.of(context).nextFocus();
                },
                controller: nameController,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: "poppins"
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter your name";
                  }
                  return null;
                },
                decoration: registerInputDecoration.copyWith(
                  hintText: 'Enter your name',
                  fillColor: primaryLight,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: secondaryLight),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),

                ),
              ),
              SizedBox(
                height: 10,
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
                height: 10,
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
                    return "Enter a password";
                  }
                  return null;
                },
                decoration: registerInputDecoration.copyWith(
                  hintText: 'Enter a password',
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
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: 45,
                    child: ElevatedButton(
                        onPressed: () async {
                          // if (signupForm.currentState!.validate()) {
                          //   setState(() {
                          //     isLoading = true;
                          //   });
                          //   if (!isPhone) {
                          //     if (Validator.isEmail(
                          //         _controller.text)) {
                          //       try {
                          //         await auth
                          //             .signupWithEmailPassword(
                          //             _controller.text.trim(),
                          //             _passwordController.text
                          //                 .trim(),
                          //             UserType.USER);
                          //         signupForm.currentState!.reset();
                          //         setState(() {
                          //           isLoading = false;
                          //         });
                          //         Navigator.of(context).push(
                          //           CupertinoPageRoute(
                          //             builder: (context) =>
                          //                 EmailVerification(
                          //                   isPhoneVerified: false,
                          //                 ),
                          //           ),
                          //         );
                          //         // FostrRouter.goto(
                          //         //     context, Routes.addDetails);
                          //       } catch (error) {
                          //         setState(() {
                          //           isLoading = true;
                          //         });
                          //         handleError(error);
                          //       }
                          //     }
                          //   }
                          //   else {
                          //     if (Validator.isNumber(
                          //         _controller.text)) {
                          //       try {
                          //         String number =
                          //             countryCode.trim() +
                          //                 _controller.text.trim();
                          //
                          //         if (await checkIfUserExist(
                          //             number)) {
                          //           handleError(
                          //               "phone-already-in-use");
                          //         } else {
                          //           await auth.signInWithPhone(
                          //               context, number);
                          //           FostrRouter.goto(context,
                          //               Routes.otpVerification);
                          //         }
                          //       } catch (e) {
                          //         handleError(e);
                          //       }
                          //     }
                          //   }
                          //   setState(() {
                          //     isLoading = false;
                          //   });
                          // }

                          Navigator.push(context, MaterialPageRoute(builder: (context) =>
                              Homepage()
                          ));
                        },

                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(secondaryLight),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ))
                        ),
                        child: Text("Signup",
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

              ///already have an account
              Center(
                child: RichText(
                  text: TextSpan(
                    style:
                    const TextStyle(fontWeight: FontWeight.w600),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Already a User? ',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontFamily: "poppins"
                          )
                      ),
                      TextSpan(
                          text: '  Login',
                          style: TextStyle(
                              color: secondaryLight,
                              fontSize: 12,
                              fontFamily: "poppins"
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushReplacement(
                                context, MaterialPageRoute(builder: (context) =>
                                        Login()
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
    );
  }
}
