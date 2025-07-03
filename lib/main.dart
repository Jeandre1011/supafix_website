import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class _SectionKeys {
  static final hero = GlobalKey();
  static final services = GlobalKey();
  static final contact = GlobalKey();
}

void main() {
  runApp(const SupaFixApp());
}

class SupaFixApp extends StatelessWidget {
  const SupaFixApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Supa Fix TV's",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF00FF00),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF00FF00),
          primary: const Color(0xFF00FF00),
          secondary: const Color(0xFF4FC3F7),
          background: const Color(0xFFFFFFFF),
        ),
        scaffoldBackgroundColor: const Color(0xFFFFFFFF),
        textTheme: GoogleFonts.robotoTextTheme(
          Theme.of(context).textTheme.apply(
                bodyColor: const Color(0xFF000000),
                displayColor: const Color(0xFF000000),
              ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF2B2B2B),
          foregroundColor: Color(0xFF00FF00),
          titleTextStyle: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.bold,
            color: Color(0xFF00FF00),
            fontSize: 24,
          ),
        ),
        fontFamily: 'Roboto',
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  void _scrollToSection(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Supa Fix TV's"),
        actions: [
          _HoverButton(
            label: 'Home',
            onTap: () => _scrollToSection(_SectionKeys.hero),
          ),
          _HoverButton(
            label: 'Services',
            onTap: () => _scrollToSection(_SectionKeys.services),
          ),
          _HoverButton(
            label: 'Contact',
            onTap: () => _scrollToSection(_SectionKeys.contact),
          ),
          _HoverButton(
            label: 'Meet Our Team',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const MeetOurTeamPage()),
              );
            },
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isMobile = constraints.maxWidth < 600;
          bool isTablet = constraints.maxWidth >= 600 && constraints.maxWidth < 1024;
          double headlineFontSize = isMobile ? 24 : 32;
          double subtextFontSize = isMobile ? 14 : 18;
          double padding = isMobile ? 16 : 32;
          int gridCount = isMobile ? 1 : (isTablet ? 2 : 4);
          return SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Hero Section
                Container(
                  key: _SectionKeys.hero,
                  color: Colors.white,
                  padding: EdgeInsets.all(padding),
                  child: Flex(
                    direction: isMobile ? Axis.vertical : Axis.horizontal,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Reliable Repairs for TVs and Electronics',
                              style: TextStyle(
                                fontSize: headlineFontSize,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Professional repair services for TV, DVD, HiFi, and screen issues.',
                              style: TextStyle(
                                fontSize: subtextFontSize,
                                color: Color(0xFF333333),
                              ),
                            ),
                            const SizedBox(height: 24),
                          ],
                        ),
                      ),
                      SizedBox(width: isMobile ? 0 : 32, height: isMobile ? 32 : 0),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.only(top: isMobile ? 24 : 0),
                          child: AspectRatio(
                            aspectRatio: 4 / 3,
                            child: Image.asset(
                              'assets/images/technician_fixing_tv.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Services Section
                Container(
                  key: _SectionKeys.services,
                  padding: EdgeInsets.symmetric(vertical: isMobile ? 32 : 48, horizontal: isMobile ? 12 : 24),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Our Services',
                        style: TextStyle(
                          fontSize: isMobile ? 22 : 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 16),
                      GridView.count(
                        crossAxisCount: gridCount,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        children: const [
                          _ServiceCard(
                            icon: Icons.tv,
                            title: 'TV Repair',
                            description: 'Fixing all types of televisions, including LED, LCD and Plasma.',
                          ),
                          _ServiceCard(
                            icon: Icons.movie,
                            title: 'DVD Player Repair',
                            description: 'Repairing DVD players to restore playback functionality.',
                          ),
                          _ServiceCard(
                            icon: Icons.speaker,
                            title: 'HiFi & Audio Repair',
                            description: 'Servicing HiFi systems and audio equipment for optimal sound.',
                          ),
                          _ServiceCard(
                            icon: Icons.screen_search_desktop,
                            title: 'Screen Replacement',
                            description: 'Replacing damaged screens on TVs or other devices.',
                          ),
                          _ServiceCard(
                            icon: FontAwesomeIcons.satelliteDish,
                            title: 'Installation and Repair of DStv, OVHD',
                            description: 'Professional installation and repair services for DStv and OVHD satellite systems. Fast, reliable, and affordable.',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Contact Section
                Container(
                  key: _SectionKeys.contact,
                  color: const Color(0xFFF5F5F5),
                  padding: EdgeInsets.all(isMobile ? 16 : 32),
                  child: Flex(
                    direction: isMobile ? Axis.vertical : Axis.horizontal,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Bethlehem',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text('058 303 0281'),
                            SizedBox(height: 4),
                            Text('supafix@telkomsa.net'),
                          ],
                        ),
                      ),
                      SizedBox(width: isMobile ? 0 : 32, height: isMobile ? 24 : 0),
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Contact Us',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text('Have any questions? Get in touch with us!'),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF00FF00),
                                foregroundColor: Colors.black,
                                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              onPressed: () async {
                                final url = Uri.parse('https://wa.me/27828243022');
                                if (await canLaunchUrl(url)) {
                                  await launchUrl(url, mode: LaunchMode.externalApplication);
                                }
                              },
                              child: const Text('Contact Now'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Footer Section
                Container(
                  color: const Color(0xFF2B2B2B),
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "© 2024 Supa Fix TV's. All rights reserved.",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (_) => const PrivacyPolicyPage()),
                              );
                            },
                            child: const Text(
                              'Privacy Policy',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (_) => const TermsPage()),
                              );
                            },
                            child: const Text(
                              'Terms and Conditions',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: _WhatsAppFloatingButton(),
    );
  }
}

