import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'web_theme_guard_io.dart' if (dart.library.html) 'web_theme_guard_web.dart' as web_theme_guard;

void main() {
  web_theme_guard.resetBrowserChrome();
  runApp(const SaarthoApp());
}

class SaarthoApp extends StatefulWidget {
  const SaarthoApp({super.key});

  @override
  State<SaarthoApp> createState() => _SaarthoAppState();
}

class _SaarthoAppState extends State<SaarthoApp> {
  final _themeController = SaarthoThemeController();

  @override
  void initState() {
    super.initState();
    _themeController.load();
  }

  @override
  void dispose() {
    _themeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _themeController,
      builder: (context, _) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Saartho',
        theme: _themeController.theme,
        home: SetupAccountScreen(themeController: _themeController),
      ),
    );
  }
}

class _LoginAtmospherePainter extends CustomPainter {
  const _LoginAtmospherePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final baseTint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0x33FFFFFF),
          Color(0x09F8D8EB),
          Color(0x0B8EE7FF),
          Color(0x0BFFFFFF),
        ],
      ).createShader(Offset.zero & size);
    canvas.drawRect(Offset.zero & size, baseTint);

    final glows = <({Offset center, double radius, Color start, Color end, double blur})>[
      (center: const Offset(0.18, 0.18), radius: 260, start: Color(0x66F7B4D7), end: Color(0x00F7B4D7), blur: 70),
      (center: const Offset(0.78, 0.12), radius: 290, start: Color(0x66A7F3FF), end: Color(0x00A7F3FF), blur: 90),
      (center: const Offset(0.66, 0.78), radius: 340, start: Color(0x66D9C3FF), end: Color(0x00D9C3FF), blur: 100),
      (center: const Offset(0.25, 0.82), radius: 300, start: Color(0x66C8F8D8), end: Color(0x00C8F8D8), blur: 80),
      (center: const Offset(0.9, 0.55), radius: 250, start: Color(0x66FFDCA8), end: Color(0x00FFDCA8), blur: 55),
    ];

    for (final glow in glows) {
      final paint = Paint()
        ..shader = RadialGradient(
          colors: [glow.start, glow.end],
          stops: const [0.14, 1],
        ).createShader(
          Rect.fromCircle(
            center: Offset(
              size.width * glow.center.dx,
              size.height * glow.center.dy,
            ),
            radius: glow.radius,
          ),
        )
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, glow.blur);
      canvas.drawCircle(
        Offset(
          size.width * glow.center.dx,
          size.height * glow.center.dy,
        ),
        glow.radius,
        paint,
      );
    }

    final upperRibbon = Path()
      ..moveTo(-size.width * 0.1, size.height * 0.28)
      ..quadraticBezierTo(
        size.width * 0.3,
        size.height * 0.08,
        size.width * 1.08,
        size.height * 0.24,
      );
    final lowerRibbon = Path()
      ..moveTo(-size.width * 0.06, size.height * 0.84)
      ..quadraticBezierTo(
        size.width * 0.48,
        size.height * 0.62,
        size.width * 1.08,
        size.height * 0.76,
      );
    final middleRibbon = Path()
      ..moveTo(-size.width * 0.04, size.height * 0.52)
      ..quadraticBezierTo(
        size.width * 0.42,
        size.height * 0.42,
        size.width * 1.1,
        size.height * 0.55,
      );

    final ribbonPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.1
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 30);

    canvas.drawPath(upperRibbon, ribbonPaint..color = const Color(0x44F7D5EE));
    canvas.drawPath(lowerRibbon, ribbonPaint..color = const Color(0x3FB8F5FF));
    canvas.drawPath(middleRibbon, ribbonPaint..color = const Color(0x3FC3FFD9));

    final highlight = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.01
      ..color = const Color(0xA6FFFFFF)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);
    canvas.drawPath(upperRibbon, highlight);
    canvas.drawPath(lowerRibbon, highlight..color = const Color(0xA6DFF8FF));
    canvas.drawPath(middleRibbon, highlight..color = const Color(0xA8DFFBE6));
  }

  @override
  bool shouldRepaint(covariant _LoginAtmospherePainter oldDelegate) => false;
}

class SetupAccountScreen extends StatefulWidget {
  const SetupAccountScreen({super.key, required this.themeController});

  final SaarthoThemeController themeController;

  @override
  State<SetupAccountScreen> createState() => _SetupAccountScreenState();
}

