import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy user data
    const Map<String, dynamic> userData = {
      'name': 'John Smith',
      'username': '@johnsmith',
      'avatar': 'https://i.pravatar.cc/150?img=3',
      'level': 8,
      'xp': 7850,
      'xpToNextLevel': 10000,
      'quizzesTaken': 42,
      'correctAnswers': 378,
      'badges': [
        {
          'name': 'Science Master',
          'icon': Icons.science,
          'color': Colors.blue,
          'description': 'Completed 10 science quizzes',
        },
        {
          'name': 'History Buff',
          'icon': Icons.history_edu,
          'color': Colors.amber,
          'description': 'Answered 50 history questions correctly',
        },
        {
          'name': 'Quick Thinker',
          'icon': Icons.speed,
          'color': Colors.red,
          'description': 'Completed a quiz in under 2 minutes',
        },
        {
          'name': 'Perfect Score',
          'icon': Icons.star,
          'color': Colors.purple,
          'description': 'Got 100% on a quiz',
        },
        {
          'name': 'Quiz Addict',
          'icon': Icons.psychology,
          'color': Colors.green,
          'description': 'Completed 25 quizzes',
        },
      ],
      'recentActivity': [
        {
          'type': 'quiz_completed',
          'title': 'Science Trivia',
          'score': '8/10',
          'time': '2 hours ago',
        },
        {
          'type': 'badge_earned',
          'badge': 'Perfect Score',
          'time': '1 day ago',
        },
        {
          'type': 'quiz_completed',
          'title': 'Geography Challenge',
          'score': '10/10',
          'time': '1 day ago',
        },
        {
          'type': 'level_up',
          'level': 8,
          'time': '2 days ago',
        },
        {
          'type': 'quiz_completed',
          'title': 'Movie Quotes',
          'score': '7/10',
          'time': '3 days ago',
        },
      ],
    };

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Profile header
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade50,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    // Avatar and name
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage(userData['avatar'] as String),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                userData['name'] as String,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                userData['username'] as String,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.deepPurple,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.star,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          'Level ${userData['level']}',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: ElevatedButton.icon(
                                      onPressed: () {},
                                      icon: const Icon(Icons.edit, size: 16),
                                      label: const Text('Edit Profile'),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        foregroundColor: Colors.deepPurple,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // XP progress
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'XP Progress',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '${userData['xp']}/${userData['xpToNextLevel']} XP',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurple,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        LinearProgressIndicator(
                          value: (userData['xp'] as int) /
                              (userData['xpToNextLevel'] as int),
                          backgroundColor: Colors.grey[300],
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            Colors.deepPurple,
                          ),
                          borderRadius: BorderRadius.circular(10),
                          minHeight: 10,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${(userData['xpToNextLevel'] as int) - (userData['xp'] as int)} XP to Level ${(userData['level'] as int) + 1}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              // Stats
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    _buildStatCard(
                      'Quizzes Taken',
                      userData['quizzesTaken'].toString(),
                      Icons.quiz,
                      Colors.blue,
                    ),
                    const SizedBox(width: 16),
                    _buildStatCard(
                      'Correct Answers',
                      userData['correctAnswers'].toString(),
                      Icons.check_circle,
                      Colors.green,
                    ),
                  ],
                ),
              ),
              
              // Badges
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Badges',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: (userData['badges'] as List).length,
                        itemBuilder: (context, index) {
                          final badge = (userData['badges'] as List)[index] as Map<String, dynamic>;
                          return _buildBadge(
                            badge['name'] as String,
                            badge['icon'] as IconData,
                            badge['color'] as Color,
                            badge['description'] as String,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Recent activity
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Recent Activity',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: (userData['recentActivity'] as List).length,
                      itemBuilder: (context, index) {
                        final activity = (userData['recentActivity'] as List)[index] as Map<String, dynamic>;
                        return _buildActivityItem(activity);
                      },
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: color,
                size: 24,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildBadge(
    String name,
    IconData icon,
    Color color,
    String description,
  ) {
    return Container(
      width: 80,
      margin: const EdgeInsets.only(right: 16),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: color,
              size: 28,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
  
  Widget _buildActivityItem(Map<String, dynamic> activity) {
    IconData icon;
    Color color;
    String title;
    String subtitle;
    
    switch (activity['type']) {
      case 'quiz_completed':
        icon = Icons.assignment_turned_in;
        color = Colors.green;
        title = 'Completed ${activity['title']}';
        subtitle = 'Score: ${activity['score']}';
        break;
      case 'badge_earned':
        icon = Icons.emoji_events;
        color = Colors.amber;
        title = 'Earned ${activity['badge']} badge';
        subtitle = '';
        break;
      case 'level_up':
        icon = Icons.arrow_upward;
        color = Colors.purple;
        title = 'Reached Level ${activity['level']}';
        subtitle = '';
        break;
      default:
        icon = Icons.info;
        color = Colors.blue;
        title = 'Activity';
        subtitle = '';
    }
    
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: color,
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (subtitle.isNotEmpty) ...[
            Text(
              subtitle,
              style: const TextStyle(fontSize: 12),
            ),
            const SizedBox(height: 2),
          ],
          Text(
            activity['time'],
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
      contentPadding: EdgeInsets.zero,
    );
  }
}