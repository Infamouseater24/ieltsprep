import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // GUARD: Only allow Firebase code on supported platforms
    if (!(kIsWeb || Platform.isAndroid || Platform.isIOS)) {
      return Center(
        child: Text(
          'Progress tracking is only available on Android, iOS, or Web.',
        ),
      );
    }

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final cardRadius = width * 0.05;
    final iconSize = width * 0.08;
    final streakFont = width * 0.045;
    final titleFont = width * 0.07;
    final chartHeight = height * 0.25;
    final badgeRadius = width * 0.09;
    final badgeFont = width * 0.032;

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return Center(child: Text('Please sign in to see your progress.'));
    }

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFB2FF59), Color(0xFF69F0AE), Color(0xFF40C4FF)],
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              final data = snapshot.data?.data() as Map<String, dynamic>? ?? {};
              final int streak = data['streak'] ?? 0;
              final double dailyGoalProgress =
                  (data['dailyGoalProgress'] ?? 0.0).toDouble();
              final List<dynamic> historyRaw =
                  data['practiceHistory'] ?? [0, 0, 0, 0, 0, 0, 0];
              final List<double> practiceHistory = historyRaw
                  .map((e) => (e as num).toDouble())
                  .toList();

              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Padding(
                    padding: EdgeInsets.all(width * 0.06),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.orange.shade100,
                                borderRadius: BorderRadius.circular(cardRadius),
                              ),
                              padding: EdgeInsets.all(width * 0.04),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.local_fire_department,
                                    color: Colors.orange,
                                    size: iconSize,
                                  ),
                                  SizedBox(width: width * 0.02),
                                  Text(
                                    '$streak day streak',
                                    style: TextStyle(
                                      fontSize: streakFont,
                                      color: const Color(0xFFBF360C),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: height * 0.03),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(cardRadius),
                          ),
                          color: Colors.yellow.shade100,
                          elevation: 3,
                          child: Padding(
                            padding: EdgeInsets.all(width * 0.05),
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.yellow.shade300,
                                    borderRadius: BorderRadius.circular(
                                      cardRadius * 0.8,
                                    ),
                                  ),
                                  padding: EdgeInsets.all(width * 0.03),
                                  child: Icon(
                                    Icons.emoji_events,
                                    color: Colors.white,
                                    size: iconSize,
                                  ),
                                ),
                                SizedBox(width: width * 0.04),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Daily Goal',
                                        style: TextStyle(
                                          fontSize: streakFont,
                                          fontWeight: FontWeight.bold,
                                          color: const Color(0xFF795548),
                                        ),
                                      ),
                                      SizedBox(height: height * 0.01),
                                      LinearProgressIndicator(
                                        value: dailyGoalProgress,
                                        minHeight: height * 0.012,
                                        backgroundColor: Colors.yellow.shade200,
                                        valueColor:
                                            const AlwaysStoppedAnimation<Color>(
                                              Color(0xFFFFA000),
                                            ),
                                      ),
                                      SizedBox(height: height * 0.01),
                                      Text(
                                        '${(dailyGoalProgress * 100).toInt()}% completed',
                                        style: TextStyle(
                                          fontSize: width * 0.035,
                                          color: const Color(0xFF795548),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: height * 0.04),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(cardRadius),
                          ),
                          color: Colors.cyan.shade50,
                          elevation: 2,
                          child: Padding(
                            padding: EdgeInsets.all(width * 0.05),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.bar_chart,
                                      color: const Color(0xFF00B8D4),
                                      size: iconSize * 0.9,
                                    ),
                                    SizedBox(width: width * 0.02),
                                    Text(
                                      'Practice History',
                                      style: TextStyle(
                                        fontSize: streakFont,
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xFF006064),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: height * 0.02),
                                SizedBox(
                                  height: chartHeight,
                                  child: BarChart(
                                    BarChartData(
                                      alignment: BarChartAlignment.spaceAround,
                                      maxY: 8,
                                      barTouchData: BarTouchData(
                                        enabled: false,
                                      ),
                                      titlesData: FlTitlesData(
                                        leftTitles: AxisTitles(
                                          sideTitles: SideTitles(
                                            showTitles: false,
                                          ),
                                        ),
                                        rightTitles: AxisTitles(
                                          sideTitles: SideTitles(
                                            showTitles: false,
                                          ),
                                        ),
                                        topTitles: AxisTitles(
                                          sideTitles: SideTitles(
                                            showTitles: false,
                                          ),
                                        ),
                                        bottomTitles: AxisTitles(
                                          sideTitles: SideTitles(
                                            showTitles: true,
                                            getTitlesWidget: (value, meta) {
                                              const days = [
                                                'M',
                                                'T',
                                                'W',
                                                'T',
                                                'F',
                                                'S',
                                                'S',
                                              ];
                                              return Padding(
                                                padding: EdgeInsets.only(
                                                  top: height * 0.01,
                                                ),
                                                child: Text(
                                                  days[value.toInt() % 7],
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: width * 0.035,
                                                  ),
                                                ),
                                              );
                                            },
                                            reservedSize: width * 0.08,
                                          ),
                                        ),
                                      ),
                                      borderData: FlBorderData(show: false),
                                      barGroups: List.generate(
                                        practiceHistory.length,
                                        (i) {
                                          return BarChartGroupData(
                                            x: i,
                                            barRods: [
                                              BarChartRodData(
                                                toY: practiceHistory[i],
                                                color:
                                                    Colors.lightGreen.shade700,
                                                width: width * 0.045,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                      width * 0.025,
                                                    ),
                                              ),
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
                        SizedBox(height: height * 0.04),
                        Text(
                          'Achievements',
                          style: TextStyle(
                            fontSize: titleFont * 0.6,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF00695C),
                          ),
                        ),
                        SizedBox(height: height * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildBadge(
                              Icons.emoji_events,
                              '7-day Streak!',
                              Colors.orange,
                              badgeRadius,
                              badgeFont,
                            ),
                            SizedBox(width: width * 0.04),
                            _buildBadge(
                              Icons.star,
                              'First Practice',
                              Colors.purple,
                              badgeRadius,
                              badgeFont,
                            ),
                            SizedBox(width: width * 0.04),
                            _buildBadge(
                              Icons.bolt,
                              'Quick Start',
                              Colors.blue,
                              badgeRadius,
                              badgeFont,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildBadge(
    IconData icon,
    String label,
    Color color,
    double radius,
    double fontSize,
  ) {
    return Column(
      children: [
        CircleAvatar(
          radius: radius,
          backgroundColor: color.withOpacity(0.15),
          child: Icon(icon, color: color, size: radius * 0.7),
        ),
        SizedBox(height: radius * 0.2),
        SizedBox(
          width: radius * 2.2,
          child: Text(
            label,
            style: TextStyle(
              fontSize: fontSize,
              color: color,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