class _SetupAccountScreenState extends State<SetupAccountScreen> {
  static const _surface = Color(0xFFFFFFFF);
  static const _navy = Color(0xFF0F2747);
  static const _blue = Color(0xFF1769E0);
  static const _mutedText = Color(0xFF52616F);
  static const _border = Color(0xFFD7E0EA);
  static const _fieldBackground = Color(0xFFF7F9FC);
  static const _warningBackground = Color(0xFFFFF4D6);
  static const _warningText = Color(0xFF6B4B00);

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
          fillColor: _fieldBackground,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: _border),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: _border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: _blue, width: 2),
          ),
          labelStyle: const TextStyle(color: _mutedText),
          floatingLabelStyle: const TextStyle(color: _blue),
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
    final headerColor = switch (title) {
      'Our Goal' => const Color(0xFF1F2F7A),
      'Our Vision' => const Color(0xFF2B5AA9),
      'Why Choose Us?' => const Color(0xFF3A5B9B),
      _ => const Color(0xFF122B53),
    };

    final bodyColor = switch (title) {
      'Our Goal' => const Color(0xFF163B63),
      'Our Vision' => const Color(0xFF23497D),
      'Why Choose Us?' => const Color(0xFF2D4E7A),
      _ => const Color(0xFF24456A),
    };

    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: headerColor,
              fontSize: 22,
              fontWeight: FontWeight.w800,
              shadows: [
                Shadow(
                  color: Colors.white.withValues(alpha: 0.5),
                  blurRadius: 10,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            text,
            style: TextStyle(
              color: bodyColor,
              fontSize: 15,
              height: 1.6,
              fontWeight: FontWeight.w600,
              shadows: [
                Shadow(
                  color: Colors.white.withValues(alpha: 0.28),
                  blurRadius: 8,
                  offset: const Offset(0, 1),
                ),
              ],
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
              Color(0xFFF9D5EA),
              Color(0xFFDFF7FF),
              Color(0xFFEFFDF8),
              Color(0xFFE8F0FF),
              Color(0xFFE9F7DE),
              Color(0xFFF7EAD4),
            ],
            stops: [0.0, 0.28, 0.45, 0.68, 0.84, 1.0],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              const Positioned.fill(
                child: IgnorePointer(
                  child: CustomPaint(
                    painter: _LoginAtmospherePainter(),
                  ),
                ),
              ),
              Positioned(
                top: -45,
                left: -30,
                width: 420,
                height: 420,
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [Color(0x66F8AFE0), Color(0x00F8AFE0)],
                      radius: 1.1,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 120,
                right: -20,
                width: 470,
                height: 470,
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [Color(0x66FFD1A6), Color(0x00FFD1A6)],
                      radius: 1.0,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: -80,
                left: 120,
                width: 500,
                height: 500,
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [Color(0x52C5EEFF), Color(0x00C5EEFF)],
                      radius: 1.25,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 18,
                right: 20,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 18),
                  child: ElevatedButton(
                    onPressed: () => _openDashboard(replaceCurrent: true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0E2C73),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                      shadowColor: const Color(0x4D0E2C73),
                    ),
                    child: const Text(
                      'Skip Login',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 35),
                child: Center(
                  child: SizedBox(
                    width: double.infinity,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1220),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final isNarrow = constraints.maxWidth < 800;
                          final horizontalPadding = isNarrow ? 20.0 : 45.0;
                          final leftPanel = Padding(
                            padding: EdgeInsets.only(
                              right: isNarrow ? 0 : 55,
                              top: 15,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Container(
                                    width: 360,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 14,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(alpha: 0.72),
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(
                                        color: Colors.white.withValues(alpha: 0.7),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xFFB3BDE5).withValues(alpha: 0.38),
                                          blurRadius: 30,
                                          offset: const Offset(0, 18),
                                        ),
                                      ],
                                    ),
                                    child: Image.asset(
                                      'assets/saartho_logo.png',
                                      width: 280,
                                      fit: BoxFit.contain,
                                    ),
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
                          );
                          final accountCard = Container(
                            padding: const EdgeInsets.all(30),
                            decoration: BoxDecoration(
                              color: _surface.withValues(alpha: 0.96),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: const Color(0xFFF0F4FA),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0x1A1E3A68),
                                  blurRadius: 28,
                                  spreadRadius: 1,
                                  offset: const Offset(0, 16),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Set up your account',
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: _navy,
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
                                        _obscurePassword = !_obscurePassword;
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
                                    color: _mutedText,
                                  ),
                                ),
                                const SizedBox(height: 14),
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: _warningBackground,
                                    border: Border.all(
                                      color: const Color(0xFFE8C66A),
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Text(
                                    'Warning: Either Phone number or Email ID '
                                    'is required for Account setup.',
                                    style: TextStyle(
                                      color: _warningText,
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
                                    onPressed: () => _openDashboard(),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF0E63E0),
                                      foregroundColor: Colors.white,
                                      shadowColor: const Color(0x3D0E63E0),
                                      elevation: 3,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
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
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    SizedBox(
                                      width: double.infinity,
                                      child: TextButton(
                                        onPressed: () => _openDashboard(),
                                        style: TextButton.styleFrom(
                                          foregroundColor: const Color(0xFF1A3E84),
                                        ),
                                        child: const Text(
                                          'Already have an account? Login',
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      child: TextButton.icon(
                                        onPressed: () {},
                                        style: TextButton.styleFrom(
                                          foregroundColor: const Color(0xFF0B7AA8),
                                          padding: const EdgeInsets.symmetric(vertical: 6),
                                        ),
                                        icon: const Icon(Icons.restore, size: 22),
                                        label: const Text(
                                          'Restore Saartho Backup',
                                          style: TextStyle(fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );

                          final content = isNarrow
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    leftPanel,
                                    const SizedBox(height: 28),
                                    accountCard,
                                  ],
                                )
                              : Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(flex: 5, child: leftPanel),
                                    Expanded(flex: 5, child: accountCard),
                                  ],
                                );

                          return Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: horizontalPadding,
                            ),
                            child: content,
                          );
                        },
                      ),
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

  void _openDashboard({bool replaceCurrent = false}) {
    final route = MaterialPageRoute<void>(
      builder: (_) => DashboardScreen(
        userName: _nameController.text.trim(),
        businessName: _businessController.text.trim(),
        themeController: widget.themeController,
      ),
    );

    if (replaceCurrent) {
      Navigator.of(context).pushReplacement(route);
      return;
    }

    Navigator.of(context).push(route);
  }
}

class SaarthoContacts {
  static const call = '8017706169';
  static const email = 'coo.sourav.saartho@gmail.com';
  static const whatsapp = '9163875160';
}

class SaarthoThemes {
  static const names = [
    'Dark Royal Blue & White', 'Dark Teal and Gray', 'Dark Purple and Lavender',
    'Dark Emerald and Mint', 'Amber and Orange', 'Dark Mode',
    'Emerald Green and Mint', 'Coral and Peach', 'Slate Blue and Gray',
    'Indigo and Sky Blue',
  ];
  static const primary = Color(0xFF0B3D91);
  static const accent = Color(0xFF00B8D4);

