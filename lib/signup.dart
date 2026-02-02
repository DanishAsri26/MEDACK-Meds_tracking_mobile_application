import 'package:flutter/material.dart';
import 'package:lab_5/login.dart';

class SignupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Color darkContrastGreen = Color(0xFF1B5E20);
    // Light background color to remove the "white box" effect
    final Color lightBgColor = Color(0xFFF1F8E9); 

    return Scaffold(
      backgroundColor: lightBgColor,
      body: Stack(
        children: [
          // Background Circles
          Positioned(
            top: -50,
            right: -50,
            child: CircleAvatar(
              radius: 100,
              backgroundColor: darkContrastGreen.withOpacity(0.1),
            ),
          ),
          Positioned(
            bottom: 100,
            left: -80,
            child: CircleAvatar(
              radius: 120,
              backgroundColor: darkContrastGreen.withOpacity(0.1),
            ),
          ),
          Positioned(
            top: 250,
            right: 40,
            child: CircleAvatar(
              radius: 40,
              backgroundColor: darkContrastGreen.withOpacity(0.05),
            ),
          ),
          Positioned(
            bottom: -30,
            right: 20,
            child: CircleAvatar(
              radius: 60,
              backgroundColor: darkContrastGreen.withOpacity(0.1),
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
                        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center, // Centers content vertically
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(height: 20),
                            Text(
                              'Create Account',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: darkContrastGreen,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Sign up to get started with Medack',
                              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 40),
                            
                            _buildTextField(
                              icon: Icons.person_outline,
                              label: 'Username',
                            ),
                            SizedBox(height: 15.0),
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
                            SizedBox(height: 30.0),
                            
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
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
                                'Sign Up',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            
                            Spacer(), // Pushes the bottom text slightly
                            
                            Padding(
                              padding: const EdgeInsets.only(top: 20, bottom: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Already have an account? "),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(builder: (context) => LoginPage()),
                                      );
                                    },
                                    child: Text(
                                      'Login',
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
        fillColor: Colors.white.withOpacity(0.9),
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
