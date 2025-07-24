import 'package:flutter/material.dart';
import '../utils/dummy_data.dart';
import 'quiz_screen.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // List of quiz categories with their icons and colors
    final categories = [
      {
        'name': 'Science',
        'icon': Icons.science,
        'color': Colors.blue,
        'quizCount': 12,
      },
      {
        'name': 'History',
        'icon': Icons.history_edu,
        'color': Colors.amber,
        'quizCount': 8,
      },
      {
        'name': 'Geography',
        'icon': Icons.public,
        'color': Colors.green,
        'quizCount': 10,
      },
      {
        'name': 'Sports',
        'icon': Icons.sports_soccer,
        'color': Colors.orange,
        'quizCount': 6,
      },
      {
        'name': 'Movies',
        'icon': Icons.movie,
        'color': Colors.red,
        'quizCount': 15,
      },
      {
        'name': 'Music',
        'icon': Icons.music_note,
        'color': Colors.purple,
        'quizCount': 9,
      },
      {
        'name': 'Technology',
        'icon': Icons.computer,
        'color': Colors.teal,
        'quizCount': 11,
      },
      {
        'name': 'Art',
        'icon': Icons.palette,
        'color': Colors.pink,
        'quizCount': 7,
      },
    ];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Categories',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Select a category to start a quiz',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 24),
              
              // Search bar
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search categories',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
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
                      name: category['name'] as String,
                      icon: category['icon'] as IconData,
                      color: category['color'] as Color,
                      quizCount: category['quizCount'] as int,
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
  final IconData icon;
  final Color color;
  final int quizCount;

  const CategoryCard({
    super.key,
    required this.name,
    required this.icon,
    required this.color,
    required this.quizCount,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(16),
      child: Container(
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 28,
                ),
              ),
              const Spacer(),
              Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '$quizCount Quizzes',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}