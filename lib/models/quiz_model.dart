class Quiz {
  final String id;
  final String title;
  final String category;
  final String description;
  final String imageUrl;
  final int questionCount;
  final int timeInMinutes;
  final int difficulty; // 1-5 scale
  final bool isFeatured;
  final List<Question> questions;

  Quiz({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.imageUrl,
    required this.questionCount,
    required this.timeInMinutes,
    required this.difficulty,
    this.isFeatured = false,
    required this.questions,
  });
}

class Question {
  final String id;
  final String text;
  final List<Option> options;
  final String correctOptionId;
  final String? explanation;

  Question({
    required this.id,
    required this.text,
    required this.options,
    required this.correctOptionId,
    this.explanation,
  });
}

class Option {
  final String id;
  final String text;

  Option({
    required this.id,
    required this.text,
  });
}

class Category {
  final String id;
  final String name;
  final String iconName;
  final String color;
  final int quizCount;

  Category({
    required this.id,
    required this.name,
    required this.iconName,
    required this.color,
    required this.quizCount,
  });
}

class User {
  final String id;
  final String name;
  final String username;
  final String email;
  final String avatarUrl;
  final int level;
  final int xp;
  final int xpToNextLevel;
  final int quizzesTaken;
  final int correctAnswers;
  final List<AchievementBadge> badges;
  final List<Activity> recentActivity;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.avatarUrl,
    required this.level,
    required this.xp,
    required this.xpToNextLevel,
    required this.quizzesTaken,
    required this.correctAnswers,
    required this.badges,
    required this.recentActivity,
  });
}

class AchievementBadge {
  final String id;
  final String name;
  final String iconName;
  final String color;
  final String description;

  AchievementBadge({
    required this.id,
    required this.name,
    required this.iconName,
    required this.color,
    required this.description,
  });
}

class Activity {
  final String id;
  final String type; // quiz_completed, badge_earned, level_up
  final String title;
  final String? subtitle;
  final DateTime timestamp;

  Activity({
    required this.id,
    required this.type,
    required this.title,
    this.subtitle,
    required this.timestamp,
  });
}

class LeaderboardEntry {
  final String userId;
  final String name;
  final String username;
  final String avatarUrl;
  final int rank;
  final int score;
  final bool isCurrentUser;

  LeaderboardEntry({
    required this.userId,
    required this.name,
    required this.username,
    required this.avatarUrl,
    required this.rank,
    required this.score,
    this.isCurrentUser = false,
  });
}