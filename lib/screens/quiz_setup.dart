import 'package:edu_quiz/screens/quiz_screen.dart';
import 'package:flutter/material.dart';

final Map<String, String> categories = {
  '9': 'General Knowledge',
  '10': 'Entertainment: Books',
  '11': 'Entertainment: Film',
  '12': 'Entertainment: Music',
  '13': 'Entertainment: Musicals & Theatres',
  '14': 'Entertainment: Television',
  '15': 'Entertainment: Video Games',
  '16': 'Entertainment: Board Games',
  '17': 'Science & Nature',
  '18': 'Science: Computers',
  '19': 'Science: Mathematics',
  '20': 'Mythology',
  '21': 'Sports',
  '22': 'Geography',
  '23': 'History',
  '24': 'Politics',
  '25': 'Art',
  '26': 'Celebrities',
  '27': 'Animals',
  '28': 'Vehicles',
  '29': 'Entertainment: Comics',
  '30': 'Science: Gadgets',
  '31': 'Entertainment: Japanese Anime & Manga',
  '32': 'Entertainment: Cartoon & Animations',
};

class QuizSetupScreen extends StatefulWidget {
  final int? amount;
  final String? category;

  const QuizSetupScreen({super.key, this.amount, this.category});

  @override
  State<QuizSetupScreen> createState() => _QuizSetupScreenState();
}

class _QuizSetupScreenState extends State<QuizSetupScreen> {
  int selectedAmount = 10;
  String? selectedCategory;
  String? selectedDifficulty;
  String? selectedType;

  @override
  void initState() {
    super.initState();
    selectedAmount = widget.amount ?? 10;
    selectedCategory = widget.category;
  }

  final Map<String, String> difficulties = {'easy': 'Easy', 'medium': 'Medium', 'hard': 'Hard'};

  final Map<String, String> types = {'multiple': 'Multiple Choice', 'boolean': 'True / False'};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quiz Setup'), backgroundColor: Colors.deepPurple, foregroundColor: Colors.white, elevation: 0),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.deepPurple, Colors.deepPurple.shade300],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Icon(Icons.quiz, size: 60, color: Colors.white),
                    SizedBox(height: 16),
                    Text('Customize Your Quiz', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                    SizedBox(height: 8),
                    Text(
                      'Select your preferences and start the challenge!',
                      style: TextStyle(fontSize: 16, color: Colors.white.withOpacity(0.9)),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Number of Questions
              _buildSectionTitle('Number of Questions'),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5))],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Questions: $selectedAmount', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        Text('Est. time: ${selectedAmount * 2} min', style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Slider(
                      value: selectedAmount.toDouble(),
                      min: 5,
                      max: 50,
                      divisions: 9,
                      activeColor: Colors.deepPurple,
                      onChanged: (value) {
                        setState(() {
                          selectedAmount = value.toInt();
                        });
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Category
              _buildSectionTitle('Category'),
              const SizedBox(height: 12),
              _buildDropdownCard(
                value: selectedCategory,
                hint: 'Any Category',
                items: categories,
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value;
                  });
                },
              ),

              const SizedBox(height: 24),

              // Difficulty
              _buildSectionTitle('Difficulty'),
              const SizedBox(height: 12),
              _buildDropdownCard(
                value: selectedDifficulty,
                hint: 'Any Difficulty',
                items: difficulties,
                onChanged: (value) {
                  setState(() {
                    selectedDifficulty = value;
                  });
                },
              ),

              const SizedBox(height: 24),

              // Type
              _buildSectionTitle('Question Type'),
              const SizedBox(height: 12),
              _buildDropdownCard(
                value: selectedType,
                hint: 'Any Type',
                items: types,
                onChanged: (value) {
                  setState(() {
                    selectedType = value;
                  });
                },
              ),

              const SizedBox(height: 40),

              // Start Quiz Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => QuizScreen(
                              amount: selectedAmount,
                              category: selectedCategory,
                              difficulty: selectedDifficulty,
                              type: selectedType,
                            ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 8,
                    shadowColor: Colors.deepPurple.withOpacity(0.3),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.play_arrow, size: 24),
                      SizedBox(width: 8),
                      Text('START QUIZ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87));
  }

  Widget _buildDropdownCard({
    required String? value,
    required String hint,
    required Map<String, String> items,
    required Function(String?) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5))],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,

          hint: Text(hint, style: TextStyle(color: Colors.grey[600])),
          isExpanded: true,
          icon: Icon(Icons.keyboard_arrow_down, color: Colors.deepPurple),
          items: [
            DropdownMenuItem<String>(value: selectedCategory, child: Text(hint, style: TextStyle(color: Colors.grey[600]))),
            ...items.entries.map((entry) {
              return DropdownMenuItem<String>(value: entry.key, child: Text(entry.value));
            }).toList(),
          ],
          onChanged: onChanged,
        ),
      ),
    );
  }
}
