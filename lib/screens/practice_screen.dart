import 'package:flutter/material.dart';
import 'mcq_screen.dart';
import 'essay_screen.dart';
import 'audio_input_screen.dart';

class PracticeScreen extends StatefulWidget {
  const PracticeScreen({super.key});

  @override
  State<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<String> _tabs = ['Listening', 'Reading', 'Writing', 'Speaking'];

  final Map<String, Color> _tabColors = {
    'Listening': Color(0xFF40C4FF),
    'Reading': Color(0xFF69F0AE),
    'Writing': Color(0xFFFFB300),
    'Speaking': Color(0xFFAB47BC),
  };

  final Map<String, IconData> _tabIcons = {
    'Listening': Icons.headphones,
    'Reading': Icons.menu_book,
    'Writing': Icons.edit,
    'Speaking': Icons.record_voice_over,
  };

  final Map<String, List<Map<String, String>>> _tasks = {
    'Listening': [
      {'title': 'Short Conversation', 'difficulty': 'Easy', 'type': 'MCQ'},
      {'title': 'Lecture', 'difficulty': 'Medium', 'type': 'MCQ'},
    ],
    'Reading': [
      {'title': 'Passage 1', 'difficulty': 'Easy', 'type': 'MCQ'},
      {'title': 'Passage 2', 'difficulty': 'Hard', 'type': 'MCQ'},
    ],
    'Writing': [
      {'title': 'Essay: Technology', 'difficulty': 'Medium', 'type': 'Essay'},
      {'title': 'Essay: Education', 'difficulty': 'Hard', 'type': 'Essay'},
    ],
    'Speaking': [
      {'title': 'Describe a place', 'difficulty': 'Easy', 'type': 'Audio'},
      {'title': 'Talk about a hobby', 'difficulty': 'Medium', 'type': 'Audio'},
    ],
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  void _openTask(Map<String, String> task) {
    if (task['type'] == 'MCQ') {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (context) => const McqScreen()));
    } else if (task['type'] == 'Essay') {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (context) => const EssayScreen()));
    } else if (task['type'] == 'Audio') {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (context) => const AudioInputScreen()));
    }
  }

  Widget _buildTaskCard(String tab, Map<String, String> task, double width) {
    final color = _tabColors[tab]!;
    final icon = _tabIcons[tab]!;
    final difficulty = task['difficulty']!;
    final difficultyColor = difficulty == 'Easy'
        ? Colors.green
        : (difficulty == 'Medium' ? Colors.orange : Colors.red);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(width * 0.045),
      ),
      color: color.withOpacity(0.12),
      elevation: 3,
      margin: EdgeInsets.symmetric(
        vertical: width * 0.025,
        horizontal: width * 0.01,
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.25),
          radius: width * 0.06,
          child: Icon(icon, color: color, size: width * 0.07),
        ),
        title: Text(
          task['title']!,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: color,
            fontSize: width * 0.045,
          ),
        ),
        subtitle: Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.03,
                vertical: width * 0.012,
              ),
              decoration: BoxDecoration(
                color: difficultyColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(width * 0.025),
              ),
              child: Text(
                difficulty,
                style: TextStyle(
                  color: difficultyColor,
                  fontWeight: FontWeight.bold,
                  fontSize: width * 0.032,
                ),
              ),
            ),
            SizedBox(width: width * 0.025),
            Text(
              task['type']!,
              style: TextStyle(fontSize: width * 0.032, color: Colors.black54),
            ),
          ],
        ),
        trailing: Icon(Icons.arrow_forward_ios, size: width * 0.045),
        onTap: () => _openTask(task),
      ),
    );
  }

  Widget _buildEmptyState(String tab, double width, double height) {
    final color = _tabColors[tab]!;
    final icon = _tabIcons[tab]!;
    return Padding(
      padding: EdgeInsets.only(top: height * 0.1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: width * 0.15, color: color.withOpacity(0.5)),
          SizedBox(height: height * 0.02),
          Text(
            'No tasks available yet!',
            style: TextStyle(
              fontSize: width * 0.045,
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: height * 0.01),
          const Text(
            'Check back soon for more practice.',
            style: TextStyle(fontSize: 15, color: Colors.black54),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
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
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.03,
                      vertical: width * 0.02,
                    ),
                    child: TabBar(
                      controller: _tabController,
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(width * 0.04),
                        color: _tabColors[_tabs[_tabController.index]]!
                            .withOpacity(0.25),
                      ),
                      labelColor: _tabColors[_tabs[_tabController.index]],
                      unselectedLabelColor: Colors.black54,
                      tabs: _tabs.map((tab) {
                        return Tab(
                          icon: Icon(
                            _tabIcons[tab],
                            color: _tabColors[tab],
                            size: width * 0.07,
                          ),
                          text: tab,
                        );
                      }).toList(),
                      isScrollable: false,
                      onTap: (index) {
                        setState(() {}); // To update indicator color
                      },
                    ),
                  ),
                  SizedBox(
                    height:
                        constraints.maxHeight -
                        (width * 0.13), // TabBar height estimate
                    child: TabBarView(
                      controller: _tabController,
                      children: _tabs.map((tab) {
                        final tasks = _tasks[tab]!;
                        if (tasks.isEmpty) {
                          return _buildEmptyState(tab, width, height);
                        }
                        return ListView.builder(
                          padding: EdgeInsets.symmetric(
                            horizontal: width * 0.02,
                            vertical: height * 0.02,
                          ),
                          itemCount: tasks.length,
                          itemBuilder: (context, index) {
                            final task = tasks[index];
                            return _buildTaskCard(tab, task, width);
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
