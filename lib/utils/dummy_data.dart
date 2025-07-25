import 'package:flutter/material.dart';
import '../models/quiz_model.dart' hide Badge;

class DummyData {
  static List<Quiz> getQuizzes() {
    return [
      Quiz(
        id: '1',
        title: 'Science Trivia',
        category: 'Science',
        description: 'Test your knowledge of basic science concepts and discoveries.',
        imageUrl: 'assets/images/science.jpg',
        questionCount: 10,
        timeInMinutes: 5,
        difficulty: 3,
        isFeatured: true,
        questions: _getScienceQuestions(),
      ),
      Quiz(
        id: '2',
        title: 'History Facts',
        category: 'History',
        description: 'Journey through time with these historical questions.',
        imageUrl: 'assets/images/history.jpg',
        questionCount: 10,
        timeInMinutes: 5,
        difficulty: 2,
        questions: _getHistoryQuestions(),
      ),
      Quiz(
        id: '3',
        title: 'Geography Challenge',
        category: 'Geography',
        description: 'Test your knowledge of countries, capitals, and landmarks.',
        imageUrl: 'assets/images/geography.jpg',
        questionCount: 10,
        timeInMinutes: 5,
        difficulty: 3,
        questions: _getGeographyQuestions(),
      ),
      Quiz(
        id: '4',
        title: 'Movie Quotes',
        category: 'Movies',
        description: 'Can you identify these famous movie quotes?',
        imageUrl: 'assets/images/movies.jpg',
        questionCount: 10,
        timeInMinutes: 5,
        difficulty: 2,
        questions: [],
      ),
      Quiz(
        id: '5',
        title: 'Music Legends',
        category: 'Music',
        description: 'Test your knowledge of music history and famous artists.',
        imageUrl: 'assets/images/music.jpg',
        questionCount: 10,
        timeInMinutes: 5,
        difficulty: 3,
        questions: [],
      ),
    ];
  }

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

  // Sample questions for Science quiz
  static List<Question> _getScienceQuestions() {
    return [
      Question(
        id: '1',
        text: 'What is the chemical symbol for gold?',
        options: [Option(id: 'A', text: 'Au'), Option(id: 'B', text: 'Ag'), Option(id: 'C', text: 'Fe'), Option(id: 'D', text: 'Gd')],
        correctOptionId: 'A',
        explanation: 'The chemical symbol for gold is Au, which comes from the Latin word "aurum".',
      ),
      Question(
        id: '2',
        text: 'Which planet is known as the Red Planet?',
        options: [
          Option(id: 'A', text: 'Venus'),
          Option(id: 'B', text: 'Mars'),
          Option(id: 'C', text: 'Jupiter'),
          Option(id: 'D', text: 'Saturn'),
        ],
        correctOptionId: 'B',
        explanation: 'Mars is known as the Red Planet due to the reddish appearance given by iron oxide (rust) on its surface.',
      ),
      // Add more questions as needed
    ];
  }

  // Sample questions for History quiz
  static List<Question> _getHistoryQuestions() {
    return [
      Question(
        id: '1',
        text: 'In which year did World War II end?',
        options: [
          Option(id: 'A', text: '1943'),
          Option(id: 'B', text: '1944'),
          Option(id: 'C', text: '1945'),
          Option(id: 'D', text: '1946'),
        ],
        correctOptionId: 'C',
        explanation: 'World War II ended in 1945 with the surrender of Germany in May and Japan in September.',
      ),
      Question(
        id: '2',
        text: 'Who was the first President of the United States?',
        options: [
          Option(id: 'A', text: 'Thomas Jefferson'),
          Option(id: 'B', text: 'George Washington'),
          Option(id: 'C', text: 'John Adams'),
          Option(id: 'D', text: 'Benjamin Franklin'),
        ],
        correctOptionId: 'B',
        explanation: 'George Washington was the first President of the United States, serving from 1789 to 1797.',
      ),
      // Add more questions as needed
    ];
  }

  static List<Question> _getGeographyQuestions() {
    return [
      Question(
        id: '1',
        text: 'What is the name of the longest river in Africa?',
        options: [
          Option(id: 'A', text: 'Nile'),
          Option(id: 'B', text: 'Amazon'),
          Option(id: 'C', text: 'Yangtze'),
          Option(id: 'D', text: 'Mississippi'),
        ],
        correctOptionId: 'A',
        explanation: 'The Nile is the longest river in Africa, flowing through several countries including Uganda, Sudan, and Egypt.',
      ),
      Question(
        id: '2',
        text: 'Where is the Eiffel Tower located?',
        options: [
          Option(id: 'A', text: 'Paris'),
          Option(id: 'B', text: 'London'),
          Option(id: 'C', text: 'Berlin'),
          Option(id: 'D', text: 'Madrid'),
        ],
        correctOptionId: 'A',
        explanation: 'The Eiffel Tower is located in Paris, France.',
      ),

      Question(
        id: '3',
        text: 'What country are the Great Pyramids of Giza located in?',
        options: [
          Option(id: 'A', text: 'Egypt'),
          Option(id: 'B', text: 'Mexico'),
          Option(id: 'C', text: 'Greece'),
          Option(id: 'D', text: 'Italy'),
        ],
        correctOptionId: 'A',
        explanation: 'The Great Pyramids of Giza are located in Egypt.',
      ),
      // Add more questions as needed
    ];
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
