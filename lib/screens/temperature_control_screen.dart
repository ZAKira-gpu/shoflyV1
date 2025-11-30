import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;

class TemperatureControlScreen extends StatefulWidget {
  const TemperatureControlScreen({super.key});

  @override
  State<TemperatureControlScreen> createState() => _TemperatureControlScreenState();
}

class _TemperatureControlScreenState extends State<TemperatureControlScreen> {
  int currentTemp = 25;
  int targetTemp = 40;
  bool isPowerOn = true;
  bool isAutomaticOn = false;
  bool isChildLockOn = false;
  double humidity = 45;
  double energyUsage = 2.3;
  int sessionsToday = 2;
  double fanSpeed = 0.6;
  final List<_ScheduleEntry> scheduleEntries = const [
    _ScheduleEntry(title: 'Morning warm-up', subtitle: 'Daily at 6:00 AM', temperature: '38°C'),
    _ScheduleEntry(title: 'Afternoon relax', subtitle: 'Weekdays at 2:00 PM', temperature: '36°C'),
    _ScheduleEntry(title: 'Night recovery', subtitle: 'Daily at 10:00 PM', temperature: '40°C'),
  ];

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );
  }

  void _incrementTarget() {
    setState(() {
      if (targetTemp < 60) targetTemp++;
    });
  }

  void _decrementTarget() {
    setState(() {
      if (targetTemp > 15) targetTemp--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6B46C1), // Purple background
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Temperature control',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Fine tune comfort for your smart spa',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                // Circular temperature gauge
                SizedBox(
                  width: 280,
                  height: 280,
                  child: CustomPaint(
                    painter: TemperatureGaugePainter(
                      currentTemp: currentTemp,
                      minTemp: 15,
                      maxTemp: 55,
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '$currentTemp°C',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            'current temp',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: _InfoBadge(
                        title: 'Humidity',
                        value: '${humidity.round()}%',
                        icon: Icons.water_drop,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _InfoBadge(
                        title: 'Energy',
                        value: '${energyUsage.toStringAsFixed(1)} kWh',
                        icon: Icons.bolt,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _InfoBadge(
                        title: 'Sessions',
                        value: '$sessionsToday today',
                        icon: Icons.schedule,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                // Power toggle
                Column(
                  children: [
                    SizedBox(
                      width: 70,
                      height: 40,
                      child: Switch(
                        value: isPowerOn,
                        onChanged: (value) {
                          setState(() {
                            isPowerOn = value;
                          });
                        },
                        activeColor: const Color(0xFFFF0000),
                        activeTrackColor: const Color(0xFFFF4444),
                        inactiveThumbColor: Colors.grey[300],
                        inactiveTrackColor: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      isPowerOn ? 'ON' : 'OFF',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                // Target temperature control
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: _decrementTarget,
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: const Color(0xFFFF0000), width: 2),
                          ),
                          child: const Icon(
                            Icons.remove,
                            color: Color(0xFFFF0000),
                            size: 28,
                          ),
                        ),
                      ),
                      Text(
                        '$targetTemp°C',
                        style: const TextStyle(
                          color: Color(0xFFFF0000),
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: _incrementTarget,
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: const Color(0xFFFF0000), width: 2),
                          ),
                          child: const Icon(
                            Icons.add,
                            color: Color(0xFFFF0000),
                            size: 28,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Water circulation',
                            style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '${(fanSpeed * 100).round()}%',
                            style: const TextStyle(
                              color: Color(0xFFFF0000),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Adjust jet intensity to balance bubbles and heat',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 13,
                        ),
                      ),
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          thumbColor: const Color(0xFFFF0000),
                          activeTrackColor: const Color(0xFFFF4444),
                          inactiveTrackColor: Colors.grey[300],
                        ),
                        child: Slider(
                          value: fanSpeed,
                          min: 0.2,
                          max: 1,
                          divisions: 8,
                          label: '${(fanSpeed * 100).round()}%',
                          onChanged: (value) {
                            setState(() {
                              fanSpeed = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                // Bottom control cards
                Row(
                  children: [
                    Expanded(
                      child: _ControlCard(
                        title: 'Automatic',
                        value: isAutomaticOn ? 'On' : 'Off',
                        isOn: isAutomaticOn,
                        onChanged: (value) {
                          setState(() {
                            isAutomaticOn = value;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _ControlCard(
                        title: 'Child Lock',
                        value: isChildLockOn ? 'On' : 'Off',
                        isOn: isChildLockOn,
                        onChanged: (value) {
                          setState(() {
                            isChildLockOn = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            'Smart schedules',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(
                            Icons.add_circle_outline,
                            color: Color(0xFFFF0000),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      ...scheduleEntries.map(
                        (entry) => Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: _ScheduleTile(entry: entry),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ControlCard extends StatelessWidget {
  final String title;
  final String value;
  final bool isOn;
  final Function(bool) onChanged;

  const _ControlCard({
    required this.title,
    required this.value,
    required this.isOn,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                value,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                width: 50,
                height: 30,
                child: Switch(
                  value: isOn,
                  onChanged: onChanged,
                  activeColor: isOn ? const Color(0xFFFF0000) : Colors.grey,
                  activeTrackColor: isOn ? const Color(0xFFFF4444) : Colors.grey[400],
                  inactiveThumbColor: Colors.grey[300],
                  inactiveTrackColor: Colors.grey[600],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoBadge extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _InfoBadge({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ScheduleEntry {
  final String title;
  final String subtitle;
  final String temperature;

  const _ScheduleEntry({
    required this.title,
    required this.subtitle,
    required this.temperature,
  });
}

class _ScheduleTile extends StatelessWidget {
  final _ScheduleEntry entry;

  const _ScheduleTile({required this.entry});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFFFEEEE),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.timer,
              color: Color(0xFFFF0000),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  entry.subtitle,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          Text(
            entry.temperature,
            style: const TextStyle(
              color: Color(0xFFFF0000),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class TemperatureGaugePainter extends CustomPainter {
  final int currentTemp;
  final int minTemp;
  final int maxTemp;

  TemperatureGaugePainter({
    required this.currentTemp,
    required this.minTemp,
    required this.maxTemp,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 20;

    // Draw the gauge background (white segment at top)
    final backgroundPaint = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20
      ..strokeCap = StrokeCap.round;

    // Draw the main gauge (red)
    final gaugePaint = Paint()
      ..color = const Color(0xFFFF0000)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20
      ..strokeCap = StrokeCap.round;

    // Calculate the angle range
    // Start from bottom-left (around 225 degrees) and go clockwise
    const startAngle = -135 * math.pi / 180; // -135 degrees
    const sweepAngle = 270 * math.pi / 180; // 270 degrees total

    // Draw background arc
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      backgroundPaint,
    );

    // Calculate current temperature position
    final tempRange = maxTemp - minTemp;
    final tempProgress = (currentTemp - minTemp) / tempRange;
    final currentSweep = sweepAngle * tempProgress;

    // Draw red gauge
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      currentSweep,
      false,
      gaugePaint,
    );

    // Draw temperature markers
    final markerPaint = Paint()
      ..color = const Color(0xFFFF0000)
      ..style = PaintingStyle.fill;

    final markerPositions = [15, 25, 55];
    for (final temp in markerPositions) {
      final progress = (temp - minTemp) / tempRange;
      final angle = startAngle + (sweepAngle * progress);
      
      final markerX = center.dx + radius * math.cos(angle);
      final markerY = center.dy + radius * math.sin(angle);
      
      canvas.drawCircle(
        Offset(markerX, markerY),
        4,
        markerPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    if (oldDelegate is TemperatureGaugePainter) {
      return oldDelegate.currentTemp != currentTemp;
    }
    return true;
  }
}

