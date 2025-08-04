import 'package:edu_quiz/models/quiz_model.dart';
import 'package:edu_quiz/screens/quiz_setup.dart';
import 'package:flutter/material.dart';
import '../utils/dummy_data.dart';
import 'quiz_screen.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<CategoryQuiz> categories = [
      CategoryQuiz(Icons.science, Colors.blue, title: 'Science', questionCount: 12),
      CategoryQuiz(Icons.history_edu, Colors.amber, title: 'History', questionCount: 8),
      CategoryQuiz(Icons.public, Colors.green, title: 'Geography', questionCount: 10),
      CategoryQuiz(Icons.sports_soccer, Colors.orange, title: 'Sports', questionCount: 6),
      CategoryQuiz(Icons.movie, Colors.red, title: 'Movies', questionCount: 15),
      CategoryQuiz(Icons.music_note, Colors.purple, title: 'Music', questionCount: 9),
      CategoryQuiz(Icons.computer, Colors.teal, title: 'Technology', questionCount: 11),
      CategoryQuiz(Icons.palette, Colors.pink, title: 'Art', questionCount: 7),
    ];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Categories', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text('Select a category to start a quiz', style: TextStyle(fontSize: 16, color: Colors.grey)),
              const SizedBox(height: 24),

              // Search bar
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search categories',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
                  filled: true,
                  fillColor: Colors.grey[200],
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                ),
              ),

              const SizedBox(height: 24),

              // Categories grid
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.1,
                  ),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return CategoryCard(
                      name: category.title,
                      icon: category.icon,
                      color: category.color,
                      quizCount: category.questionCount,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String name;
  final IconData? icon;
  final Color? color;
  final int? quizCount;

  const CategoryCard({super.key, required this.name, this.icon, required this.color, required this.quizCount});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => QuizSetupScreen()));
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5))],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: color?.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(12)),
                child: Icon(icon, color: color, size: 28),
              ),
              const Spacer(),
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 4),
              Text('$quizCount Quizzes', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }
}
