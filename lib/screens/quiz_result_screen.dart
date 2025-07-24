import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/quiz_model.dart';
import '../utils/dummy_data.dart';

class QuizResultScreen extends StatelessWidget {
  final Quiz quiz;
  final Map<String, String> userAnswers;
  final int timeSpent;
  final int correctAnswers;

  const QuizResultScreen({
    super.key,
    required this.quiz,
    required this.userAnswers,
    required this.timeSpent,
    required this.correctAnswers,
  });

  @override
  Widget build(BuildContext context) {
    final score = (correctAnswers / quiz.questions.length * 100).toInt();
    final isPassed = score >= 60; // Pass threshold is 60%
    final timeSpentMinutes = (timeSpent / 60).toStringAsFixed(1);
    
    // Calculate XP earned
    final baseXP = correctAnswers * 10;
    final timeBonus = quiz.timeInMinutes * 60 > timeSpent ? 20 : 0;
    final difficultyBonus = quiz.difficulty * 5;
    final totalXP = baseXP + timeBonus + difficultyBonus;
    
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      // Share results functionality would go here
                    },
                    icon: const Icon(Icons.share),
                    label: const Text('SHARE'),
                  ),
                ],
              ),
              
              const SizedBox(height: 16),
              
              // Result header
              Text(
                isPassed ? 'Congratulations!' : 'Better luck next time!',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'You scored $score%',
                style: TextStyle(
                  fontSize: 18,
                  color: isPassed ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              const SizedBox(height: 32),
              
              // Score chart
              SizedBox(
                height: 200,
                child: PieChart(
                  PieChartData(
                    sectionsSpace: 0,
                    centerSpaceRadius: 40,
                    sections: [
                      PieChartSectionData(
                        value: correctAnswers.toDouble(),
                        title: '$correctAnswers',
                        color: Colors.green,
                        radius: 60,
                        titleStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      PieChartSectionData(
                        value: (quiz.questions.length - correctAnswers).toDouble(),
                        title: '${quiz.questions.length - correctAnswers}',
                        color: Colors.red,
                        radius: 60,
                        titleStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Legend
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 16,
                        height: 16,
                        color: Colors.green,
                      ),
                      const SizedBox(width: 8),
                      const Text('Correct'),
                    ],
                  ),
                  const SizedBox(width: 24),
                  Row(
                    children: [
                      Container(
                        width: 16,
                        height: 16,
                        color: Colors.red,
                      ),
                      const SizedBox(width: 8),
                      const Text('Incorrect'),
                    ],
                  ),
                ],
              ),
              
              const SizedBox(height: 32),
              
              // Stats
              Container(
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
                    _buildStatRow('Time Spent', '$timeSpentMinutes minutes'),
                    const Divider(),
                    _buildStatRow('Correct Answers', '$correctAnswers/${quiz.questions.length}'),
                    const Divider(),
                    _buildStatRow('XP Earned', '+$totalXP XP'),
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        // Review answers functionality would go here
                        _showAnswersReview(context);
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: const BorderSide(color: Colors.deepPurple),
                      ),
                      child: const Text('REVIEW ANSWERS'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate back to home
                        Navigator.popUntil(context, (route) => route.isFirst);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('FINISH'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
  
  void _showAnswersReview(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.9,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          expand: false,
          builder: (context, scrollController) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Review Answers',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: quiz.questions.length,
                    itemBuilder: (context, index) {
                      final question = quiz.questions[index];
                      final userAnswer = userAnswers[question.id];
                      final isCorrect = userAnswer == question.correctOptionId;
                      
                      return Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isCorrect ? Colors.green : Colors.red,
                            width: 2,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: isCorrect
                                        ? Colors.green.withOpacity(0.2)
                                        : Colors.red.withOpacity(0.2),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    isCorrect ? Icons.check : Icons.close,
                                    color: isCorrect ? Colors.green : Colors.red,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    'Question ${index + 1}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              question.text,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Your Answer:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 8),
                            _buildAnswerRow(
                              question,
                              userAnswer,
                              isUserAnswer: true,
                            ),
                            if (!isCorrect) ...[
                              const SizedBox(height: 16),
                              const Text(
                                'Correct Answer:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 8),
                              _buildAnswerRow(
                                question,
                                question.correctOptionId,
                                isUserAnswer: false,
                              ),
                            ],
                            if (question.explanation != null) ...[
                              const SizedBox(height: 16),
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.blue.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Row(
                                      children: [
                                        Icon(
                                          Icons.info,
                                          color: Colors.blue,
                                          size: 16,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          'Explanation',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      question.explanation!,
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
  
  Widget _buildAnswerRow(Question question, String? optionId, {required bool isUserAnswer}) {
    if (optionId == null) {
      return const Text(
        'No answer selected',
        style: TextStyle(
          fontStyle: FontStyle.italic,
          color: Colors.grey,
        ),
      );
    }
    
    final option = question.options.firstWhere((o) => o.id == optionId);
    final isCorrect = optionId == question.correctOptionId;
    
    return Row(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: isUserAnswer
                ? (isCorrect ? Colors.green : Colors.red)
                : Colors.green,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              option.id,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            option.text,
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
        ),
      ],
    );
  }
}