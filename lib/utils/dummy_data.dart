import 'package:flutter/material.dart';
import '../models/quiz_model.dart' hide Badge;

class DummyData {
  // static List<Quiz> getQuizzes() {
  //   return [
  //     Quiz(
  //       id: '1',
  //       title: 'Science Trivia',
  //       description: 'Test your knowledge of basic science concepts and discoveries.',
  //       timeInMinutes: 5,
  //       difficulty: 3,
  //       questions: _getScienceQuestions(),
  //     ),
  //     Quiz(
  //       id: '2',
  //       title: 'History Facts',
  //       description: 'Journey through time with these historical questions.',
  //       timeInMinutes: 5,
  //       difficulty: 2,
  //       questions: _getHistoryQuestions(),
  //     ),
  //     Quiz(
  //       id: '3',
  //       title: 'Geography Challenge',
  //       description: 'Test your knowledge of countries, capitals, and landmarks.',
  //       timeInMinutes: 5,
  //       difficulty: 3,
  //       questions: _getGeographyQuestions(),
  //     ),
  //     Quiz(
  //       id: '4',
  //       title: 'Movie Quotes',
  //       description: 'Can you identify these famous movie quotes?',
  //       timeInMinutes: 5,
  //       difficulty: 2,
  //       questions: [],
  //     ),
  //     Quiz(
  //       id: '5',
  //       title: 'Music Legends',
  //       description: 'Test your knowledge of music history and famous artists.',
  //       timeInMinutes: 5,
  //       difficulty: 3,
  //       questions: [],
  //     ),
  //   ];
  // }

  static List<Category> getCategories() {
    return [
      Category(id: '1', name: 'Science', iconName: 'science', color: '#1565C0', quizCount: 12),
      Category(id: '2', name: 'History', iconName: 'history_edu', color: '#FFA000', quizCount: 8),
      Category(id: '3', name: 'Geography', iconName: 'public', color: '#2E7D32', quizCount: 10),
      Category(id: '4', name: 'Sports', iconName: 'sports_soccer', color: '#F57C00', quizCount: 6),
      Category(id: '5', name: 'Movies', iconName: 'movie', color: '#C62828', quizCount: 15),
      Category(id: '6', name: 'Music', iconName: 'music_note', color: '#6A1B9A', quizCount: 9),
      Category(id: '7', name: 'Technology', iconName: 'computer', color: '#00695C', quizCount: 11),
      Category(id: '8', name: 'Art', iconName: 'palette', color: '#AD1457', quizCount: 7),
    ];
  }

  // Dummy leaderboard
  static List<LeaderboardEntry> getLeaderboard() {
    return [
      LeaderboardEntry(
        userId: '1',
        name: 'Alex Johnson',
        username: '@alexj',
        avatarUrl: 'https://i.pravatar.cc/150?img=1',
        rank: 1,
        score: 9850,
      ),
      LeaderboardEntry(
        userId: '2',
        name: 'Maria Garcia',
        username: '@mgarcia',
        avatarUrl: 'https://i.pravatar.cc/150?img=5',
        rank: 2,
        score: 9720,
      ),
      LeaderboardEntry(
        userId: '3',
        name: 'John Smith',
        username: '@johnsmith',
        avatarUrl: 'https://i.pravatar.cc/150?img=3',
        rank: 3,
        score: 9580,
        isCurrentUser: true,
      ),
      LeaderboardEntry(
        userId: '4',
        name: 'Sarah Williams',
        username: '@swilliams',
        avatarUrl: 'https://i.pravatar.cc/150?img=4',
        rank: 4,
        score: 9350,
      ),
      LeaderboardEntry(
        userId: '5',
        name: 'David Brown',
        username: '@dbrown',
        avatarUrl: 'https://i.pravatar.cc/150?img=6',
        rank: 5,
        score: 9200,
      ),
      LeaderboardEntry(
        userId: '6',
        name: 'Emma Wilson',
        username: '@ewilson',
        avatarUrl: 'https://i.pravatar.cc/150?img=7',
        rank: 6,
        score: 9100,
      ),
      LeaderboardEntry(
        userId: '7',
        name: 'Michael Davis',
        username: '@mdavis',
        avatarUrl: 'https://i.pravatar.cc/150?img=8',
        rank: 7,
        score: 8950,
      ),
      LeaderboardEntry(
        userId: '8',
        name: 'Olivia Taylor',
        username: '@otaylor',
        avatarUrl: 'https://i.pravatar.cc/150?img=9',
        rank: 8,
        score: 8800,
      ),
      LeaderboardEntry(
        userId: '9',
        name: 'James Anderson',
        username: '@janderson',
        avatarUrl: 'https://i.pravatar.cc/150?img=10',
        rank: 9,
        score: 8650,
      ),
      LeaderboardEntry(
        userId: '10',
        name: 'Sophia Martinez',
        username: '@smartinez',
        avatarUrl: 'https://i.pravatar.cc/150?img=11',
        rank: 10,
        score: 8500,
      ),
    ];
  }

