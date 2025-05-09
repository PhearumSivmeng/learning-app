import 'package:demo/auth/otp_verify.dart';
import 'package:demo/core/auth.dart';
import 'package:demo/core/util/my_theme.dart';
import 'package:demo/data/api/api_client.dart';
import 'package:demo/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final client = http.Client();
    final apiClient = ApiClient(client: client);

    return Scaffold(
      backgroundColor: MyTheme.bodyBackground,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0), // Add padding around the form
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
              mainAxisSize: MainAxisSize.min,
              children: [
                // Profile Icon
                const CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('assets/images/e-learning.png'),
                  backgroundColor: Colors.transparent,
                ),
                const SizedBox(height: 10),

                // Welcome Text
                const Text(
                  'Welcome to NakIT',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 45),

                // Email TextField
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.email),
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.grey.shade700),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Password TextField
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock),
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.grey.shade700),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    suffixIcon: const Icon(Icons.visibility_off),
                  ),
                ),
                const SizedBox(height: 12),

                // Forgot Password
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Forgot password?',
                      style: TextStyle(color: Colors.blue.shade600),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Login Button
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
                        final response = await apiClient.onLogin(arg: {
                          "email": emailController.value.text,
                          "password": passwordController.value.text,
                        });

                        if (response.status == "success") {
    
                          Auth.instance.onSaveUser(userModel: response.records);
                          print("Login Successful: ${response.records}");
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LandingScreen()),
                            (Route<dynamic> route) =>
                                false, // Remove all previous routes
                          );
                        } else {
                          print("Login Failed: ${response.msg}");
                        }
                      } catch (e) {
                        print("An error occurred: $e");
                      } finally {
                        client.close();
                      }
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // OutlinedButton.icon(
                //   onPressed: () {},
                //   icon: Image.asset(
                //     'assets/images/google-icon.png',
                //     height: 24,
                //   ),
                //   label: Text(
                //     'Sign in with Google',
                //     style: TextStyle(color: Colors.black),
                //   ),
                //   style: OutlinedButton.styleFrom(
                //     side: BorderSide(color: Colors.black12),
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(12),
                //     ),
                //     padding: EdgeInsets.symmetric(vertical: 14, horizontal: 85),
                //   ),
                // ),
                // SizedBox(height: 24),

                // Register Account
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                    TextButton(
                      onPressed: () {
                        Future.delayed(const Duration(milliseconds: 250), () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => OtpVerify(),
                            ),
                          );
                        });
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(color: Colors.blue.shade600),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
