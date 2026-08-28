import 'dart:ui' as ui;

import 'package:flutter/material.dart';

void main() {
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

class SetupAccountScreen extends StatefulWidget {
  const SetupAccountScreen({super.key, required this.themeController});

  final SaarthoThemeController themeController;

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
          fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
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
              color: Colors.white.withValues(alpha: 0.92),
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
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.secondary,
              Theme.of(context).colorScheme.primaryContainer,
            ],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: 12,
                right: 20,
                child: ElevatedButton(
                  onPressed: () => _openDashboard(),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      foregroundColor: Theme.of(context).colorScheme.onSecondary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Skip Login',
                    style: TextStyle(fontWeight: FontWeight.bold),
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
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final isNarrow = constraints.maxWidth < 800;
                        final leftPanel = Padding(
                          padding: EdgeInsets.only(
                            right: isNarrow ? 0 : 55,
                            top: 15,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                'assets/saartho_logo.png',
                                width: 280,
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
                              color: Theme.of(context).colorScheme.surface,
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
                                    onPressed: () => _openDashboard(),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Theme.of(context).colorScheme.primary,
                                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
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
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    SizedBox(
                                      width: double.infinity,
                                      child: TextButton(
                                        onPressed: () => _openDashboard(),
                                        child: const Text(
                                          'Already have an account? Login',
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      child: TextButton(
                                        onPressed: () {},
                                        child: const Text(
                                          'Restore Saartho Backup',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );

                        if (isNarrow) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              leftPanel,
                              const SizedBox(height: 28),
                              accountCard,
                            ],
                          );
                        }

                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(flex: 5, child: leftPanel),
                            Expanded(flex: 5, child: accountCard),
                          ],
                        );
                      },
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

  void _openDashboard() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => DashboardScreen(
          userName: _nameController.text.trim(),
          businessName: _businessController.text.trim(),
          themeController: widget.themeController,
        ),
      ),
    );
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
    'Dark Royal Blue & White': SaarthoPalette(Color(0xFF0B3D91), Color(0xFF00B8D4), Color(0xFFDDEBFA), Color(0xFFC7DDF2), Color(0xFFEAF4FF)),
    'Dark Teal and Gray': SaarthoPalette(Color(0xFF0F5C5E), Color(0xFFB8D8D8), Color(0xFFDCEBE9), Color(0xFFC3DAD8), Color(0xFFEAF5F3)),
    'Dark Purple and Lavender': SaarthoPalette(Color(0xFF542C82), Color(0xFFD4B9FF), Color(0xFFE9DDF8), Color(0xFFD9C7EC), Color(0xFFF4ECFF)),
    'Dark Emerald and Mint': SaarthoPalette(Color(0xFF086B50), Color(0xFF9BE7C4), Color(0xFFD8EEE3), Color(0xFFBEDDCE), Color(0xFFE7F7EE)),
    'Amber and Orange': SaarthoPalette(Color(0xFF9A5B00), Color(0xFFFFB300), Color(0xFFFFE7B0), Color(0xFFFFD98A), Color(0xFFFFF1D1)),
    'Dark Mode': SaarthoPalette(Color(0xFF263238), Color(0xFF80CBC4), Color(0xFF26353B), Color(0xFF172126), Color(0xFF30434A)),
    'Emerald Green and Mint': SaarthoPalette(Color(0xFF18794E), Color(0xFF8CE0B5), Color(0xFFD8EEDC), Color(0xFFC1DFC8), Color(0xFFE9F7EC)),
    'Coral and Peach': SaarthoPalette(Color(0xFFB84A3A), Color(0xFFFFB39C), Color(0xFFFFE0D6), Color(0xFFFFCEC0), Color(0xFFFFEEE8)),
    'Slate Blue and Gray': SaarthoPalette(Color(0xFF40566F), Color(0xFFAFC1D4), Color(0xFFDCE5EC), Color(0xFFC6D3DF), Color(0xFFEDF3F7)),
    'Indigo and Sky Blue': SaarthoPalette(Color(0xFF3949AB), Color(0xFF81D4FA), Color(0xFFDCE5FA), Color(0xFFC7D6F2), Color(0xFFEDF3FF)),
  };

  static ThemeData themeFor(String name) {
    final palette = paletteFor(name);
    final dark = name == 'Dark Mode';
    final background = dark ? palette.background : Color.alphaBlend(palette.primary.withValues(alpha: .14), palette.background);
    final surface = dark ? palette.surface : Color.alphaBlend(palette.secondary.withValues(alpha: .10), palette.surface);
    final elevated = dark ? palette.elevated : Color.alphaBlend(palette.secondary.withValues(alpha: .10), palette.elevated);
    final scheme = ColorScheme.fromSeed(seedColor: palette.primary, brightness: dark ? Brightness.dark : Brightness.light).copyWith(
      primary: palette.primary, secondary: palette.secondary, surface: surface,
      surfaceContainer: elevated, surfaceContainerHighest: background,
      onSurface: dark ? Colors.white : const Color(0xFF17212B),
      onSurfaceVariant: dark ? palette.secondary : Color.alphaBlend(palette.primary.withValues(alpha: .45), Colors.black),
      onPrimary: Colors.white,
    );
    return ThemeData(
      fontFamily: 'Arial',
      useMaterial3: true,
      colorScheme: scheme.copyWith(surface: palette.surface, surfaceContainer: palette.elevated, surfaceContainerHighest: palette.background),
      scaffoldBackgroundColor: background,
      cardTheme: CardThemeData(color: elevated, surfaceTintColor: palette.secondary.withValues(alpha: .18), elevation: 5),
      dividerTheme: DividerThemeData(color: palette.secondary.withValues(alpha: .35)),
      inputDecorationTheme: InputDecorationTheme(filled: true, fillColor: palette.surface, focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: palette.secondary, width: 2))),
      dialogTheme: DialogThemeData(backgroundColor: palette.surface),
      popupMenuTheme: PopupMenuThemeData(color: palette.surface, surfaceTintColor: palette.secondary.withValues(alpha: .12)),
    );
  }

  static SaarthoPalette paletteFor(String name) => _palettes[name] ?? _palettes[names.first]!;
}

