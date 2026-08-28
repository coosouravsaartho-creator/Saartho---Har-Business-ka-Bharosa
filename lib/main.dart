import 'dart:ui' as ui;

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
                top: 12,
                right: 20,
                child: ElevatedButton(
                  onPressed: () => _openDashboard(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFB300),
                    foregroundColor: const Color(0xFF202124),
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
                                    onPressed: () => _openDashboard(),
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
  static const primary = Color(0xFF123B70);
  static const accent = Color(0xFF1D73BE);
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
  const DashboardScreen({super.key, this.userName = '', this.businessName = ''});
  final String userName;
  final String businessName;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool _advanced = false;
  bool _privacy = false;
  String _theme = SaarthoThemes.names.first;
  int _expiryDays = 30;
  final _plan = const SaarthoPlan();

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
    return Theme(
      data: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: SaarthoThemes.primary),
        scaffoldBackgroundColor: const Color(0xFFF4F7FB),
      ),
      child: Scaffold(
        drawer: _sideMenu(),
        body: SafeArea(
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
          color: SaarthoThemes.primary,
          child: Row(children: [
            if (narrow) Builder(builder: (context) => IconButton(tooltip: 'Open navigation', onPressed: () => Scaffold.of(context).openDrawer(), color: Colors.white, icon: const Icon(Icons.menu))),
            _menuButton('Company', Icons.business, _companyMenu),
            _menuButton('Help', Icons.help_outline, _helpMenu),
            _menuButton('Shortcut', Icons.keyboard_alt_outlined, _shortcutMenu),
            IconButton(tooltip: 'Refresh app', onPressed: () {}, color: Colors.white, icon: const Icon(Icons.refresh)),
            const Spacer(),
            const Text('SAARTHO', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
          ]),
        );
      });

  Widget _menuButton(String label, IconData icon, VoidCallback onTap) => TextButton.icon(
        onPressed: onTap, icon: Icon(icon, size: 18), label: Text(label), style: TextButton.styleFrom(foregroundColor: Colors.white));

  void _showMenu(Widget child) => showMenu<void>(context: context, position: const RelativeRect.fromLTRB(18, 58, 0, 0), items: [PopupMenuItem(enabled: false, child: child)]);

  void _companyMenu() => _showMenu(Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('Active company', style: TextStyle(fontWeight: FontWeight.bold)),
        Text(widget.businessName.isEmpty ? 'No company selected' : widget.businessName),
        const Divider(),
        TextButton.icon(onPressed: () {}, icon: const Icon(Icons.swap_horiz), label: const Text('Change Company')),
        TextButton.icon(onPressed: () {}, icon: const Icon(Icons.add_business), label: const Text('Add New Company')),
      ]));

  void _helpMenu() => _showMenu(Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
        TextButton(onPressed: () {}, child: const Text('Check for Updates')),
        const Text('Current App Version: 1.0.0'),
        TextButton(onPressed: () => _contactDialog(), child: const Text('Contact Us')),
      ]));

  void _shortcutMenu() => _showMenu(const Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
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
    return Container(width: 260, color: Colors.white, child: ListView(padding: const EdgeInsets.fromLTRB(14, 14, 14, 24), children: [
      Container(padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: const Color(0xFFEAF2FB), borderRadius: BorderRadius.circular(8)), child: Row(children: [
        Expanded(child: Text(widget.businessName.isEmpty ? 'Add Company Name' : widget.businessName, style: const TextStyle(fontWeight: FontWeight.bold))),
        const Icon(Icons.edit_outlined, size: 18),
      ])),
      const SizedBox(height: 14), for (final item in items) _sideItem(item),
    ]));
  }

  Widget _sideItem(String label) {
    final comingSoon = label == 'Multi Device Sync';
    return ListTile(
      dense: true, selected: label == 'Home', selectedTileColor: const Color(0xFFDCEBFA),
      leading: Icon(_iconFor(label), size: 19, color: label == 'Home' ? SaarthoThemes.accent : Colors.blueGrey),
      title: Text(label, overflow: TextOverflow.ellipsis),
      trailing: comingSoon ? const Text('Soon', style: TextStyle(fontSize: 10, color: Colors.blueGrey)) : null,
      onTap: label == 'Change UI Theme Colour' ? _themeMenu : null,
      subtitle: label == 'Plan Status' ? Text('${SaarthoPlan.name}\n${_plan.expiryLabel}', style: const TextStyle(fontSize: 10)) : null,
    );
  }

  IconData _iconFor(String label) => const {
        'Home': Icons.home_outlined, 'Parties': Icons.people_outline, 'Items & Services': Icons.inventory_2_outlined,
        'Sale': Icons.point_of_sale, 'Purchase': Icons.shopping_cart_outlined, 'Expense': Icons.receipt_long_outlined,
        'Cash and Bank': Icons.account_balance_outlined, 'Reports': Icons.bar_chart, 'Additional Options': Icons.more_horiz,
        'Settings': Icons.settings_outlined, 'Backup & Restore': Icons.backup_outlined, 'Change UI Theme Colour': Icons.palette_outlined,
        'Multi Device Sync': Icons.sync, 'Plan & Pricing': Icons.card_membership_outlined, 'Plan Status': Icons.verified_outlined,
        'Give Feedback': Icons.feedback_outlined,
      }[label] ?? Icons.circle_outlined;

  void _themeMenu() => _showMenu(Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
        for (final theme in SaarthoThemes.names) RadioListTile<String>(dense: true, value: theme, groupValue: _theme, title: Text(theme, style: const TextStyle(fontSize: 12)), onChanged: (value) { if (value != null) setState(() => _theme = value); Navigator.pop(context); }),
      ]));

  Widget _content() => SingleChildScrollView(padding: const EdgeInsets.all(22), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _greetingCard(), const SizedBox(height: 18),
        Wrap(spacing: 12, runSpacing: 8, children: [
          SegmentedButton<bool>(segments: const [ButtonSegment(value: false, label: Text('Standard View')), ButtonSegment(value: true, label: Text('Advanced View'))], selected: {_advanced}, onSelectionChanged: (value) => setState(() => _advanced = value.first)),
          FilterChip(label: const Text('Privacy Mode'), selected: _privacy, onSelected: (value) => setState(() => _privacy = value)),
        ]), const SizedBox(height: 20), _advanced ? _advancedView() : _standardView(),
      ]));

  Widget _greetingCard() => Container(width: double.infinity, padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFFD9E4F0))), child: Row(children: [
        Icon(_greetingIcon, color: const Color(0xFFE39A20), size: 34), const SizedBox(width: 14),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(_greeting, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: SaarthoThemes.primary)), if (widget.userName.isNotEmpty) Text(widget.userName, style: const TextStyle(color: Colors.blueGrey))])),
      ]));

  Widget _standardView() => Column(children: [
        _sectionTitle('Business Overview', 'Today'),
        Wrap(spacing: 14, runSpacing: 14, children: [_metricCard('Sale Information'), _metricCard('Purchase Information'), _metricCard('Expense Information'), _metricCard('Receivable Balance'), _metricCard('Payable Balance')]),
        const SizedBox(height: 22), _quickLinks(),
      ]);

  Widget _advancedView() => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _sectionTitle('Advanced Overview', 'Financial year: 1 Apr - 31 Mar'),
        Wrap(spacing: 14, runSpacing: 14, children: [_metricCard('Sale Information'), _metricCard('Purchase Information'), _metricCard('Expense Information'), _metricCard('Receivable Balance'), _metricCard('Payable Balance')]),
        const SizedBox(height: 18), Wrap(spacing: 14, runSpacing: 14, children: [_chartCard(), _insightCard('Top Selling Products'), _insightCard('Top Customers'), _insightCard('Expiry Item List'), _insightCard('Low Selling Items')]),
        const SizedBox(height: 18), _quickLinks(),
      ]);

  Widget _sectionTitle(String title, String filter) => Padding(padding: const EdgeInsets.only(bottom: 12), child: Row(children: [Expanded(child: Text(title, style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: SaarthoThemes.primary))), DropdownButton<String>(value: filter, items: [DropdownMenuItem(value: filter, child: Text(filter))], onChanged: (_) {})]));

  Widget _metricCard(String title) => SizedBox(width: 210, child: _panel(Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontWeight: FontWeight.bold)), const SizedBox(height: 12), _privateText('No data available'), const SizedBox(height: 10), const Text('Date filter', style: TextStyle(fontSize: 11, color: Colors.blueGrey)), const Icon(Icons.calendar_today_outlined, size: 16, color: SaarthoThemes.accent)])));

  Widget _chartCard() => SizedBox(width: 430, height: 180, child: _panel(Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('Financial comparison', style: TextStyle(fontWeight: FontWeight.bold)), const Text('Current month vs previous month', style: TextStyle(fontSize: 12, color: Colors.blueGrey)), const Spacer(), const Icon(Icons.show_chart, size: 56, color: Color(0xFFB7CDE5)), const Spacer(), DropdownButton<String>(value: 'Current Financial Year', items: const [DropdownMenuItem(value: 'Current Financial Year', child: Text('Current Financial Year')), DropdownMenuItem(value: 'Previous Financial Year', child: Text('Previous Financial Year'))], onChanged: (_) {})])));

  Widget _insightCard(String title) => SizedBox(width: 210, height: 180, child: _panel(Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontWeight: FontWeight.bold)), const Spacer(), if (title == 'Expiry Item List') DropdownButton<int>(value: _expiryDays, items: [7, 15, 30, 45, 60, 90].map((days) => DropdownMenuItem(value: days, child: Text('$days days'))).toList(), onChanged: (value) { if (value != null) setState(() => _expiryDays = value); }), const Text('No data available', style: TextStyle(color: Colors.blueGrey, fontSize: 12)), const Spacer()])));

  Widget _quickLinks() => _panel(Wrap(spacing: 10, runSpacing: 10, children: [const Text('Quick Links', style: TextStyle(fontWeight: FontWeight.bold)), for (final link in ['Sale', 'Purchase', 'Expense', 'Add Party', 'Add Item']) OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.arrow_forward, size: 16), label: Text(link))]));

  Widget _panel(Widget child) => Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFFD9E4F0))), child: child);

  Widget _privateText(String text) => _privacy ? ImageFiltered(imageFilter: ui.ImageFilter.blur(sigmaX: 5, sigmaY: 5), child: Text(text, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold))) : Text(text, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
}
