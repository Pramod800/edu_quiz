import 'package:edu_quiz/core/network/dio_client.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import '../models/quiz_model.dart';
import '../utils/dummy_data.dart';
import 'quiz_result_screen.dart';

class QuizScreen extends StatefulWidget {
  final int amount;
  final String? category;
  final String? difficulty;
  final String? type;

  const QuizScreen({super.key, required this.amount, this.category, this.difficulty, this.type});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  Quiz? quiz;
  int currentQuestionIndex = 0;
  int timeRemaining = 0;
  Timer? timer;
  Map<String, String> userAnswers = {};
  bool isAnswerSelected = false;
  String? selectedOptionId;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    loadQuizQuestions();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future<void> loadQuizQuestions() async {
    try {
      setState(() {
        isLoading = true;
        errorMessage = null;
      });

      final apiService = QuizApiService();
      final questionsData = await apiService.fetchQuestions(
        amount: widget.amount,
        category: widget.category,
        difficulty: widget.difficulty,
        type: widget.type,
      );

      // Convert API data to Quiz model
      final questions =
          questionsData.map<Question>((questionData) {
            final List<String> allAnswers = [...List<String>.from(questionData['incorrect_answers']), questionData['correct_answer']];
            allAnswers.shuffle(); // Randomize answer order

            final options =
                allAnswers.asMap().entries.map((entry) {
                  return Option(
                    id: String.fromCharCode(65 + entry.key), // A, B, C, D
                    text: _decodeHtml(entry.value),
                  );
                }).toList();

            final correctOptionId = options.firstWhere((option) => option.text == _decodeHtml(questionData['correct_answer'])).id;

            return Question(
              id: 'q_${questionsData.indexOf(questionData)}',
              text: _decodeHtml(questionData['question']),
              options: options,
              correctOptionId: correctOptionId,
              explanation: null, // API doesn't provide explanations
            );
          }).toList();

      // Create quiz object
      quiz = Quiz(
        id: 'trivia_quiz',
        title: 'Trivia Quiz',
        description: 'Test your knowledge!',
        questions: questions,
        timeInMinutes: widget.amount * 2, 
        difficulty: _getDifficultyLevel(widget.difficulty),
      );

      // Set timer
      timeRemaining = quiz!.timeInMinutes * 60;
      startTimer();

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Failed to load quiz questions: ${e.toString()}';
      });
    }
  }

  String _decodeHtml(String text) {
    return text
        .replaceAll('&quot;', '"')
        .replaceAll('&#039;', "'")
        .replaceAll('&amp;', '&')
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>')
        .replaceAll('&rsquo;', "'")
        .replaceAll('&ldquo;', '"')
        .replaceAll('&rdquo;', '"');
  }

  int _getDifficultyLevel(String? difficulty) {
    switch (difficulty?.toLowerCase()) {
      case 'easy':
        return 1;
      case 'medium':
        return 2;
      case 'hard':
        return 3;
      default:
        return 2;
    }
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeRemaining > 0) {
        setState(() {
          timeRemaining--;
        });
      } else {
        // Time's up, submit quiz
        submitQuiz();
      }
    });
  }

  void selectOption(String optionId) {
    if (!isAnswerSelected) {
      setState(() {
        selectedOptionId = optionId;
        isAnswerSelected = true;
        userAnswers[quiz!.questions[currentQuestionIndex].id] = optionId;
      });

      // Wait for a moment to show the selected answer before moving to next question
      Future.delayed(const Duration(milliseconds: 1500), () {
        if (currentQuestionIndex < quiz!.questions.length - 1) {
          setState(() {
            currentQuestionIndex++;
            isAnswerSelected = false;
            selectedOptionId = null;
          });
        } else {
          // Last question, submit quiz
          submitQuiz();
        }
      });
    }
  }

  void submitQuiz() {
    timer?.cancel();

    // Calculate score
    int correctAnswers = 0;
    userAnswers.forEach((questionId, selectedOptionId) {
      final question = quiz!.questions.firstWhere((q) => q.id == questionId);
      if (question.correctOptionId == selectedOptionId) {
        correctAnswers++;
      }
    });

    // Navigate to results screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder:
            (context) => QuizResultScreen(
              quiz: quiz!,
              userAnswers: userAnswers,
              timeSpent: (quiz!.timeInMinutes * 60) - timeRemaining,
              correctAnswers: correctAnswers,
            ),
      ),
    );
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple)),
              SizedBox(height: 16),
              Text('Loading quiz questions...', style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      );
    }

    if (errorMessage != null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 64, color: Colors.red),
              SizedBox(height: 16),
              Text('Oops! Something went wrong', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Text(errorMessage!, textAlign: TextAlign.center, style: TextStyle(color: Colors.grey[600])),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  loadQuizQuestions();
                },
                child: Text('Retry'),
              ),
              SizedBox(height: 8),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Go Back'),
              ),
            ],
          ),
        ),
      );
    }

    if (quiz == null) {
      return Scaffold(body: Center(child: Text('No quiz data available')));
    }

    final currentQuestion = quiz!.questions[currentQuestionIndex];
    final questionNumber = currentQuestionIndex + 1;
    final totalQuestions = quiz!.questions.length;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Quiz header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder:
                            (context) => AlertDialog(
                              title: const Text('Quit Quiz?'),
                              content: const Text('Are you sure you want to quit? Your progress will be lost.'),
                              actions: [
                                TextButton(onPressed: () => Navigator.pop(context), child: const Text('CANCEL')),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  },
                                  child: const Text('QUIT'),
                                ),
                              ],
                            ),
                      );
                    },
                    icon: const Icon(Icons.close),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(color: Colors.deepPurple.shade50, borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      children: [
                        const Icon(Icons.timer, color: Colors.deepPurple, size: 18),
                        const SizedBox(width: 4),
                        Text(formatTime(timeRemaining), style: const TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Progress indicator
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Question $questionNumber/$totalQuestions', style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text(
                        '${(questionNumber / totalQuestions * 100).toInt()}%',
                        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurple),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: questionNumber / totalQuestions,
                    backgroundColor: Colors.grey[300],
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.deepPurple),
                    borderRadius: BorderRadius.circular(10),
                    minHeight: 8,
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // Question
              Text(currentQuestion.text, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),

              const SizedBox(height: 24),

              // Options
              Expanded(
                child: ListView.builder(
                  itemCount: currentQuestion.options.length,
                  itemBuilder: (context, index) {
                    final option = currentQuestion.options[index];
                    final isSelected = selectedOptionId == option.id;
                    final isCorrect = isAnswerSelected && option.id == currentQuestion.correctOptionId;
                    final isWrong = isAnswerSelected && isSelected && option.id != currentQuestion.correctOptionId;

                    Color backgroundColor;
                    Color borderColor;

                    if (isSelected) {
                      if (isAnswerSelected) {
                        backgroundColor = isCorrect ? Colors.green.shade50 : Colors.red.shade50;
                        borderColor = isCorrect ? Colors.green : Colors.red;
                      } else {
                        backgroundColor = Colors.deepPurple.shade50;
                        borderColor = Colors.deepPurple;
                      }
                    } else if (isAnswerSelected && option.id == currentQuestion.correctOptionId) {
                      backgroundColor = Colors.green.shade50;
                      borderColor = Colors.green;
                    } else {
                      backgroundColor = Colors.white;
                      borderColor = Colors.grey.shade300;
                    }

                    return GestureDetector(
                      onTap: () => selectOption(option.id),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: backgroundColor,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: borderColor, width: 2),
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5))],
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(color: isSelected ? borderColor : Colors.grey.shade200, shape: BoxShape.circle),
                              child: Center(
                                child: Text(
                                  option.id,
                                  style: TextStyle(color: isSelected ? Colors.white : Colors.black, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                option.text,
                                style: TextStyle(fontSize: 16, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal),
                              ),
                            ),
                            if (isAnswerSelected)
                              Icon(
                                isCorrect ? Icons.check_circle : (isWrong ? Icons.cancel : null),
                                color: isCorrect ? Colors.green : (isWrong ? Colors.red : null),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Skip button
              if (!isAnswerSelected)
                Center(
                  child: TextButton(
                    onPressed: () {
                      if (currentQuestionIndex < quiz!.questions.length - 1) {
                        setState(() {
                          currentQuestionIndex++;
                        });
                      } else {
                        submitQuiz();
                      }
                    },
                    child: const Text('SKIP'),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
