import 'package:demo/auth/register.dart';
import 'package:demo/core/util/my_theme.dart';
import 'package:demo/data/api/api_client.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OtpVerify extends StatefulWidget {
  const OtpVerify({super.key});

  @override
  _EmailVerificationScreenState createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<OtpVerify> {
  final TextEditingController _emailController = TextEditingController();

  Future<void> _verifyOtp(String otp) async {
    final client = http.Client();
    final apiClient = ApiClient(client: client);

    try {
      final response = await apiClient.onVerifyOTP(arg: {
        "email": _emailController.text,
        "code": otp,
      });

      if (response.status == "success") {
        Future.delayed(const Duration(milliseconds: 250), () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => SignupScreen(),
            ),
          );
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to verify OTP: ${response.msg}')),
        );
      }
    } catch (e) {
      print("An error occurred: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An error occurred while verifying OTP')),
      );
    } finally {
      client.close();
    }
  }

  void _showOtpDialog() {
    final List<TextEditingController> otpControllers =
        List.generate(6, (_) => TextEditingController());

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Enter Your OTP Code'),
          content: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(6, (index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: 40,
                  child: TextFormField(
                    controller: otpControllers[index],
                    onChanged: (value) {
                      if (value.length == 1 && index < 5) {
                        FocusScope.of(context).nextFocus();
                      }
                      if (value.isEmpty && index > 0) {
                        FocusScope.of(context).previousFocus();
                      }
                    },
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      counterText: '', // Remove the counter
                    ),
                    maxLength: 1,
                    style: const TextStyle(fontSize: 15),
                  ),
                );
              }),
            ),
          ),
          actions: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade600,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () async {
                  String otp = otpControllers
                      .map((controller) => controller.text)
                      .join();
                  if (otp.length == 6) {
                    await _verifyOtp(otp);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Please enter all 6 digits')),
                    );
                  }
                },
                child: const Text(
                  'Verify',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final client = http.Client();
    final apiClient = ApiClient(client: client);

    return Scaffold(
      backgroundColor: MyTheme.bodyBackground,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 4,
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Enter your email-address to receive a verification code:',
                  style: TextStyle(fontSize: 20.0, height: 1.25),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.email),
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.grey.shade700),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 30.0),
                Center(
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade600,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          onPressed: () async {
                            try {
                              final response =
                                  await apiClient.onRequestOTP(arg: {
                                "email": _emailController.value.text,
                              });

                              if (response.status == "success") {
                                _showOtpDialog();
                              } else {
                                print("Failed Send: ${response.msg}");
                              }
                            } catch (e) {
                              print("An error occurred: $e");
                            } finally {
                              client.close();
                            }
                          },
                          child: const Text(
                            'Send OTP',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextButton(
                        onPressed: () => {
                          Future.delayed(const Duration(milliseconds: 250), () {
                            Navigator.pop(context);
                          })
                        },
                        child: Text(
                          'back to login',
                          style: TextStyle(color: Colors.blue.shade600),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
