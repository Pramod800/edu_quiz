import 'package:flutter/material.dart';

class Quiz {
  final String id;
  final String title;
  final String description;
  final List<Question> questions;
  final int timeInMinutes;
  final int difficulty;

  Quiz({
    required this.id,
    required this.title,
    required this.description,
    required this.questions,
    required this.timeInMinutes,
    required this.difficulty,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      questions: (json['questions'] as List<dynamic>?)
              ?.map((q) => Question.fromJson(q))
              .toList() ??
          [],
      timeInMinutes: json['timeInMinutes'] ?? 30,
      difficulty: json['difficulty'] ?? 2,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'questions': questions.map((q) => q.toJson()).toList(),
      'timeInMinutes': timeInMinutes,
      'difficulty': difficulty,
    };
  }
}

class CategoryQuiz {
  final String title;
  final int? questionCount;
  final int? timeInMinutes;
  final IconData? icon;
  final Color? color;

  CategoryQuiz(this.icon, this.color, {required this.title, this.questionCount = 10, this.timeInMinutes = 5});
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

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'] ?? '',
      text: json['text'] ?? '',
      options: (json['options'] as List<dynamic>?)
              ?.map((o) => Option.fromJson(o))
              .toList() ??
          [],
      correctOptionId: json['correctOptionId'] ?? '',
      explanation: json['explanation'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'options': options.map((o) => o.toJson()).toList(),
      'correctOptionId': correctOptionId,
      'explanation': explanation,
    };
  }
}

class Option {
  final String id;
  final String text;

  Option({
    required this.id,
    required this.text,
  });

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      id: json['id'] ?? '',
      text: json['text'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
    };
  }
}

// Quiz Statistics Model
class QuizStats {
  final int totalQuizzes;
  final int completedQuizzes;
  final double averageScore;
  final int totalXP;
  final String rank;

  QuizStats({
    required this.totalQuizzes,
    required this.completedQuizzes,
    required this.averageScore,
    required this.totalXP,
    required this.rank,
  });

  factory QuizStats.fromJson(Map<String, dynamic> json) {
    return QuizStats(
      totalQuizzes: json['totalQuizzes'] ?? 0,
      completedQuizzes: json['completedQuizzes'] ?? 0,
      averageScore: (json['averageScore'] ?? 0.0).toDouble(),
      totalXP: json['totalXP'] ?? 0,
      rank: json['rank'] ?? 'Beginner',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalQuizzes': totalQuizzes,
      'completedQuizzes': completedQuizzes,
      'averageScore': averageScore,
      'totalXP': totalXP,
      'rank': rank,
    };
  }
}

// Quiz Result Model
class QuizResult {
  final String quizId;
  final String quizTitle;
  final int totalQuestions;
  final int correctAnswers;
  final int timeSpent;
  final double scorePercentage;
  final int xpEarned;
  final DateTime completedAt;
  final Map<String, String> userAnswers;

  QuizResult({
    required this.quizId,
    required this.quizTitle,
    required this.totalQuestions,
    required this.correctAnswers,
    required this.timeSpent,
    required this.scorePercentage,
    required this.xpEarned,
    required this.completedAt,
    required this.userAnswers,
  });

  factory QuizResult.fromJson(Map<String, dynamic> json) {
    return QuizResult(
      quizId: json['quizId'] ?? '',
      quizTitle: json['quizTitle'] ?? '',    
      totalQuestions: json['totalQuestions'] ?? 0,
      correctAnswers: json['correctAnswers'] ?? 0,
      timeSpent: json['timeSpent'] ?? 0,    
      scorePercentage: (json['scorePercentage'] ?? 0.0).toDouble(),
      xpEarned: json['xpEarned'] ?? 0,
      completedAt: json['completedAt'] != null ? DateTime.parse(json['completedAt']) : DateTime.now(),
      userAnswers: Map<String, String>.from(json['userAnswers'] ?? {}),
    );    
  }
}

// class Question {
//   final String id;
//   final String text;
//   final List<Option> options;
//   final String correctOptionId;
//   final String? explanation;

//   Question({required this.id, required this.text, required this.options, required this.correctOptionId, this.explanation});
// }

// class Option {
//   final String id;
//   final String text;

//   Option({required this.id, required this.text});
// }

class Category {
  final String id;
  final String name;
  final String iconName;
  final String color;
  final int quizCount;

  Category({required this.id, required this.name, required this.iconName, required this.color, required this.quizCount});
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

  AchievementBadge({required this.id, required this.name, required this.iconName, required this.color, required this.description});
}

class Activity {
  final String id;
  final String type; // quiz_completed, badge_earned, level_up
  final String title;
  final String? subtitle;
  final DateTime timestamp;

  Activity({required this.id, required this.type, required this.title, this.subtitle, required this.timestamp});
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
