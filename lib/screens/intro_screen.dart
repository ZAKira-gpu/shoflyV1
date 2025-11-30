import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'temperature_control_screen.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

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
          child: Column(
            children: [
              const SizedBox(height: 80),
              // Logo
              CustomPaint(
                size: const Size(100, 100),
                painter: HouseFlamePainter(),
              ),
              const SizedBox(height: 20),
              // App name
              const Text(
                'chauffly',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4C1D95), // Dark purple
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 60),
              // Tagline
              const Text(
                'take control',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF4C1D95),
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'stay comfortable',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF4C1D95),
                  letterSpacing: 0.5,
                ),
              ),
              const Spacer(),
              // Control button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TemperatureControlScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4C1D95), // Dark purple
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 8,
                    ),
                    child: const Text(
                      'Control',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
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
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final housePath = Path();
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    
    housePath.moveTo(centerX - 35, centerY + 15);
    housePath.lineTo(centerX - 35, centerY - 8);
    housePath.lineTo(centerX, centerY - 35);
    housePath.lineTo(centerX + 35, centerY - 8);
    housePath.lineTo(centerX + 35, centerY + 15);
    housePath.close();

    paint.color = const Color(0xFFFF6B35);
    canvas.drawPath(housePath, paint);
    
    paint.color = const Color(0xFFFF4500);
    paint.strokeWidth = 5;
    canvas.drawPath(housePath, paint);

    final flamePaint = Paint()
      ..color = const Color(0xFFFF0000)
      ..style = PaintingStyle.fill;
    
    final flamePath = Path();
    flamePath.moveTo(centerX, centerY + 3);
    flamePath.quadraticBezierTo(centerX - 7, centerY - 4, centerX, centerY - 12);
    flamePath.quadraticBezierTo(centerX + 7, centerY - 4, centerX, centerY + 3);
    flamePath.close();
    
    canvas.drawPath(flamePath, flamePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