class _HoverButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const _HoverButton({required this.label, required this.onTap, super.key});

  @override
  State<_HoverButton> createState() => _HoverButtonState();
}

class _HoverButtonState extends State<_HoverButton> {
  bool _hovering = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: TextButton(
        onPressed: widget.onTap,
        child: Text(
          widget.label,
          style: TextStyle(
            color: _hovering ? const Color(0xFF4FC3F7) : const Color(0xFF00FF00),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class _ServiceCard extends StatefulWidget {
  final dynamic icon;
  final String title;
  final String description;

  const _ServiceCard({
    required this.icon,
    required this.title,
    required this.description,
    super.key,
  });

  @override
  State<_ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<_ServiceCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
      ),
      padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          widget.icon is IconData
              ? Icon(widget.icon, size: 48, color: const Color(0xFF00FF00))
              : FaIcon(widget.icon, size: 48, color: const Color(0xFF00FF00)),
          const SizedBox(height: 16),
            Text(
            widget.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            widget.description,
            style: const TextStyle(fontSize: 14, color: Color(0xFF333333)),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// Placeholder Privacy Policy Page
class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Privacy Policy')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView(
          children: const [
            Text('Privacy Policy for Supafix TVs', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Effective Date: [Insert Date]', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            Text('Supafix TVs ("we", "us", or "our") is committed to protecting your privacy. This Privacy Policy explains how we collect, use, store, and protect your personal information when you interact with our services — including our website, mobile applications, or when you contact us for support and TV repair services.', style: TextStyle(fontSize: 16)),
            SizedBox(height: 24),
            Text('1. Information We Collect', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            SizedBox(height: 8),
            Text('a) Personal Information', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('• Full Name'),
            Text('• Phone Number'),
            Text('• Email Address'),
            Text('• Home Address (for service visits)'),
            Text('• Device Information (TV brand, model, issue)'),
            SizedBox(height: 8),
            Text('b) Usage Information', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('• IP Address'),
            Text('• Browser Type and Version'),
            Text('• Access Times and Pages Visited'),
            Text('• Device Information (if using our app)'),
            SizedBox(height: 8),
            Text('c) Payment Information', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('• Billing details (when applicable)'),
            Text('• Transaction records'),
            Text('(Note: We do not store credit card numbers; payments are handled securely via third-party providers.)'),
            SizedBox(height: 24),
            Text('2. How We Use Your Information', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            SizedBox(height: 8),
            Text('We use your information to:'),
            Text('• Schedule and manage repair appointments'),
            Text('• Communicate with you about your service request'),
            Text('• Send updates, invoices, or follow-ups'),
            Text('• Improve our website, services, and customer experience'),
            Text('• Ensure security, fraud prevention, and legal compliance'),
            SizedBox(height: 24),
            Text('3. How We Share Your Information', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            SizedBox(height: 8),
            Text('We do not sell your personal data.'),
            Text('We may share your data only with:'),
            Text('• Technicians and Contractors working on your repair'),
            Text('• Service Providers (e.g., cloud hosting, payment processors)'),
            Text('• Law Enforcement or Legal Authorities when required by law'),
            Text('All third parties are contractually obligated to keep your information confidential.'),
            SizedBox(height: 24),
            Text('4. Data Retention', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            SizedBox(height: 8),
            Text('We retain your information only as long as necessary to fulfill the purposes outlined in this policy or as required by law.'),
            SizedBox(height: 24),
            Text('5. Your Rights and Choices', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            SizedBox(height: 8),
            Text('You may:'),
            Text('• Access, update, or delete your personal data'),
            Text('• Request a copy of the data we hold about you'),
            Text('• Withdraw your consent at any time (where applicable)'),
            Text('• Opt out of marketing emails via the unsubscribe link'),
            SizedBox(height: 8),
            Text('To exercise any of these rights, please contact us at: [your support email]'),
            SizedBox(height: 24),
            Text('6. Cookies and Tracking Technologies', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            SizedBox(height: 8),
            Text('Our website may use cookies and analytics tools to understand user behavior, improve performance, and personalize content. You can manage cookies through your browser settings.'),
            SizedBox(height: 24),
            Text('7. Data Security', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            SizedBox(height: 8),
            Text('We implement strong technical and organizational safeguards to protect your data, including:'),
            Text('• SSL Encryption'),
            Text('• Secure Cloud Storage (e.g., Supabase, Firebase, etc.)'),
            Text('• Role-based access for authorized personnel only'),
            SizedBox(height: 24),
            Text('8. Children\'s Privacy', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            SizedBox(height: 8),
            Text('Our services are not intended for users under 16 years of age. We do not knowingly collect personal data from children.'),
            SizedBox(height: 24),
            Text('9. International Users', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            SizedBox(height: 8),
            Text('If you are accessing our services outside of South Africa, please note that your data may be transferred to and processed in South Africa where our servers or service providers are located.'),
            SizedBox(height: 24),
            Text('10. Changes to This Policy', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            SizedBox(height: 8),
            Text('We may update this Privacy Policy from time to time. You will be notified via email or our platform of any significant changes. Your continued use of our services constitutes acceptance of the updated policy.'),
          ],
        ),
      ),
    );
  }
}

// Detailed Terms and Conditions Page
class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Terms and Conditions')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView(
          children: const [
            Text('Terms and Conditions', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            Text('1. No Guarantee on AUDIO SECTION'),
            Text('2. No Guarantee on SPEAKERS'),
            Text('3. One-month guarantee only on repaired section from repair date'),
            Text('4. No guarantee on AMP or HI-FI'),
            Text('5. Address: 24 Pretorius Street, Bethlehem'),
            Text('6. Tel: 058 303 0281 / 082 839 7844'),
            Text('7. Slip must be retained — NO SLIP = NO UNIT RETURNED'),
            Text('8. Repairs under R900 (general), R1800 (LCD/LED/Plasma), R2500 (Smart TV) = auto-approved'),
            Text('9. Supa Fix not liable for theft, fire, damages'),
            Text('10. Spares guaranteed 30 days from repair (repaired section only)'),
            Text('11. Equipment must be collected within 30 days — else disposed'),
            Text('12. Customer must follow up — no calls will be made'),
            Text('13. Sticker removal = Guarantee void'),
            Text('14. Replaced parts are discarded unless requested'),
            Text('15. R250 VAT incl. fee for rejected quotes, cancelled jobs, or part unavailability'),
            Text('16. Reimbursements = total paid minus R250'),
            Text('17. Insurance letters = R400 each'),
            Text('18. No verbal agreements — only signed agreements are valid'),
            Text('19. Supa Fix can override estimate for non-returnable or non-reversible items'),
          ],
        ),
      ),
    );
  }
}

class _WhatsAppFloatingButton extends StatelessWidget {
  const _WhatsAppFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 80, right: 8),
      child: FloatingActionButton(
        backgroundColor: const Color(0xFF25D366),
        onPressed: () async {
          final url = Uri.parse('https://wa.me/27828243022');
          if (await canLaunchUrl(url)) {
            await launchUrl(url, mode: LaunchMode.externalApplication);
          }
        },
        child: const FaIcon(FontAwesomeIcons.whatsapp, color: Colors.white, size: 32),
        tooltip: 'Chat on WhatsApp',
      ),
    );
  }
}

// Meet Our Team Page
class MeetOurTeamPage extends StatelessWidget {
  const MeetOurTeamPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Meet Our Team')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Meet Our Team', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            Text('At Supa Fix TVs, our team is made up of experienced technicians and friendly staff dedicated to providing the best service in TV and electronics repair. We pride ourselves on professionalism, expertise, and customer care.'),
            SizedBox(height: 24),
            // Add more team member cards or info here as needed
            Text('• John Doe – Senior Technician'),
            Text('• Jane Smith – Customer Service'),
            Text('• Mike Brown – Installation Specialist'),
            Text('• Sarah Lee – Workshop Manager'),
            SizedBox(height: 24),
            Text('We look forward to serving you!'),
          ],
        ),
      ),
    );
  }
}
