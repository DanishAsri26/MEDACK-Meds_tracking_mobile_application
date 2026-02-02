import 'package:flutter/material.dart';
import 'package:lab_5/home_patient.dart';
import 'package:lab_5/signup.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Define the same colors as the Signup Page for consistency
    final Color darkContrastGreen = Color(0xFF1B5E20);
    final Color lightBgColor = Color(0xFFF1F8E9);

    return Scaffold(
      backgroundColor: lightBgColor, // Set background color
      body: Stack(
        children: [
          // Contrasting background circles
          Positioned(
            top: -60,
            left: -60,
            child: CircleAvatar(
              radius: 110,
              backgroundColor: darkContrastGreen.withValues(alpha: 0.1),
            ),
          ),
          Positioned(
            top: 150,
            right: -30,
            child: CircleAvatar(
              radius: 50,
              backgroundColor: darkContrastGreen.withValues(alpha: 0.05),
            ),
          ),
          Positioned(
            bottom: 120,
            right: -70,
            child: CircleAvatar(
              radius: 130,
              backgroundColor: darkContrastGreen.withValues(alpha: 0.1),
            ),
          ),
          Positioned(
            bottom: 40,
            left: 20,
            child: CircleAvatar(
              radius: 40,
              backgroundColor: darkContrastGreen.withValues(alpha: 0.05),
            ),
          ),

          // Main Content centered vertically
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: constraints.maxHeight),
                    child: IntrinsicHeight(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Spacer(),
                            Icon(
                              Icons.medical_services_rounded,
                              size: 100,
                              color: darkContrastGreen,
                            ),
                            SizedBox(height: 30),
                            Text(
                              'Welcome Back',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: darkContrastGreen,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Sign in to continue to Medack',
                              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 40),

                            _buildTextField(
                              icon: Icons.email_outlined,
                              label: 'Email',
                            ),
                            SizedBox(height: 15.0),
                            _buildTextField(
                              icon: Icons.lock_outline,
                              label: 'Password',
                              isObscure: true,
                            ),
                            
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  'Forgot Password?',
                                  style: TextStyle(color: darkContrastGreen),
                                ),
                              ),
                            ),
                            
                            SizedBox(height: 10.0),

                            ElevatedButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => Home_patient()),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: darkContrastGreen,
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 4,
                              ),
                              child: Text(
                                'Login',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            
                            Spacer(),
                            
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Don't have an account? "),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => SignupPage()),
                                      );
                                    },
                                    child: Text(
                                      'Sign Up',
                                      style: TextStyle(
                                        color: darkContrastGreen,
                                        fontWeight: FontWeight.bold,
                                      ),
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
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required IconData icon,
    required String label,
    bool isObscure = false,
  }) {
    return TextField(
      obscureText: isObscure,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.green[800]),
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey[700]),
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.9),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.green[800]!, width: 2),
        ),
      ),
    );
  }
}
