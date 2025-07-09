import 'package:flutter/material.dart';
import 'practice_screen.dart';
import 'progress_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  int _streak = 5; // Placeholder streak
  double _dailyGoalProgress = 0.6; // 60% of daily goal (placeholder)

  void _onNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildHomeContent(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final padding = width * 0.06;
    final cardRadius = width * 0.05;
    final iconSize = width * 0.08;
    final streakFont = width * 0.045;
    final titleFont = width * 0.07;
    final tipFont = width * 0.045;
    final buttonFont = width * 0.055;
    final buttonPadding = EdgeInsets.symmetric(
      horizontal: width * 0.12,
      vertical: height * 0.025,
    );

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
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Padding(
                padding: EdgeInsets.all(padding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.waving_hand,
                                  color: Colors.amber,
                                  size: iconSize,
                                ),
                                SizedBox(width: width * 0.02),
                                Text(
                                  'Hello!',
                                  style: TextStyle(
                                    fontSize: titleFont,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF00695C),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: height * 0.005),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.orange.shade100,
                                borderRadius: BorderRadius.circular(
                                  cardRadius * 0.6,
                                ),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: width * 0.025,
                                vertical: height * 0.005,
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.local_fire_department,
                                    color: Colors.orange,
                                    size: iconSize * 0.7,
                                  ),
                                  SizedBox(width: width * 0.01),
                                  Text(
                                    '$_streak day streak',
                                    style: TextStyle(
                                      fontSize: streakFont,
                                      color: const Color(0xFFBF360C),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        CircleAvatar(
                          radius: width * 0.07,
                          backgroundColor: Colors.deepPurple.shade100,
                          child: Icon(
                            Icons.account_circle,
                            size: iconSize,
                            color: Colors.deepPurple,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.04),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                    value: _dailyGoalProgress,
                                    minHeight: height * 0.012,
                                    backgroundColor: Colors.yellow.shade200,
                                    valueColor:
                                        const AlwaysStoppedAnimation<Color>(
                                          Color(0xFFFFA000),
                                        ),
                                  ),
                                  SizedBox(height: height * 0.01),
                                  Text(
                                    '${(_dailyGoalProgress * 100).toInt()}% completed',
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
                    Center(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightGreen.shade700,
                          foregroundColor: Colors.white,
                          padding: buttonPadding,
                          textStyle: TextStyle(
                            fontSize: buttonFont,
                            fontWeight: FontWeight.bold,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(cardRadius),
                          ),
                          elevation: 4,
                        ),
                        icon: Icon(Icons.play_arrow, size: iconSize),
                        label: const Text('Start Practice'),
                        onPressed: () {
                          setState(() {
                            _selectedIndex = 1; // Switch to Practice tab
                          });
                        },
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
                        padding: EdgeInsets.all(width * 0.04),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.cyan.shade200,
                                borderRadius: BorderRadius.circular(
                                  cardRadius * 0.6,
                                ),
                              ),
                              padding: EdgeInsets.all(width * 0.02),
                              child: Icon(
                                Icons.lightbulb,
                                color: Colors.white,
                                size: iconSize * 0.7,
                              ),
                            ),
                            SizedBox(width: width * 0.03),
                            Expanded(
                              child: Text(
                                'Tip: Practice a little every day to improve your IELTS score!',
                                style: TextStyle(
                                  fontSize: tipFont,
                                  color: const Color(0xFF006064),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: _selectedIndex == 0
          ? _buildHomeContent(context)
          : _selectedIndex == 1
          ? const PracticeScreen()
          : _selectedIndex == 2
          ? const ProgressScreen()
          : const ProfileScreen(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onNavTapped,
        selectedItemColor: Colors.lightGreen.shade700,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Practice'),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            label: 'Progress',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