class SaarthoPalette {
  const SaarthoPalette(this.primary, this.secondary, this.surface, this.background, this.elevated);
  final Color primary;
  final Color secondary;
  final Color surface;
  final Color background;
  final Color elevated;
}

class SaarthoThemeController extends ChangeNotifier {
  String selected = SaarthoThemes.names.first;

  ThemeData get theme => SaarthoThemes.themeFor(selected);

  void apply(String themeName) {
    selected = themeName;
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
  String _pendingTheme = SaarthoThemes.names.first;
  String _dateFilter = 'Today';
  DateTime? _customStart;
  DateTime? _customEnd;
  int _expiryDays = 30;
  final _plan = const SaarthoPlan();

  @override
  void initState() {
    super.initState();
    _pendingTheme = widget.themeController.selected;
  }

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

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
        drawer: _sideMenu(),
        body: SafeArea(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [colors.surfaceContainerHighest, colors.surface, colors.surfaceContainerHighest],
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
    return Container(width: 260, decoration: BoxDecoration(
      gradient: LinearGradient(colors: [colors.surfaceContainerHighest, colors.surface], begin: Alignment.topCenter, end: Alignment.bottomCenter),
      boxShadow: [BoxShadow(color: colors.primary.withValues(alpha: .22), blurRadius: 16, offset: const Offset(3, 0))],
    ), child: ListView(padding: const EdgeInsets.fromLTRB(14, 14, 14, 24), children: [
      Container(padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: colors.primaryContainer, borderRadius: BorderRadius.circular(8)), child: Row(children: [
        Expanded(child: Text(widget.businessName.isEmpty ? 'Add Company Name' : widget.businessName, style: const TextStyle(fontWeight: FontWeight.bold))),
        const Icon(Icons.edit_outlined, size: 18),
      ])),
      const SizedBox(height: 14), for (final item in items) _sideItem(item),
    ]));
  }