  static const _palettes = <String, SaarthoPalette>{
    'Dark Royal Blue & White': SaarthoPalette(primary: Color(0xFF123B8F), secondary: Color(0xFF2F80ED), surface: Colors.white, background: Color(0xFFF2F6FC), elevated: Color(0xFFE2EBF8), text: Color(0xFF101828), mutedText: Color(0xFF475467), icon: Color(0xFF1769E0), border: Color(0xFFD5E2F5), selectedBackground: Color(0xFF1769E0), selectedForeground: Colors.white, buttonBackground: Color(0xFF1769E0), buttonForeground: Colors.white, inputBackground: Color(0xFFF7F9FC), inputText: Color(0xFF101828), inputHint: Color(0xFF667085), dialogBackground: Colors.white, dialogText: Color(0xFF101828)),
    'Dark Teal and Gray': SaarthoPalette(primary: Color(0xFF075E63), secondary: Color(0xFF57C7B5), surface: Colors.white, background: Color(0xFFEAF7F5), elevated: Color(0xFFD4EEE9), text: Color(0xFF102A2D), mutedText: Color(0xFF4D6668), icon: Color(0xFF0A6E73), border: Color(0xFFB9DDD7), selectedBackground: Color(0xFF087F86), selectedForeground: Colors.white, buttonBackground: Color(0xFF075E63), buttonForeground: Colors.white, inputBackground: Color(0xFFF5FBFA), inputText: Color(0xFF102A2D), inputHint: Color(0xFF607B7D), dialogBackground: Colors.white, dialogText: Color(0xFF102A2D)),
    'Dark Purple and Lavender': SaarthoPalette(primary: Color(0xFF542C82), secondary: Color(0xFFD4B9FF), surface: Colors.white, background: Color(0xFFF7F2FF), elevated: Color(0xFFE9DDF8), text: Color(0xFF211631), mutedText: Color(0xFF655A72), icon: Color(0xFF5B2DB1), border: Color(0xFFDCCCF0), selectedBackground: Color(0xFF673AB7), selectedForeground: Colors.white, buttonBackground: Color(0xFF542C82), buttonForeground: Colors.white, inputBackground: Color(0xFFFBF9FE), inputText: Color(0xFF211631), inputHint: Color(0xFF746A82), dialogBackground: Colors.white, dialogText: Color(0xFF211631)),
    'Dark Emerald and Mint': SaarthoPalette(primary: Color(0xFF086B50), secondary: Color(0xFF9BE7C4), surface: Colors.white, background: Color(0xFFEDF9F2), elevated: Color(0xFFD8EEE3), text: Color(0xFF102B21), mutedText: Color(0xFF50675D), icon: Color(0xFF087A5C), border: Color(0xFFBFE0CE), selectedBackground: Color(0xFF087A5C), selectedForeground: Colors.white, buttonBackground: Color(0xFF086B50), buttonForeground: Colors.white, inputBackground: Color(0xFFF7FCF9), inputText: Color(0xFF102B21), inputHint: Color(0xFF62786D), dialogBackground: Colors.white, dialogText: Color(0xFF102B21)),
    'Amber and Orange': SaarthoPalette(primary: Color(0xFF9A5B00), secondary: Color(0xFFFFB300), surface: Colors.white, background: Color(0xFFFFF8E8), elevated: Color(0xFFFFE7B0), text: Color(0xFF30200A), mutedText: Color(0xFF6E5A39), icon: Color(0xFFB76A00), border: Color(0xFFEACB8A), selectedBackground: Color(0xFFE88700), selectedForeground: Color(0xFF2D1B00), buttonBackground: Color(0xFF9A5B00), buttonForeground: Colors.white, inputBackground: Color(0xFFFFFCF4), inputText: Color(0xFF30200A), inputHint: Color(0xFF7A694A), dialogBackground: Colors.white, dialogText: Color(0xFF30200A)),
    'Dark Mode': SaarthoPalette(primary: Color(0xFF263238), secondary: Color(0xFF80CBC4), surface: Color(0xFF26353B), background: Color(0xFF172126), elevated: Color(0xFF30434A), text: Colors.white, mutedText: Color(0xFFCFD8DC), icon: Color(0xFF80CBC4), border: Color(0xFF4B6269), selectedBackground: Color(0xFF40636A), selectedForeground: Colors.white, buttonBackground: Color(0xFF80CBC4), buttonForeground: Color(0xFF102326), inputBackground: Color(0xFF30434A), inputText: Colors.white, inputHint: Color(0xFFB0BEC5), dialogBackground: Color(0xFF26353B), dialogText: Colors.white),
    'Emerald Green and Mint': SaarthoPalette(primary: Color(0xFF18794E), secondary: Color(0xFF8CE0B5), surface: Colors.white, background: Color(0xFFEEF9F0), elevated: Color(0xFFD8EEDC), text: Color(0xFF102B1C), mutedText: Color(0xFF53685B), icon: Color(0xFF188651), border: Color(0xFFBFE0C5), selectedBackground: Color(0xFF188651), selectedForeground: Colors.white, buttonBackground: Color(0xFF18794E), buttonForeground: Colors.white, inputBackground: Color(0xFFF8FCF8), inputText: Color(0xFF102B1C), inputHint: Color(0xFF65796B), dialogBackground: Colors.white, dialogText: Color(0xFF102B1C)),
    'Coral and Peach': SaarthoPalette(primary: Color(0xFFB84A3A), secondary: Color(0xFFFFB39C), surface: Colors.white, background: Color(0xFFFFF1EC), elevated: Color(0xFFFFE0D6), text: Color(0xFF351A17), mutedText: Color(0xFF755953), icon: Color(0xFFC54C3A), border: Color(0xFFF0C8BC), selectedBackground: Color(0xFFD95745), selectedForeground: Colors.white, buttonBackground: Color(0xFFB84A3A), buttonForeground: Colors.white, inputBackground: Color(0xFFFFFAF8), inputText: Color(0xFF351A17), inputHint: Color(0xFF856A63), dialogBackground: Colors.white, dialogText: Color(0xFF351A17)),
    'Slate Blue and Gray': SaarthoPalette(primary: Color(0xFF40566F), secondary: Color(0xFFAFC1D4), surface: Colors.white, background: Color(0xFFF1F5F8), elevated: Color(0xFFDCE5EC), text: Color(0xFF17212B), mutedText: Color(0xFF586978), icon: Color(0xFF45647F), border: Color(0xFFC7D3DE), selectedBackground: Color(0xFF526E89), selectedForeground: Colors.white, buttonBackground: Color(0xFF40566F), buttonForeground: Colors.white, inputBackground: Color(0xFFF8FAFC), inputText: Color(0xFF17212B), inputHint: Color(0xFF6B7B89), dialogBackground: Colors.white, dialogText: Color(0xFF17212B)),
    'Indigo and Sky Blue': SaarthoPalette(primary: Color(0xFF3949AB), secondary: Color(0xFF81D4FA), surface: Colors.white, background: Color(0xFFF1F5FF), elevated: Color(0xFFDCE5FA), text: Color(0xFF171B3A), mutedText: Color(0xFF59617B), icon: Color(0xFF3F51B5), border: Color(0xFFC8D5F2), selectedBackground: Color(0xFF3949AB), selectedForeground: Colors.white, buttonBackground: Color(0xFF3949AB), buttonForeground: Colors.white, inputBackground: Color(0xFFF8FAFF), inputText: Color(0xFF171B3A), inputHint: Color(0xFF6D7692), dialogBackground: Colors.white, dialogText: Color(0xFF171B3A)),
  };

  static ThemeData themeFor(String name) {
    final palette = paletteFor(name);
    final scheme = ColorScheme.fromSeed(seedColor: palette.primary, brightness: Brightness.light).copyWith(
      primary: palette.primary, secondary: palette.secondary, surface: palette.surface,
      surfaceContainer: palette.elevated, surfaceContainerHighest: palette.background,
      onSurface: palette.text, onSurfaceVariant: palette.mutedText,
      onPrimary: palette.buttonForeground,
      onSecondary: palette.selectedForeground,
      outline: palette.border,
      outlineVariant: palette.border,
      error: const Color(0xFFB3261E),
      onError: Colors.white,
    );
    return ThemeData(
      fontFamily: 'Arial',
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: palette.background,
      cardTheme: CardThemeData(color: palette.surface, surfaceTintColor: Colors.transparent, elevation: 3),
      dividerTheme: DividerThemeData(color: palette.border),
      inputDecorationTheme: InputDecorationTheme(filled: true, fillColor: palette.inputBackground, labelStyle: TextStyle(color: palette.inputHint), hintStyle: TextStyle(color: palette.inputHint), focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: palette.secondary, width: 2))),
      dialogTheme: DialogThemeData(backgroundColor: palette.dialogBackground, titleTextStyle: TextStyle(color: palette.dialogText, fontSize: 24, fontWeight: FontWeight.bold), contentTextStyle: TextStyle(color: palette.dialogText)),
      popupMenuTheme: PopupMenuThemeData(color: palette.surface, surfaceTintColor: Colors.transparent),
      elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(backgroundColor: palette.buttonBackground, foregroundColor: palette.buttonForeground)),
      textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: palette.primary)),
      iconTheme: IconThemeData(color: palette.icon),
      textTheme: ThemeData.light().textTheme.apply(
        bodyColor: palette.text,
        displayColor: palette.text,
      ),
      listTileTheme: ListTileThemeData(
        textColor: palette.text,
        iconColor: palette.icon,
        selectedColor: palette.selectedForeground,
        selectedTileColor: palette.selectedBackground,
      ),
    );
  }

  static SaarthoPalette paletteFor(String name) => _palettes[name] ?? _palettes[names.first]!;
}

class SaarthoPalette {
  const SaarthoPalette({
    required this.primary,
    required this.secondary,
    required this.surface,
    required this.background,
    required this.elevated,
    required this.text,
    required this.mutedText,
    required this.icon,
    required this.border,
    required this.selectedBackground,
    required this.selectedForeground,
    required this.buttonBackground,
    required this.buttonForeground,
    required this.inputBackground,
    required this.inputText,
    required this.inputHint,
    required this.dialogBackground,
    required this.dialogText,
  });
  final Color primary;
  final Color secondary;
  final Color surface;
  final Color background;
  final Color elevated;
  final Color text;
  final Color mutedText;
  final Color icon;
  final Color border;
  final Color selectedBackground;
  final Color selectedForeground;
  final Color buttonBackground;
  final Color buttonForeground;
  final Color inputBackground;
  final Color inputText;
  final Color inputHint;
  final Color dialogBackground;
  final Color dialogText;
}

class SaarthoThemeController extends ChangeNotifier {
  static const _preferenceKey = 'selected_theme';
  String selected = SaarthoThemes.names.first;

  ThemeData get theme => SaarthoThemes.themeFor(selected);

  Future<void> load() async {
    final preferences = await SharedPreferences.getInstance();
    final savedTheme = preferences.getString(_preferenceKey);
    if (savedTheme != null && SaarthoThemes.names.contains(savedTheme)) {
      selected = savedTheme;
      notifyListeners();
    }
  }

