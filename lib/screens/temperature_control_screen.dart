import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TemperatureControlScreen extends StatefulWidget {
  const TemperatureControlScreen({super.key});

  @override
  State<TemperatureControlScreen> createState() => _TemperatureControlScreenState();
}

class _TemperatureControlScreenState extends State<TemperatureControlScreen> {
  double currentTemp = 22.5;
  double targetTemp = 22.0;
  bool isPowerOn = true;
  bool isAutomaticMode = false;
  double minTemp = 15.0;
  double maxTemp = 30.0;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5EFE7), // Beige/cream background
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      // Logo
                      Image.asset(
                        'assets/LOGO.jpg',
                        width: 80,
                        height: 80,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 16),
                      // App Title
                      const Text(
                        'Chauffly',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 32),
                      // ON Status
                      Text(
                        isPowerOn ? 'ON' : 'OFF',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[800],
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Current Temperature Display
                      Text(
                        '${currentTemp.toStringAsFixed(1)}°C',
                        style: const TextStyle(
                          fontSize: 72,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFE63946), // Red color
                          height: 1,
                        ),
                      ),
                      const SizedBox(height: 32),
                      // SEE label and range
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'SEE',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[700],
                            ),
                          ),
                          Text(
                            '${minTemp.toInt()}-${maxTemp.toInt()}°C',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      // Temperature Slider
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          activeTrackColor: const Color(0xFFE63946),
                          inactiveTrackColor: Colors.grey[300],
                          thumbColor: const Color(0xFFE63946),
                          overlayColor: const Color(0xFFE63946).withValues(alpha: 0.2),
                          thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
                          trackHeight: 6,
                        ),
                        child: Slider(
                          value: currentTemp,
                          min: minTemp,
                          max: maxTemp,
                          onChanged: (value) {
                            setState(() {
                              currentTemp = value;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 40),
                      // Target Temperature Row
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${targetTemp.toInt()}°C',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Transform.scale(
                              scale: 0.9,
                              child: Switch(
                                value: isPowerOn,
                                onChanged: (value) {
                                  setState(() {
                                    isPowerOn = value;
                                  });
                                },
                                activeTrackColor: const Color(0xFFE63946).withValues(alpha: 0.5),
                                activeThumbColor: const Color(0xFFE63946),
                                inactiveThumbColor: Colors.grey[400],
                                inactiveTrackColor: Colors.grey[300],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Automatic Mode Row
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Mode automatique',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            Transform.scale(
                              scale: 0.9,
                              child: Switch(
                                value: isAutomaticMode,
                                onChanged: (value) {
                                  setState(() {
                                    isAutomaticMode = value;
                                  });
                                },
                                activeTrackColor: const Color(0xFFE63946).withValues(alpha: 0.5),
                                activeThumbColor: const Color(0xFFE63946),
                                inactiveThumbColor: Colors.grey[400],
                                inactiveTrackColor: Colors.grey[300],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
            // Bottom Connection Bar
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: const BoxDecoration(
                color: Color(0xFF1A1A1A), // Dark background
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Connection indicator
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: isPowerOn ? const Color(0xFF00FF88) : Colors.grey,
                      shape: BoxShape.circle,
                      boxShadow: isPowerOn
                          ? [
                              BoxShadow(
                                color: const Color(0xFF00FF88).withValues(alpha: 0.6),
                                blurRadius: 12,
                                spreadRadius: 2,
                              ),
                            ]
                          : [],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    isPowerOn ? 'Connecté' : 'Déconnecté',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