  // Dummy user
  static User getCurrentUser() {
    return User(
      id: '3',
      name: 'John Smith',
      username: '@johnsmith',
      email: 'john.smith@example.com',
      avatarUrl: 'https://i.pravatar.cc/150?img=3',
      level: 8,
      xp: 7850,
      xpToNextLevel: 10000,
      quizzesTaken: 42,
      correctAnswers: 378,
      badges: [
        AchievementBadge(
          id: '1',
          name: 'Science Master',
          iconName: 'science',
          color: '#1565C0',
          description: 'Completed 10 science quizzes',
        ),
        AchievementBadge(
          id: '2',
          name: 'History Buff',
          iconName: 'history_edu',
          color: '#FFA000',
          description: 'Answered 50 history questions correctly',
        ),
        AchievementBadge(
          id: '3',
          name: 'Quick Thinker',
          iconName: 'speed',
          color: '#C62828',
          description: 'Completed a quiz in under 2 minutes',
        ),
        AchievementBadge(id: '4', name: 'Perfect Score', iconName: 'star', color: '#6A1B9A', description: 'Got 100% on a quiz'),
        AchievementBadge(id: '5', name: 'Quiz Addict', iconName: 'psychology', color: '#2E7D32', description: 'Completed 25 quizzes'),
      ],
      recentActivity: [
        Activity(
          id: '1',
          type: 'quiz_completed',
          title: 'Science Trivia',
          subtitle: 'Score: 8/10',
          timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        ),
        Activity(id: '2', type: 'badge_earned', title: 'Perfect Score', timestamp: DateTime.now().subtract(const Duration(days: 1))),
        Activity(
          id: '3',
          type: 'quiz_completed',
          title: 'Geography Challenge',
          subtitle: 'Score: 10/10',
          timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
        ),
        Activity(id: '4', type: 'level_up', title: 'Level 8', timestamp: DateTime.now().subtract(const Duration(days: 2))),
        Activity(
          id: '5',
          type: 'quiz_completed',
          title: 'Movie Quotes',
          subtitle: 'Score: 7/10',
          timestamp: DateTime.now().subtract(const Duration(days: 3)),
        ),
      ],
    );
  }

 

  // Helper method to get icon data from string name
  static IconData getIconData(String iconName) {
    switch (iconName) {
      case 'science':
        return Icons.science;
      case 'history_edu':
        return Icons.history_edu;
      case 'public':
        return Icons.public;
      case 'sports_soccer':
        return Icons.sports_soccer;
      case 'movie':
        return Icons.movie;
      case 'music_note':
        return Icons.music_note;
      case 'computer':
        return Icons.computer;
      case 'palette':
        return Icons.palette;
      case 'speed':
        return Icons.speed;
      case 'star':
        return Icons.star;
      case 'psychology':
        return Icons.psychology;
      default:
        return Icons.help_outline;
    }
  }

  static Color getColorFromHex(String hexColor) {
    hexColor = hexColor.replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    return Color(int.parse(hexColor, radix: 16));
  }
}