  Future<void> apply(String themeName) async {
    selected = themeName;
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_preferenceKey, themeName);
    notifyListeners();
  }
}

class SaarthoPlan {
  static const name = 'Saartho Max Free Premium';
  static const trialDays = 7;
  final DateTime? installationDate;

  const SaarthoPlan({this.installationDate});

  String get expiryLabel => installationDate == null
      ? 'Expiry date will appear here'
      : 'Expires ${_date(installationDate!.add(const Duration(days: trialDays)))}';

  static String _date(DateTime date) => '${date.day.toString().padLeft(2, '0')}/'
      '${date.month.toString().padLeft(2, '0')}/${date.year}';
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key, this.userName = '', this.businessName = '', required this.themeController});
  final String userName;
  final String businessName;
  final SaarthoThemeController themeController;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool _advanced = false;
  bool _privacy = false;
  String _dateFilter = 'Today';
  DateTime? _customStart;
  DateTime? _customEnd;
  int _expiryDays = 30;
  final _plan = const SaarthoPlan();
  static const List<String> _dateOptions = [
    'Today',
    'Yesterday',
    'Last 3 Months',
    'Last 6 Months',
    'Custom Date Range',
  ];
  final Map<String, String> _sectionDateFilters = {
    'Sale Information': 'Today',
    'Purchase Information': 'Today',
    'Receivable Balance': 'Today',
    'Payable Balance': 'Today',
  };
  final Map<String, DateTimeRange?> _sectionCustomRanges = {
    'Sale Information': null,
    'Purchase Information': null,
    'Receivable Balance': null,
    'Payable Balance': null,
  };

  String get _greeting {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning';
    if (hour < 17) return 'Good Afternoon';
    if (hour < 21) return 'Good Evening';
    return 'Good Night';
  }

  IconData get _greetingIcon => DateTime.now().hour < 17
      ? Icons.wb_sunny_rounded
      : Icons.nightlight_round;

  bool _isRoyalBlueWhiteTheme() => widget.themeController.selected == 'Dark Royal Blue & White';

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
        drawer: _sideMenu(),
        body: SafeArea(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: _isRoyalBlueWhiteTheme()
                    ? const [Color(0xFF0C2F7A), Color(0xFF123B8F), Color(0xFF1A4FB2)]
                    : [colors.surfaceContainerHighest, colors.surface, colors.surfaceContainerHighest],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
              final wide = constraints.maxWidth >= 900;
              return Column(children: [
                _taskBar(),
                Expanded(child: wide ? Row(children: [_sideMenu(), Expanded(child: _content())]) : _content()),
              ]);
              },
            ),
          ),
        ),
    );
  }

  Widget _taskBar() => LayoutBuilder(builder: (context, constraints) {
        final narrow = constraints.maxWidth < 900;
        return Container(
          height: 58,
          padding: const EdgeInsets.symmetric(horizontal: 18),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.secondary],
            ),
            boxShadow: [BoxShadow(color: Theme.of(context).colorScheme.secondary.withValues(alpha: .22), blurRadius: 14, offset: const Offset(0, 4))],
          ),
          child: Row(children: [
            if (narrow) Builder(builder: (context) => IconButton(tooltip: 'Open navigation', onPressed: () => Scaffold.of(context).openDrawer(), color: Colors.white, icon: const Icon(Icons.menu))),
            _menuButton('Company', Icons.business, (buttonContext, link) => _companyMenu(buttonContext, link)),
            _menuButton('Help', Icons.help_outline, (buttonContext, link) => _helpMenu(buttonContext, link)),
            _menuButton('Shortcut', Icons.keyboard_alt_outlined, (buttonContext, link) => _shortcutMenu(buttonContext, link)),
            IconButton(tooltip: 'Refresh app', onPressed: () {}, color: Colors.white, icon: const Icon(Icons.refresh)),
            const Spacer(),
            const Text('SAARTHO', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
          ]),
        );
      });

  Widget _menuButton(String label, IconData icon, void Function(BuildContext, LayerLink) onTap) {
    final link = LayerLink();
    return Builder(
      builder: (buttonContext) => CompositedTransformTarget(
        link: link,
        child: TextButton.icon(
          onPressed: () => onTap(buttonContext, link),
          icon: Icon(icon, size: 18),
          label: Text(label),
          style: TextButton.styleFrom(foregroundColor: Colors.white),
        ),
      ),
    );
  }

  void _showMenu(BuildContext buttonContext, LayerLink link, Widget child) {
    final overlay = Overlay.of(buttonContext);
    late OverlayEntry entry;
    entry = OverlayEntry(
      builder: (context) => Positioned.fill(
        child: Stack(children: [
          GestureDetector(onTap: entry.remove, behavior: HitTestBehavior.translucent),
          CompositedTransformFollower(
            link: link,
            showWhenUnlinked: false,
            offset: const Offset(0, 44),
            child: Material(
              elevation: 12,
              borderRadius: BorderRadius.circular(14),
              color: Theme.of(buttonContext).colorScheme.surface,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 340, maxHeight: 460),
                child: SingleChildScrollView(padding: const EdgeInsets.all(12), child: child),
              ),
            ),
          ),
        ]),
      ),
    );
    overlay.insert(entry);
  }

  void _companyMenu(BuildContext buttonContext, LayerLink link) => _showMenu(buttonContext, link, Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('Active company', style: TextStyle(fontWeight: FontWeight.bold)),
        Text(widget.businessName.isEmpty ? 'No company selected' : widget.businessName),
        const Divider(),
        TextButton.icon(onPressed: () {}, icon: const Icon(Icons.swap_horiz), label: const Text('Change Company')),
        TextButton.icon(onPressed: () {}, icon: const Icon(Icons.add_business), label: const Text('Add New Company')),
      ]));

  void _helpMenu(BuildContext buttonContext, LayerLink link) => _showMenu(buttonContext, link, Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
        TextButton(onPressed: () {}, child: const Text('Check for Updates')),
        const Text('Current App Version: 1.0.0'),
        TextButton(onPressed: () => _contactDialog(), child: const Text('Contact Us')),
      ]));

  void _shortcutMenu(BuildContext buttonContext, LayerLink link) => _showMenu(buttonContext, link, const Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Navigation shortcuts', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('Home     Ctrl + H'), Text('Parties  Ctrl + P'), Text('Sale     Ctrl + S'),
        Text('Purchase Ctrl + B'), Text('Reports  Ctrl + R'),
      ]));

  void _contactDialog() => showDialog<void>(context: context, builder: (_) => AlertDialog(
        title: const Text('Contact Us'),
        content: const Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Call: ${SaarthoContacts.call}'), Text('Email: ${SaarthoContacts.email}'), Text('WhatsApp: ${SaarthoContacts.whatsapp}'),
        ]),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close'))],
      ));

  Widget _sideMenu() {
    final items = ['Home', 'Parties', 'Items & Services', 'Sale', 'Purchase', 'Expense', 'Cash and Bank', 'Reports', 'Additional Options', 'Settings', 'Backup & Restore', 'Change UI Theme Colour', 'Multi Device Sync', 'Plan & Pricing', 'Plan Status', 'Give Feedback'];
    final colors = Theme.of(context).colorScheme;
    final royal = _isRoyalBlueWhiteTheme();
    return Container(width: 260, decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: royal ? const [Color(0xFF0B3D91), Color(0xFF123B8F)] : [colors.surfaceContainerHighest, colors.surface],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      boxShadow: [BoxShadow(color: (royal ? const Color(0xFF0B2E6B) : colors.primary).withValues(alpha: .22), blurRadius: 16, offset: const Offset(3, 0))],
    ), child: ListView(padding: const EdgeInsets.fromLTRB(14, 14, 14, 24), children: [
      Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: royal ? const Color(0xFF0D4AAE) : colors.primaryContainer,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(children: [
          Expanded(child: Text(widget.businessName.isEmpty ? 'Add Company Name' : widget.businessName, style: TextStyle(fontWeight: FontWeight.bold, color: royal ? Colors.white : null))),
          Icon(Icons.edit_outlined, size: 18, color: royal ? Colors.white : null),
        ])),
      const SizedBox(height: 14), for (final item in items) _sideItem(item),
    ]));
  }

  Color _menuTextColor(BuildContext context, {required bool selected}) {
    if (_isRoyalBlueWhiteTheme()) return Colors.white;

    final palette = SaarthoThemes.paletteFor(widget.themeController.selected);
    if (selected) return palette.selectedForeground;

    final sidebarSurface = Theme.of(context).colorScheme.surface;
    return sidebarSurface.computeLuminance() > 0.65 ? palette.text : Colors.white;
  }

  Color _menuIconColor(BuildContext context, {required bool selected}) {
    if (_isRoyalBlueWhiteTheme()) return Colors.white;

    final palette = SaarthoThemes.paletteFor(widget.themeController.selected);
    if (selected) return palette.selectedForeground;

    final sidebarSurface = Theme.of(context).colorScheme.surface;
    return sidebarSurface.computeLuminance() > 0.65 ? palette.icon : Colors.white;
  }

  List<String> _subMenuChoicesFor(String label) {
    switch (label) {
      case 'Parties':
        return ['Add Buyers', 'Add Suppliers', 'Party Group'];
      case 'Items & Services':
        return ['Add Items', 'Add Services', 'Add Raw Materials'];
      case 'Sale':
        return [
          'Sale Invoices',
          'Estimate / Quotation',
          'Proforma Invoice',
          'Sale Order',
          'Sale Return',
          'Credit Note',
          'Payment In',
          'Sale Fixed Assets',
        ];
      case 'Purchase':
        return [
          'Purchase Invoice',
          'Purchase Order',
          'Purchase Return',
          'Debit Note',
          'Payment Out',
          'Purchase Fixed Assets',
        ];
      default:
        return const [];
    }
  }

  void _showSubMenu(BuildContext buttonContext, LayerLink link, List<String> options) {
    final overlay = Overlay.of(buttonContext);
    late OverlayEntry entry;
    entry = OverlayEntry(
      builder: (context) => Positioned.fill(
        child: Stack(children: [
          GestureDetector(onTap: entry.remove, behavior: HitTestBehavior.translucent),
          CompositedTransformFollower(
            link: link,
            showWhenUnlinked: false,
            offset: const Offset(0, 44),
            child: Material(
              elevation: 12,
              borderRadius: BorderRadius.circular(14),
              color: Theme.of(buttonContext).colorScheme.surface,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 300, minWidth: 260),
                child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  shrinkWrap: true,
                  itemCount: options.length,
                  itemBuilder: (context, index) => ListTile(
                    dense: true,
                    title: Text(options[index]),
                    onTap: () => entry.remove(),
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
    overlay.insert(entry);
  }

  Widget _sideItem(String label) {
    final comingSoon = label == 'Multi Device Sync';
    final selected = label == 'Home';
    final themeLink = LayerLink();
    final item = Builder(builder: (rowContext) {
      final palette = SaarthoThemes.paletteFor(widget.themeController.selected);
      final textColor = _menuTextColor(rowContext, selected: selected);
      final iconColor = _menuIconColor(rowContext, selected: selected);
      final subMenuOptions = _subMenuChoicesFor(label);
      return ListTile(
        dense: true,
        selected: selected,
        selectedTileColor: palette.selectedBackground,
        selectedColor: palette.selectedForeground,
        textColor: textColor,
        iconColor: iconColor,
        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        leading: Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              selected ? palette.secondary : palette.elevated,
              palette.background,
            ]),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [BoxShadow(color: palette.primary.withValues(alpha: .20), blurRadius: 5, offset: const Offset(0, 2))],
          ),
          child: Icon(_iconFor(label), size: 19, color: iconColor),
        ),
        title: Text(
          label,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: textColor,
            fontWeight: selected ? FontWeight.w800 : FontWeight.w700,
            fontSize: 14,
          ),
        ),
        trailing: comingSoon ? Text('Soon', style: TextStyle(fontSize: 10, color: palette.mutedText)) : null,
        onTap: label == 'Change UI Theme Colour'
            ? () => _themeMenu(rowContext, themeLink)
            : label == 'Plan & Pricing'
                ? () => Navigator.of(rowContext).push(MaterialPageRoute<void>(builder: (_) => const PlanPricingScreen()))
                : label == 'Expense'
                    ? () => Navigator.of(rowContext).push(MaterialPageRoute<void>(builder: (_) => ExpenseManagementScreen(themeController: widget.themeController)))
                    : subMenuOptions.isNotEmpty
                        ? () => _showSubMenu(rowContext, themeLink, subMenuOptions)
                        : null,
        subtitle: label == 'Plan Status'
            ? Text(
                '${SaarthoPlan.name}\n${_plan.expiryLabel}',
                style: TextStyle(
                  fontSize: 10,
                  color: selected ? palette.selectedForeground.withValues(alpha: 0.9) : palette.mutedText,
                ),
              )
            : null,
      );
    });
      return label == 'Change UI Theme Colour'
        ? CompositedTransformTarget(link: themeLink, child: item)
        : label == 'Parties' || label == 'Items & Services' || label == 'Sale' || label == 'Purchase'
            ? CompositedTransformTarget(link: themeLink, child: item)
            : item;
  }

  IconData _iconFor(String label) => const {
        'Home': Icons.home_outlined, 'Parties': Icons.people_outline, 'Items & Services': Icons.inventory_2_outlined,
        'Sale': Icons.point_of_sale, 'Purchase': Icons.shopping_cart_outlined, 'Expense': Icons.receipt_long_outlined,
        'Cash and Bank': Icons.account_balance_outlined, 'Reports': Icons.bar_chart, 'Additional Options': Icons.more_horiz,
        'Settings': Icons.settings_outlined, 'Backup & Restore': Icons.backup_outlined, 'Change UI Theme Colour': Icons.palette_outlined,
        'Multi Device Sync': Icons.sync, 'Plan & Pricing': Icons.card_membership_outlined, 'Plan Status': Icons.verified_outlined,
        'Give Feedback': Icons.feedback_outlined,
      }[label] ?? Icons.circle_outlined;

  void _themeMenu(BuildContext buttonContext, LayerLink link) {
    final palette = SaarthoThemes.paletteFor(widget.themeController.selected);
    final overlay = Overlay.of(buttonContext);
    late OverlayEntry entry;
    entry = OverlayEntry(
      builder: (context) => Positioned.fill(
        child: Stack(children: [
          GestureDetector(onTap: entry.remove, behavior: HitTestBehavior.translucent),
          CompositedTransformFollower(
            link: link,
            showWhenUnlinked: false,
            offset: const Offset(0, 48),
            child: Material(
              elevation: 14,
              borderRadius: BorderRadius.circular(14),
              color: palette.surface,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 300, maxHeight: 500),
                child: ListView(padding: const EdgeInsets.all(10), shrinkWrap: true, children: [
                  Padding(padding: const EdgeInsets.all(8), child: Text('Choose UI theme', style: TextStyle(color: palette.text, fontWeight: FontWeight.bold))),
                  for (final theme in SaarthoThemes.names)
                    ListTile(
                      dense: true,
                      selected: theme == widget.themeController.selected,
                      leading: Row(mainAxisSize: MainAxisSize.min, children: [
                        Container(
                          width: 44,
                          height: 26,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [SaarthoThemes.paletteFor(theme).primary, SaarthoThemes.paletteFor(theme).secondary]),
                            borderRadius: BorderRadius.circular(7),
                            border: Border.all(color: SaarthoThemes.paletteFor(theme).border),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(theme == widget.themeController.selected ? Icons.radio_button_checked : Icons.radio_button_unchecked, color: SaarthoThemes.paletteFor(theme).icon, size: 18),
                      ]),
                      title: Text(theme, style: TextStyle(fontSize: 12, color: palette.text)),
                      onTap: () {
                        entry.remove();
                        _confirmTheme(theme);
                      },
                    ),
                ]),
              ),
            ),
          ),
        ]),
      ),
    );
    overlay.insert(entry);
  }

  void _confirmTheme(String theme) => showDialog<void>(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Apply UI Theme'),
          content: Text('Apply "$theme" throughout Saartho?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                widget.themeController.apply(theme);
                Navigator.pop(context);
              },
              child: const Text('Apply Changes'),
            ),
          ],
        ),
      );

  Widget _content() => SingleChildScrollView(padding: const EdgeInsets.all(22), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _greetingCard(), const SizedBox(height: 18), _universalDateFilter(),
        Wrap(spacing: 12, runSpacing: 8, children: [
          SegmentedButton<bool>(segments: const [ButtonSegment(value: false, label: Text('Standard View')), ButtonSegment(value: true, label: Text('Advanced View'))], selected: {_advanced}, onSelectionChanged: (value) => setState(() => _advanced = value.first)),
          FilterChip(label: const Text('Privacy Mode'), selected: _privacy, onSelected: (value) => setState(() => _privacy = value)),
        ]), const SizedBox(height: 20), _advanced ? _advancedView() : _standardView(),
      ]));

  Widget _greetingCard() => Container(width: double.infinity, padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface, borderRadius: BorderRadius.circular(10), border: Border.all(color: Theme.of(context).colorScheme.outlineVariant)), child: Row(children: [
        Icon(_greetingIcon, color: Theme.of(context).colorScheme.secondary, size: 34), const SizedBox(width: 14),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(_greeting, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary)), if (widget.userName.isNotEmpty) Text(widget.userName, style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant))])),
      ]));

  Widget _standardView() => Column(children: [
        _sectionTitle('Business Overview'),
        Wrap(spacing: 14, runSpacing: 14, children: [_metricCard('Sale Information'), _metricCard('Purchase Information'), _metricCard('Expense Information'), _metricCard('Receivable Balance'), _metricCard('Payable Balance')]),
        const SizedBox(height: 22), _quickLinks(),
      ]);

  Widget _advancedView() => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _sectionTitle('Advanced Overview'),
        Wrap(spacing: 14, runSpacing: 14, children: [_metricCard('Sale Information'), _metricCard('Purchase Information'), _metricCard('Expense Information'), _metricCard('Receivable Balance'), _metricCard('Payable Balance')]),
        const SizedBox(height: 18), Wrap(spacing: 14, runSpacing: 14, children: [_chartCard(), _insightCard('Top Selling Products'), _insightCard('Top Customers'), _insightCard('Expiry Item List'), _insightCard('Low Selling Items')]),
        const SizedBox(height: 18), _quickLinks(),
      ]);

  Widget _universalDateFilter() => Align(
        alignment: Alignment.centerRight,
        child: DropdownButton<String>(
          value: _dateFilter,
          hint: const Text('Dashboard date range'),
          items: _dateOptions
              .map((filter) => DropdownMenuItem(value: filter, child: Text(filter)))
              .toList(),
          onChanged: (value) {
            if (value == null) return;
            if (value == 'Custom Date Range') {
              _pickCustomRange();
            } else {
              setState(() => _dateFilter = value);
            }
          },
        ),
      );

  String _sectionDateLabel(String sectionKey) {
    final active = _sectionDateFilters[sectionKey] ?? 'Today';
    final range = _sectionCustomRanges[sectionKey];
    if (active == 'Custom Date Range' && range != null) {
      final start = range.start;
      final end = range.end;
      return '${start.day.toString().padLeft(2, '0')}/${start.month.toString().padLeft(2, '0')}/${start.year} - ${end.day.toString().padLeft(2, '0')}/${end.month.toString().padLeft(2, '0')}/${end.year}';
    }
    return active;
  }

  Future<void> _pickCustomRange() async {
    final range = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      initialDateRange: _customStart != null && _customEnd != null ? DateTimeRange(start: _customStart!, end: _customEnd!) : null,
    );
    if (range != null) {
      setState(() {
        _customStart = range.start;
        _customEnd = range.end;
        _dateFilter = 'Custom Date Range';
      });
    }
  }

  Future<void> _pickSectionCustomRange(String sectionKey) async {
    final existing = _sectionCustomRanges[sectionKey];
    final range = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      initialDateRange: existing != null ? DateTimeRange(start: existing.start, end: existing.end) : null,
    );
    if (range == null) return;
    setState(() {
      _sectionCustomRanges[sectionKey] = range;
      _sectionDateFilters[sectionKey] = 'Custom Date Range';
    });
  }

  void _handleSectionDateChoice(String sectionKey, String value) {
    if (value == 'Custom Date Range') {
      _pickSectionCustomRange(sectionKey);
      return;
    }

    setState(() {
      _sectionDateFilters[sectionKey] = value;
      _sectionCustomRanges[sectionKey] = null;
    });
  }

  Widget _sectionTitle(String title) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Row(children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: _isRoyalBlueWhiteTheme() ? Colors.white : Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          Text(
            _dateFilter,
            style: TextStyle(
              fontSize: 12,
              color: _isRoyalBlueWhiteTheme() ? Colors.white70 : Colors.blueGrey,
            ),
          )
        ]),
      );

  Widget _metricCard(String title) {
    final sectionKey = title;
    final royal = _isRoyalBlueWhiteTheme();
    return SizedBox(
      width: 210,
      child: _panel(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(_iconFor(title), color: royal ? Colors.white70 : Theme.of(context).colorScheme.secondary, size: 22),
                const Spacer(),
                PopupMenuButton<String>(
                  tooltip: 'Select date range',
                  icon: Icon(Icons.calendar_today_outlined, size: 16, color: royal ? Colors.white70 : Theme.of(context).colorScheme.secondary),
                  onSelected: (value) => _handleSectionDateChoice(sectionKey, value),
                  itemBuilder: (context) => _dateOptions
                      .map((option) => PopupMenuItem<String>(value: option, child: Text(option)))
                      .toList(),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: royal ? Colors.white : null)),
            const SizedBox(height: 12),
            _privateText('No data available'),
            const SizedBox(height: 10),
            Text(_sectionDateLabel(sectionKey), style: TextStyle(fontSize: 11, color: royal ? Colors.white70 : Theme.of(context).colorScheme.onSurfaceVariant)),
          ],
        ),
      ),
    );
  }

  Widget _chartCard() => SizedBox(width: 430, height: 180, child: _panel(Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('Financial comparison', style: TextStyle(fontWeight: FontWeight.bold)), Text('Current month vs previous month', style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurfaceVariant)), const Spacer(), Icon(Icons.show_chart, size: 56, color: Theme.of(context).colorScheme.secondary), const Spacer(), DropdownButton<String>(value: 'Current Financial Year', items: const [DropdownMenuItem(value: 'Current Financial Year', child: Text('Current Financial Year')), DropdownMenuItem(value: 'Previous Financial Year', child: Text('Previous Financial Year'))], onChanged: (_) {})])));

  Widget _insightCard(String title) => SizedBox(width: 210, height: 180, child: _panel(Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontWeight: FontWeight.bold)), const Spacer(), if (title == 'Expiry Item List') DropdownButton<int>(value: _expiryDays, items: [7, 15, 30, 45, 60, 90].map((days) => DropdownMenuItem(value: days, child: Text('$days days'))).toList(), onChanged: (value) { if (value != null) setState(() => _expiryDays = value); }), const Text('No data available', style: TextStyle(color: Colors.blueGrey, fontSize: 12)), const Spacer()])));

  Widget _quickLinks() => _panel(Wrap(spacing: 10, runSpacing: 10, children: [const Text('Quick Links', style: TextStyle(fontWeight: FontWeight.bold)), for (final link in ['Sale', 'Purchase', 'Expense', 'Add Party', 'Add Item']) OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.arrow_forward, size: 16), label: Text(link))]));

  Widget _panel(Widget child) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: _isRoyalBlueWhiteTheme()
              ? const LinearGradient(
                  colors: [Color(0xFF0F3D9E), Color(0xFF143E96)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : LinearGradient(
                  colors: [Theme.of(context).colorScheme.surfaceContainer, Theme.of(context).colorScheme.surface],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _isRoyalBlueWhiteTheme() ? const Color(0xFF2E6AE6) : Theme.of(context).colorScheme.secondary.withValues(alpha: .34)),
          boxShadow: [
            BoxShadow(
              color: _isRoyalBlueWhiteTheme() ? const Color(0x330D2D6E) : Theme.of(context).colorScheme.primary.withValues(alpha: .24),
              blurRadius: 14,
              offset: const Offset(0, 5),
            ),
            BoxShadow(color: Colors.black.withValues(alpha: .12), blurRadius: 2, offset: const Offset(0, -1)),
          ],
        ),
        child: child,
      );

  Widget _privateText(String text) => _privacy
      ? ImageFiltered(
          imageFilter: ui.ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: _isRoyalBlueWhiteTheme() ? Colors.white : null,
            ),
          ),
        )
      : Text(
          text,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: _isRoyalBlueWhiteTheme() ? Colors.white : null,
          ),
        );
}

