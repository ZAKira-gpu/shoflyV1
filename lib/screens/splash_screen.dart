import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'intro_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    _navigateToIntro();
  }

  _navigateToIntro() async {
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const IntroScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE8D5FF), // Light lavender purple
              Color(0xFF6B46C1), // Deep purple
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // House with flame logo
                CustomPaint(
                  size: const Size(120, 120),
                  painter: HouseFlamePainter(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HouseFlamePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // House outline with gradient effect (orange-red)
    final housePath = Path();
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    
    // House base (pentagon shape)
    housePath.moveTo(centerX - 40, centerY + 20);
    housePath.lineTo(centerX - 40, centerY - 10);
    housePath.lineTo(centerX, centerY - 40); // Roof peak
    housePath.lineTo(centerX + 40, centerY - 10);
    housePath.lineTo(centerX + 40, centerY + 20);
    housePath.close();

    // Draw house with gradient-like effect
    paint.color = const Color(0xFFFF6B35); // Orange-red
    canvas.drawPath(housePath, paint);
    
    paint.color = const Color(0xFFFF4500); // Deeper red-orange
    paint.strokeWidth = 6;
    canvas.drawPath(housePath, paint);

    // Flame inside
    final flamePaint = Paint()
      ..color = const Color(0xFFFF0000) // Vibrant red
      ..style = PaintingStyle.fill;
    
    final flamePath = Path();
    flamePath.moveTo(centerX, centerY + 5);
    flamePath.quadraticBezierTo(centerX - 8, centerY - 5, centerX, centerY - 15);
    flamePath.quadraticBezierTo(centerX + 8, centerY - 5, centerX, centerY + 5);
    flamePath.close();
    
    canvas.drawPath(flamePath, flamePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

