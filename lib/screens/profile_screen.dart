import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final cardRadius = width * 0.05;
    final avatarRadius = width * 0.13;
    final iconSize = width * 0.09;
    final nameFont = width * 0.065;
    final emailFont = width * 0.04;
    final statFont = width * 0.05;
    final labelFont = width * 0.035;
    final buttonFont = width * 0.045;
    final buttonPadding = EdgeInsets.symmetric(
      horizontal: width * 0.08,
      vertical: height * 0.018,
    );

    // Placeholder user data
    final String name = 'IELTS Learner';
    final String email = 'user@email.com';
    final int streak = 5;
    final int tasksCompleted = 42;

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
                padding: EdgeInsets.all(width * 0.06),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: avatarRadius,
                      backgroundColor: Colors.deepPurple.shade100,
                      child: Icon(
                        Icons.person,
                        size: iconSize * 1.2,
                        color: Colors.deepPurple,
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: nameFont,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF00695C),
                      ),
                    ),
                    SizedBox(height: height * 0.005),
                    Text(
                      email,
                      style: TextStyle(
                        fontSize: emailFont,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(height: height * 0.015),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightGreen.shade700,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(cardRadius),
                        ),
                        textStyle: TextStyle(fontSize: buttonFont),
                        padding: buttonPadding,
                      ),
                      icon: Icon(Icons.edit, size: iconSize * 0.7),
                      label: const Text('Edit Profile'),
                      onPressed: () {},
                    ),
                    SizedBox(height: height * 0.04),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(cardRadius),
                      ),
                      color: Colors.yellow.shade100,
                      elevation: 2,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: height * 0.03,
                          horizontal: width * 0.08,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Icon(
                                  Icons.local_fire_department,
                                  color: Colors.orange,
                                  size: iconSize,
                                ),
                                SizedBox(height: height * 0.01),
                                Text(
                                  '$streak',
                                  style: TextStyle(
                                    fontSize: statFont,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFFBF360C),
                                  ),
                                ),
                                Text(
                                  'Streak',
                                  style: TextStyle(
                                    fontSize: labelFont,
                                    color: const Color(0xFFBF360C),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                  size: iconSize,
                                ),
                                SizedBox(height: height * 0.01),
                                Text(
                                  '$tasksCompleted',
                                  style: TextStyle(
                                    fontSize: statFont,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                                Text(
                                  'Tasks',
                                  style: TextStyle(
                                    fontSize: labelFont,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.04),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade400,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(cardRadius),
                        ),
                        textStyle: TextStyle(fontSize: buttonFont),
                        padding: buttonPadding,
                      ),
                      icon: Icon(Icons.logout, size: iconSize * 0.7),
                      label: const Text('Logout'),
                      onPressed: () {
                        // TODO: Implement logout
                      },
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
}