  Widget _sideItem(String label) {
    final comingSoon = label == 'Multi Device Sync';
    final themeLink = LayerLink();
    final item = Builder(builder: (rowContext) => ListTile(
          dense: true, selected: label == 'Home', selectedTileColor: Theme.of(rowContext).colorScheme.secondaryContainer,
          leading: Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                label == 'Home' ? Theme.of(rowContext).colorScheme.secondary : Theme.of(rowContext).colorScheme.surfaceContainer,
                Theme.of(rowContext).colorScheme.primary.withValues(alpha: .32),
              ]),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [BoxShadow(color: Theme.of(rowContext).colorScheme.primary.withValues(alpha: .20), blurRadius: 5, offset: const Offset(0, 2))],
            ),
            child: Icon(_iconFor(label), size: 19, color: label == 'Home' ? Theme.of(rowContext).colorScheme.onSecondary : Theme.of(rowContext).colorScheme.secondary),
          ),
          title: Text(label, overflow: TextOverflow.ellipsis),
          trailing: comingSoon ? Text('Soon', style: TextStyle(fontSize: 10, color: Theme.of(rowContext).colorScheme.onSurfaceVariant)) : null,
          onTap: label == 'Change UI Theme Colour'
              ? () => _themeMenu(rowContext, themeLink)
              : label == 'Plan & Pricing'
                  ? () => Navigator.of(rowContext).push(MaterialPageRoute<void>(builder: (_) => const PlanPricingScreen()))
                  : null,
          subtitle: label == 'Plan Status' ? Text('${SaarthoPlan.name}\n${_plan.expiryLabel}', style: const TextStyle(fontSize: 10)) : null,
        ));
      return label == 'Change UI Theme Colour'
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
              color: Theme.of(buttonContext).colorScheme.surface,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 300, maxHeight: 500),
                child: ListView(padding: const EdgeInsets.all(10), shrinkWrap: true, children: [
                  Padding(padding: const EdgeInsets.all(8), child: Text('Choose UI theme', style: Theme.of(buttonContext).textTheme.titleMedium)),
                  for (final theme in SaarthoThemes.names)
                    ListTile(
                      dense: true,
                      leading: Row(mainAxisSize: MainAxisSize.min, children: [
                        Container(
                          width: 44,
                          height: 26,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [SaarthoThemes.paletteFor(theme).primary, SaarthoThemes.paletteFor(theme).secondary]),
                            borderRadius: BorderRadius.circular(7),
                            border: Border.all(color: Theme.of(buttonContext).colorScheme.outlineVariant),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(theme == _pendingTheme ? Icons.radio_button_checked : Icons.radio_button_unchecked, color: Theme.of(buttonContext).colorScheme.secondary, size: 18),
                      ]),
                      title: Text(theme, style: const TextStyle(fontSize: 12)),
                      onTap: () {
                        setState(() => _pendingTheme = theme);
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
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
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
          items: const ['Today', 'Yesterday', 'Last Month', 'Last 3 Months', 'Last 6 Months', 'Custom Date Range']
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

  Widget _sectionTitle(String title) => Padding(padding: const EdgeInsets.only(bottom: 12), child: Row(children: [Expanded(child: Text(title, style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary))), Text(_dateFilter, style: const TextStyle(fontSize: 12, color: Colors.blueGrey))]));

  Widget _metricCard(String title) => SizedBox(width: 210, child: _panel(Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Icon(_iconFor(title), color: Theme.of(context).colorScheme.secondary, size: 22), const SizedBox(height: 8), Text(title, style: const TextStyle(fontWeight: FontWeight.bold)), const SizedBox(height: 12), _privateText('No data available'), const SizedBox(height: 10), Text(_dateFilter, style: TextStyle(fontSize: 11, color: Theme.of(context).colorScheme.onSurfaceVariant)), Icon(Icons.calendar_today_outlined, size: 16, color: Theme.of(context).colorScheme.secondary)])));

  Widget _chartCard() => SizedBox(width: 430, height: 180, child: _panel(Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('Financial comparison', style: TextStyle(fontWeight: FontWeight.bold)), Text('Current month vs previous month', style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurfaceVariant)), const Spacer(), Icon(Icons.show_chart, size: 56, color: Theme.of(context).colorScheme.secondary), const Spacer(), DropdownButton<String>(value: 'Current Financial Year', items: const [DropdownMenuItem(value: 'Current Financial Year', child: Text('Current Financial Year')), DropdownMenuItem(value: 'Previous Financial Year', child: Text('Previous Financial Year'))], onChanged: (_) {})])));

  Widget _insightCard(String title) => SizedBox(width: 210, height: 180, child: _panel(Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontWeight: FontWeight.bold)), const Spacer(), if (title == 'Expiry Item List') DropdownButton<int>(value: _expiryDays, items: [7, 15, 30, 45, 60, 90].map((days) => DropdownMenuItem(value: days, child: Text('$days days'))).toList(), onChanged: (value) { if (value != null) setState(() => _expiryDays = value); }), const Text('No data available', style: TextStyle(color: Colors.blueGrey, fontSize: 12)), const Spacer()])));

  Widget _quickLinks() => _panel(Wrap(spacing: 10, runSpacing: 10, children: [const Text('Quick Links', style: TextStyle(fontWeight: FontWeight.bold)), for (final link in ['Sale', 'Purchase', 'Expense', 'Add Party', 'Add Item']) OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.arrow_forward, size: 16), label: Text(link))]));

  Widget _panel(Widget child) => Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Theme.of(context).colorScheme.surfaceContainer, Theme.of(context).colorScheme.surface], begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Theme.of(context).colorScheme.secondary.withValues(alpha: .34)),
        boxShadow: [BoxShadow(color: Theme.of(context).colorScheme.primary.withValues(alpha: .24), blurRadius: 14, offset: const Offset(0, 5)), BoxShadow(color: Colors.black.withValues(alpha: .12), blurRadius: 2, offset: const Offset(0, -1))],
      ), child: child);

  Widget _privateText(String text) => _privacy ? ImageFiltered(imageFilter: ui.ImageFilter.blur(sigmaX: 5, sigmaY: 5), child: Text(text, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold))) : Text(text, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
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