class ExpenseEntry {
  ExpenseEntry(this.id, this.name, this.category, this.party, this.amount, this.date);

  final String id;
  final String name;
  final String category;
  final String party;
  final double amount;
  final DateTime date;
}

class ExpenseManagementScreen extends StatefulWidget {
  const ExpenseManagementScreen({super.key, required this.themeController});

  final SaarthoThemeController themeController;

  @override
  State<ExpenseManagementScreen> createState() => _ExpenseManagementScreenState();
}

class _ExpenseManagementScreenState extends State<ExpenseManagementScreen> {
  final List<ExpenseEntry> _entries = [
    ExpenseEntry('EXP-1001', 'Office Rent', 'Rent', 'Landlord', 18000, DateTime.now()),
    ExpenseEntry('EXP-1002', 'Electricity Bill', 'Utilities', 'Power Grid', 4250, DateTime.now().subtract(const Duration(days: 1))),
    ExpenseEntry('EXP-1003', 'Courier Charges', 'Logistics', 'Swift Couriers', 2000, DateTime.now().subtract(const Duration(days: 2))),
    ExpenseEntry('EXP-1004', 'Marketing Ad Spend', 'Marketing', 'BrandBoost', 9500, DateTime.now()),
    ExpenseEntry('EXP-1005', 'Staff Lunch', 'Meals', 'Cafeteria', 1600, DateTime.now().subtract(const Duration(days: 3))),
  ];
  String _dateFilter = 'Today';
  DateTime? _start;
  DateTime? _end;
  int _selectedIndex = -1;

