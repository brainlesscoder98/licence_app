import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:license_master/custom_widgets/c_gap.dart';
import 'package:license_master/screens/home_screen.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../app_constants/app_constants.dart';
import '../../main.dart';

class LoginAuthPage extends StatefulWidget {
  @override
  _LoginAuthPageState createState() => _LoginAuthPageState();
}

class _LoginAuthPageState extends State<LoginAuthPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  String? _verificationId;
  bool _isCodeSent = false;
  bool _isLoading = false;
  String getGreeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 18) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  String? _phoneValidationText;
  String? _otpValidationText;

  void _validatePhoneNumber() {
    setState(() {
      if (_phoneController.text.isEmpty) {
        _phoneValidationText = "Phone number cannot be empty";
      } else if (_phoneController.text.length != 10) {
        _phoneValidationText = "Enter a valid phone number";
      } else {
        _phoneValidationText = null;
      }
    });
  }

  void _validateOTP() {
    setState(() {
      if (_otpController.text.isEmpty) {
        _otpValidationText = "OTP cannot be empty";
      } else if (_otpController.text.length != 6) {
        _otpValidationText = "Enter a valid OTP";
      } else {
        _otpValidationText = null;
      }
    });
  }
  void _validateOTPonChanged(String value) {
    setState(() {
      if (value.isEmpty || value.length != 6) {
        _otpValidationText = 'Please enter a valid OTP';
      } else {
        _otpValidationText = null;
      }
    });
  }

  Future<void> _verifyPhoneNumber() async {
    _validatePhoneNumber(); // Validate phone number
    if (_phoneValidationText != null)
      return; // Don't proceed if validation fails

    setState(() {
      _isLoading = true;
    });

    print("Starting phone number verification...");
    await _auth.verifyPhoneNumber(
      phoneNumber: "+91${_phoneController.text}",
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) async {
        print("Verification completed: $credential");
        await _auth.signInWithCredential(credential);
        setState(() {
          print("User signed in automatically");
          _isLoading = false;
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        print("Verification failed: ${e.message}");
        setState(() {
          _isLoading = false;
        });
      },
      codeSent: (String verificationId, int? resendToken) {
        print(
            "Code sent to ${_phoneController.text}, verificationId: $verificationId");
        setState(() {
          _verificationId = verificationId;
          _isCodeSent = true;
          _isLoading = false;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print("Code auto-retrieval timeout, verificationId: $verificationId");
        setState(() {
          _verificationId = verificationId;
          _isLoading = false;
        });
      },
    );
  }

  Future<void> _signInWithOTP() async {
    _validatePhoneNumber(); // Validate phone number
    _validateOTP(); // Validate OTP

    if (_phoneValidationText != null || _otpValidationText != null)
      return; // Don't proceed if validation fails

    setState(() {
      _isLoading = true;
    });
    if (_verificationId != null) {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: _otpController.text,
      );

      try {
        await _auth.signInWithCredential(credential);
        setState(() {
          print("User signed in with OTP");
          appStorage.write(AppConstants().isLoggedIn, '1');
          Get.snackbar("Success", "Otp verification successful.",
              backgroundColor: Colors.green, colorText: Colors.white);
          Get.offAll(() => HomeScreen());
          _isLoading = false;
        });
      } catch (e) {
        print("Error signing in with OTP: $e");
        setState(() {
          Get.snackbar("Failed!", "Otp verification failed.",
              backgroundColor: Colors.red, colorText: Colors.white);
        });
        _isLoading = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          height: Get.height,
          width: Get.width,
          padding: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 0, 0, 0), // Black
                Color.fromARGB(255, 0, 20, 21), // Dark Teal
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: ListView(
            children: [
              VGap(height: 50),
              Text(
                "${getGreeting()} !",
                style: GoogleFonts.poppins(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
                textAlign: TextAlign.center,
              ),
              VGap(height: 20),
              Text(
                "Login",
                style: GoogleFonts.poppins(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                textAlign: TextAlign.center,
              ),
              VGap(height: 90),
              VGap(height: 10),
              Container(
                width: Get.width,
                height: Get.height * 0.7,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Center(
                        child: TextField(
                          controller: _phoneController,
                          maxLength: 10,
                          decoration: InputDecoration(
                            counterText: '',
                            prefixText: '+91 ',
                            labelText: "Phone Number",
                            labelStyle: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            prefixStyle: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.5),
                                  width: 2.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.5),
                                  width: 2.0),
                            ),
                            errorText:
                                _phoneValidationText, // Show validation error text
                            errorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 2.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 2.0),
                            ),
                            filled: true,
                            fillColor: Colors.transparent,
                          ),
                          keyboardType: TextInputType.phone,
                          style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      VGap(height: 20),
                      if (_isCodeSent) ...[
                        TextField(
                          controller: _otpController,

                          maxLength: 6,
                          style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                          decoration: InputDecoration(
                            counterText: '',
                            labelText: "OTP",
                            labelStyle: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            prefixStyle: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            errorText: _otpValidationText,
                            // Show validation error text
                            errorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 2.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 2.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.5),
                                  width: 2.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.5),
                                  width: 2.0),
                            ),
                            filled: true,
                            fillColor: Colors.transparent,
                          ),
                          keyboardType: TextInputType.number,
                        ),
                        VGap(height: 40),
                        GestureDetector(
                          onTap: _signInWithOTP,
                          child: Container(
                            width: Get.width,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.teal.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: Colors.teal.withOpacity(0.3)),
                            ),
                            child: Center(
                              child: _isLoading // Conditionally show the loader
                                  ? Center(
                                      child: LoadingAnimationWidget.flickr(
                                      size: 50,
                                      leftDotColor: Colors.blue,
                                      rightDotColor: Colors.red,
                                    ))
                                  : Text(
                                      "Sign In with OTP",
                                      style: GoogleFonts.poppins(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                            ),
                          ),
                        ),
                      ],
                      if (!_isCodeSent)
                        GestureDetector(
                          onTap: _verifyPhoneNumber,
                          child: Container(
                            width: Get.width,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.teal.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: Colors.teal.withOpacity(0.3)),
                            ),
                            child: Center(
                              child: _isLoading // Conditionally show the loader
                                  ? Center(
                                      child: LoadingAnimationWidget.flickr(
                                      size: 50,
                                      leftDotColor: Colors.blue,
                                      rightDotColor: Colors.red,
                                    ))
                                  : Text(
                                      "Verify Phone Number",
                                      style: GoogleFonts.poppins(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
