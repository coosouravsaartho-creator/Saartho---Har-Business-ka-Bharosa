import 'package:flutter/material.dart';

void main() {
  runApp(const SaarthoApp());
}

class SaarthoApp extends StatelessWidget {
  const SaarthoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Saartho',
      theme: ThemeData(
        fontFamily: 'Arial',
        useMaterial3: true,
      ),
      home: const SetupAccountScreen(),
    );
  }
}

class SetupAccountScreen extends StatefulWidget {
  const SetupAccountScreen({super.key});

  @override
  State<SetupAccountScreen> createState() => _SetupAccountScreenState();
}

class _SetupAccountScreenState extends State<SetupAccountScreen> {
  final _nameController = TextEditingController();
  final _businessController = TextEditingController();
  final _mobileController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _businessController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Widget _inputField({
    required String label,
    required TextEditingController controller,
    TextInputType? keyboardType,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white.withOpacity(0.96),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 15,
          ),
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }

  Widget _infoSection({
    required String title,
    required String text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            text,
            style: TextStyle(
              color: Colors.white.withOpacity(0.92),
              fontSize: 15,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF4527A0),
              Color(0xFF1565C0),
              Color(0xFF00897B),
            ],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: 18,
                right: 28,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Skip Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(45, 45, 45, 35),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 1200,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 5,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              right: 55,
                              top: 15,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  'assets/saartho_logo.png',
                                  width: 220,
                                ),
                                const SizedBox(height: 30),
                                const Text(
                                  'Setup your account',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 34,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 35),
                                _infoSection(
                                  title: 'Our Goal',
                                  text:
                                      'Our goal is to make business management effortless by bringing essential business tools together in one reliable platform, built for speed, accuracy and growth.',
                                ),
                                _infoSection(
                                  title: 'Our Vision',
                                  text:
                                      'To create a future where managing a business is simple, intelligent and accessible to everyone.',
                                ),
                                _infoSection(
                                  title: 'Why Choose Us?',
                                  text:
                                      'Built for Business — Designed around real business needs.\n'
                                      'Easy to Use — Powerful features without unnecessary complexity.\n'
                                      'Secure & Reliable — Your business information deserves protection and trust.\n'
                                      'Ready to Grow — Built to support businesses from today to tomorrow.',
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Container(
                            padding: const EdgeInsets.all(30),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.94),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Set up your account',
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF202124),
                                  ),
                                ),
                                const SizedBox(height: 24),
                                _inputField(
                                  label: 'Your Name',
                                  controller: _nameController,
                                ),
                                _inputField(
                                  label: 'Business Name',
                                  controller: _businessController,
                                ),
                                _inputField(
                                  label: 'Enter Mobile Number',
                                  controller: _mobileController,
                                  keyboardType: TextInputType.phone,
                                ),
                                _inputField(
                                  label: 'Enter Email ID',
                                  controller: _emailController,
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                _inputField(
                                  label: 'Setup Password',
                                  controller: _passwordController,
                                  obscureText: _obscurePassword,
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _obscurePassword =
                                            !_obscurePassword;
                                      });
                                    },
                                    icon: Icon(
                                      _obscurePassword
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                    ),
                                  ),
                                ),
                                const Text(
                                  'Minimum password length is 8 characters. '
                                  'Alpha numeric and special characters are allowed.',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black54,
                                  ),
                                ),
                                const SizedBox(height: 14),
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFFF3CD),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Text(
                                    'Warning: Either Phone number or Email ID '
                                    'is required for Account setup.',
                                    style: TextStyle(
                                      color: Color(0xFF664D03),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          const Color(0xFF1565C0),
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: const Text(
                                      'Register Account',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 18),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextButton(
                                      onPressed: () {},
                                      child: const Text(
                                        'Already have an account? Login',
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {},
                                      child: const Text(
                                        'Restore Saartho Backup',
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
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