  List<ExpenseEntry> get _filteredEntries {
    final now = DateTime.now();
    DateTime start;
    DateTime end;

    switch (_dateFilter) {
      case 'Today':
        start = DateTime(now.year, now.month, now.day);
        end = DateTime(now.year, now.month, now.day, 23, 59, 59, 999);
        break;
      case 'Yesterday':
        final yesterday = now.subtract(const Duration(days: 1));
        start = DateTime(yesterday.year, yesterday.month, yesterday.day);
        end = DateTime(yesterday.year, yesterday.month, yesterday.day, 23, 59, 59, 999);
        break;
      case 'Custom Range':
        start = _start ?? DateTime(now.year, now.month, now.day);
        end = _end ?? DateTime(now.year, now.month, now.day, 23, 59, 59, 999);
        break;
      default:
        start = DateTime(now.year, now.month, now.day);
        end = DateTime(now.year, now.month, now.day, 23, 59, 59, 999);
    }

    return _entries.where((entry) => !entry.date.isBefore(start) && !entry.date.isAfter(end)).toList();
  }

  Future<void> _pickCustomRange() async {
    final range = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      initialDateRange: _start != null && _end != null ? DateTimeRange(start: _start!, end: _end!) : null,
    );
    if (range != null) {
      setState(() {
        _start = range.start;
        _end = range.end;
        _dateFilter = 'Custom Range';
      });
    }
  }

  void _addExpense() {
    final now = DateTime.now();
    final newEntry = ExpenseEntry(
      'EXP-${(_entries.length + 1).toString().padLeft(4, '0')}',
      'New Expense',
      'General',
      'Vendor',
      2500,
      now,
    );
    setState(() {
      _entries.insert(0, newEntry);
      _selectedIndex = 0;
    });
  }

  void _deleteExpense(int index) {
    final target = _filteredEntries[index];
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete Expense'),
        content: Text('Delete ${target.name}?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogContext), child: const Text('Cancel')),
          FilledButton(
            onPressed: () {
              setState(() {
                _entries.remove(target);
                _selectedIndex = -1;
              });
              Navigator.pop(dialogContext);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _editExpense(int index) {
    final item = _filteredEntries[index];
    final nameController = TextEditingController(text: item.name);
    final partyController = TextEditingController(text: item.party);
    final categoryController = TextEditingController(text: item.category);
    final amountController = TextEditingController(text: item.amount.toStringAsFixed(0));

    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Edit Expense'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Expense name')),
              const SizedBox(height: 8),
              TextField(controller: categoryController, decoration: const InputDecoration(labelText: 'Category')),
              const SizedBox(height: 8),
              TextField(controller: partyController, decoration: const InputDecoration(labelText: 'Party')),
              const SizedBox(height: 8),
              TextField(controller: amountController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Amount')),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogContext), child: const Text('Cancel')),
          FilledButton(
            onPressed: () {
              final updated = ExpenseEntry(
                item.id,
                nameController.text.trim().isEmpty ? item.name : nameController.text.trim(),
                categoryController.text.trim().isEmpty ? item.category : categoryController.text.trim(),
                partyController.text.trim().isEmpty ? item.party : partyController.text.trim(),
                double.tryParse(amountController.text) ?? item.amount,
                item.date,
              );
              setState(() {
                final indexInAll = _entries.indexOf(item);
                if (indexInAll >= 0) _entries[indexInAll] = updated;
              });
              Navigator.pop(dialogContext);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredEntries;
    final total = filtered.fold<double>(0, (sum, item) => sum + item.amount);
    final palette = SaarthoThemes.paletteFor(widget.themeController.selected);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Management'),
        actions: [
          IconButton(
            onPressed: _addExpense,
            icon: const Icon(Icons.add),
            tooltip: 'Add Expense',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text('Expense Dashboard', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                const Spacer(),
                DropdownButton<String>(
                  value: _dateFilter,
                  items: const [
                    DropdownMenuItem(value: 'Today', child: Text('Today')),
                    DropdownMenuItem(value: 'Yesterday', child: Text('Yesterday')),
                    DropdownMenuItem(value: 'Custom Range', child: Text('Custom Date Range')),
                  ],
                  onChanged: (value) {
                    if (value == null) return;
                    if (value == 'Custom Range') {
                      _pickCustomRange();
                    } else {
                      setState(() => _dateFilter = value);
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Total expense amount', style: TextStyle(fontWeight: FontWeight.w600)),
                          const SizedBox(height: 8),
                          Text('₹${total.toStringAsFixed(2)}', style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Transactions', style: TextStyle(fontWeight: FontWeight.w600)),
                          const SizedBox(height: 8),
                          Text('${filtered.length}', style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Expanded(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: filtered.isEmpty
                      ? const Center(child: Text('No expense data found for this range.'))
                      : ListView.separated(
                          itemCount: filtered.length,
                          separatorBuilder: (context, index) => const Divider(),
                          itemBuilder: (context, index) {
                            final item = filtered[index];
                            final selected = _selectedIndex == index;
                            return ListTile(
                              selected: selected,
                              leading: CircleAvatar(
                                backgroundColor: palette.secondary.withValues(alpha: .18),
                                child: Icon(Icons.receipt_long_outlined, color: palette.primary),
                              ),
                              title: Text(item.name),
                              subtitle: Text('${item.category} • ${item.party}'),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('₹${item.amount.toStringAsFixed(2)}'),
                                  const SizedBox(width: 8),
                                  PopupMenuButton<String>(
                                    onSelected: (value) {
                                      if (value == 'Edit') {
                                        _editExpense(index);
                                      } else if (value == 'Delete') {
                                        _deleteExpense(index);
                                      }
                                    },
                                    itemBuilder: (context) => const [
                                      PopupMenuItem(value: 'Edit', child: Text('Edit')),
                                      PopupMenuItem(value: 'Delete', child: Text('Delete')),
                                    ],
                                  ),
                                ],
                              ),
                              onTap: () => setState(() => _selectedIndex = index),
                            );
                          },
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SaarthoPricingPlan {
  const SaarthoPricingPlan(this.name, this.prices, this.features);
  final String name;
  final Map<String, String> prices;
  final List<String> features;
}

const _pricingPlans = [
  SaarthoPricingPlan('SAARTHO CORE', {'6 Months': '₹1,499', '1 Year': '₹2,499', '3 Years': '₹5,999'}, [
    'Businesses supported', 'Users/devices', 'Offline operation', 'Billing & invoicing', 'Sales & purchase management',
    'Customers & suppliers ledger', 'Expense management', 'Receivables & payables', 'Payment In / Payment Out',
    'GST features & compliance', 'Inventory management', 'Low-stock alerts & expiry tracking', 'Stock valuation',
    'Standard Dashboard', 'Standard Reports', 'Business Quick Links', 'Invoice Customisation', 'Data Export', 'Backup & Restore', 'Support Level',
  ]),
  SaarthoPricingPlan('SAARTHO PRIME', {'6 Months': '₹2,499', '1 Year': '₹4,299', '3 Years': '₹9,999'}, [
    'Businesses supported', 'Users/devices', 'Offline operation', 'Billing & invoicing', 'Sales & purchase management',
    'Customers & suppliers ledger', 'Expense management', 'Receivables & payables', 'Payment In / Payment Out',
    'GST features & compliance', 'Inventory management', 'Low-stock alerts & expiry tracking', 'Stock valuation',
    'Standard Dashboard', 'Advanced Dashboard', 'Standard Reports', 'Advanced Reports & Analytics', 'Sales & Purchase Analysis',
    'Profit & Margin Analysis', 'Cash-flow Analysis', 'Customer & Item Performance Analysis', 'Outstanding Ageing',
    'Business Quick Links', 'Invoice Customisation', 'Data Export', 'Backup & Restore', 'Support Level',
  ]),
  SaarthoPricingPlan('SAARTHO MAX', {'6 Months': '₹3,499', '1 Year': '₹5,999', '3 Years': '₹13,999'}, [
    'Businesses supported', 'Users/devices', 'Offline operation', 'Billing & invoicing', 'Sales & purchase management',
    'Customers & suppliers ledger', 'Expense management', 'Receivables & payables', 'Payment In / Payment Out',
    'GST features & compliance', 'Inventory management', 'Low-stock alerts & expiry tracking', 'Stock valuation',
    'Standard Dashboard', 'Advanced Dashboard', 'Standard Reports', 'Advanced Reports & Analytics', 'Sales & Purchase Analysis',
    'Profit & Margin Analysis', 'Cash-flow Analysis', 'Customer & Item Performance Analysis', 'Outstanding Ageing',
    'Business Quick Links', 'Invoice Customisation', 'Data Export', 'Backup & Restore', 'Support Level',
  ]),
];

class PlanPricingScreen extends StatelessWidget {
  const PlanPricingScreen({super.key});

  final _periods = const ['6 Months', '1 Year', '3 Years'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Plan & Pricing')),
      body: LayoutBuilder(builder: (context, constraints) => SingleChildScrollView(
            padding: const EdgeInsets.all(22),
            child: Wrap(
              spacing: 18,
              runSpacing: 18,
              children: _pricingPlans.map((plan) => SizedBox(
                    width: constraints.maxWidth >= 1000 ? (constraints.maxWidth - 80) / 3 : 340,
                    child: _PlanCard(plan: plan, periods: _periods, popular: plan.name == 'SAARTHO PRIME'),
                  )).toList(),
            ),
          )),
    );
  }
}

class _PlanCard extends StatelessWidget {
  const _PlanCard({required this.plan, required this.periods, required this.popular});
  final SaarthoPricingPlan plan;
  final List<String> periods;
  final bool popular;

  @override
  Widget build(BuildContext context) => Card(
        elevation: popular ? 5 : 1,
        child: Padding(padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          if (popular) const Chip(label: Text('POPULAR')),
          Text(plan.name, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          for (final period in periods) Padding(padding: const EdgeInsets.only(bottom: 10), child: Row(children: [Expanded(child: Text(period)), Text('${plan.prices[period]} + 18% GST', style: const TextStyle(fontWeight: FontWeight.bold))])),
          const SizedBox(height: 8),
          FilledButton.tonalIcon(onPressed: () => _showDetails(context), icon: const Icon(Icons.visibility_outlined), label: const Text('View Details')),
        ])),
      );

  void _showDetails(BuildContext context) => showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        builder: (_) => DraggableScrollableSheet(
          expand: false,
          builder: (context, scrollController) => SafeArea(child: Padding(padding: const EdgeInsets.all(22), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('${plan.name} details', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 14),
            Expanded(child: ListView.builder(controller: scrollController, itemCount: plan.features.length, itemBuilder: (_, index) => ListTile(leading: const Icon(Icons.check_circle_outline), title: Text(plan.features[index])))),
          ]))),
        ),
      );
}
