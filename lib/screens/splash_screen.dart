import 'dart:async';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_wave_clipper.dart';
import '../widgets/monogram_logo.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  final bool autoNavigate;
  const SplashScreen({super.key, this.autoNavigate = true});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _fadeAnim;
  late Animation<double> _scaleAnim;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _fadeAnim = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeIn,
    );

    _scaleAnim = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: Curves.easeOutBack,
      ),
    );

    _animController.forward();

    // Navigate to Login Screen after 2.5 seconds
    if (widget.autoNavigate) {
      _timer = Timer(const Duration(milliseconds: 2500), () {
        if (mounted) {
          Navigator.of(context).pushReplacement(
            PageRouteBuilder(
              pageBuilder: (context, anim1, anim2) => const LoginScreen(),
              transitionsBuilder: (context, anim1, anim2, child) {
                return FadeTransition(opacity: anim1, child: child);
              },
              transitionDuration: const Duration(milliseconds: 500),
            ),
          );
        }
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background organic waves
          Positioned.fill(
            child: CustomPaint(
              painter: WaveBackgroundPainter(
                color1: const Color(0x2034D399),
                color2: const Color(0x35059669),
                color3: const Color(0x1810B981),
              ),
            ),
          ),

          // Main Center Content
          SafeArea(
            child: Center(
              child: FadeTransition(
                opacity: _fadeAnim,
                child: ScaleTransition(
                  scale: _scaleAnim,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Spacer(flex: 3),

                        // Logo Monogram CK
                        const MonogramLogo(
                          size: 110,
                          showShadow: true,
                        ),
                        const SizedBox(height: 24),

                        // App Name
                        const Text(
                          'CatatanKu',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.5,
                            color: Color(0xFF064E3B), // Deep Emerald
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Tagline
                        const Text(
                          'Simpan setiap ide,\nrencana, dan momen berharga\ndalam satu tempat.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.5,
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.w400,
                          ),
                        ),

                        const Spacer(flex: 2),

                        // Loading Indicator
                        Container(
                          width: 120,
                          height: 5,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE2E8F0),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: const LinearProgressIndicator(
                              value: 0.65,
                              backgroundColor: Color(0xFFE2E8F0),
                              valueColor: AlwaysStoppedAnimation<Color>(
                                AppColors.primary,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),
                        Text(
                          'Memuat aplikasi...',
                          style: TextStyle(
                            fontSize: 11,
                            color: AppColors.textMuted.withValues(alpha: 0.8),
                          ),
                        ),

                        const Spacer(flex: 1),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
