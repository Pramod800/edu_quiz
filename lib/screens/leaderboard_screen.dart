import 'package:flutter/material.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy leaderboard data
    final leaderboardData = [
      {'rank': 1, 'name': 'Alex Johnson', 'score': 9850, 'avatar': 'https://i.pravatar.cc/150?img=1', 'isCurrentUser': false},
      {'rank': 2, 'name': 'Maria Garcia', 'score': 9720, 'avatar': 'https://i.pravatar.cc/150?img=5', 'isCurrentUser': false},
      {'rank': 3, 'name': 'John Smith', 'score': 9580, 'avatar': 'https://i.pravatar.cc/150?img=3', 'isCurrentUser': true},
      {'rank': 4, 'name': 'Sarah Williams', 'score': 9350, 'avatar': 'https://i.pravatar.cc/150?img=4', 'isCurrentUser': false},
      {'rank': 5, 'name': 'David Brown', 'score': 9200, 'avatar': 'https://i.pravatar.cc/150?img=6', 'isCurrentUser': false},
      {'rank': 6, 'name': 'Emma Wilson', 'score': 9100, 'avatar': 'https://i.pravatar.cc/150?img=7', 'isCurrentUser': false},
      {'rank': 7, 'name': 'Michael Davis', 'score': 8950, 'avatar': 'https://i.pravatar.cc/150?img=8', 'isCurrentUser': false},
      {'rank': 8, 'name': 'Olivia Taylor', 'score': 8800, 'avatar': 'https://i.pravatar.cc/150?img=9', 'isCurrentUser': false},
      {'rank': 9, 'name': 'James Anderson', 'score': 8650, 'avatar': 'https://i.pravatar.cc/150?img=10', 'isCurrentUser': false},
      {'rank': 10, 'name': 'Sophia Martinez', 'score': 8500, 'avatar': 'https://i.pravatar.cc/150?img=11', 'isCurrentUser': false},
    ];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Leaderboard', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text('See where you stand among other quizzers', style: TextStyle(fontSize: 16, color: Colors.grey)),
              const SizedBox(height: 24),

              SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _buildTopPlayer(
                      leaderboardData[1]['rank'] as int,
                      leaderboardData[1]['name'] as String,
                      leaderboardData[1]['score'] as int,
                      leaderboardData[1]['avatar'] as String,
                      Colors.grey[300]!,
                      120,
                    ),

                    const SizedBox(width: 16),

                    _buildTopPlayer(
                      leaderboardData[0]['rank'] as int,
                      leaderboardData[0]['name'] as String,
                      leaderboardData[0]['score'] as int,
                      leaderboardData[0]['avatar'] as String,
                      Colors.amber,
                      150,
                    ),

                    const SizedBox(width: 16),

                    // 3rd place
                    _buildTopPlayer(
                      leaderboardData[2]['rank'] as int,
                      leaderboardData[2]['name'] as String,
                      leaderboardData[2]['score'] as int,
                      leaderboardData[2]['avatar'] as String,
                      Colors.brown[300]!,
                      100,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Leaderboard list
              Expanded(
                child: ListView.builder(
                  itemCount: leaderboardData.length,
                  itemBuilder: (context, index) {
                    final player = leaderboardData[index];
                    return LeaderboardItem(
                      rank: player['rank'] as int,
                      name: player['name'] as String,
                      score: player['score'] as int,
                      avatar: player['avatar'] as String,
                      isCurrentUser: player['isCurrentUser'] as bool,
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

  Widget _buildTopPlayer(int rank, String name, int score, String avatar, Color color, double height) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CircleAvatar(radius: 30, backgroundColor: color, child: CircleAvatar(radius: 28, backgroundImage: NetworkImage(avatar))),
        // const SizedBox(height: 8),
        Container(
          width: 80,
          height: height,
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('#$rank', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 4),
              Text(name.split(' ')[0], style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12), overflow: TextOverflow.ellipsis),
              const SizedBox(height: 4),
              Text(score.toString(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            ],
          ),
        ),
      ],
    );
  }
}

class LeaderboardItem extends StatelessWidget {
  final int rank;
  final String name;
  final int score;
  final String avatar;
  final bool isCurrentUser;

  const LeaderboardItem({
    super.key,
    required this.rank,
    required this.name,
    required this.score,
    required this.avatar,
    required this.isCurrentUser,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isCurrentUser ? Colors.blue.withOpacity(0.1) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: isCurrentUser ? Border.all(color: Colors.blue, width: 1) : null,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5))],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(width: 24, child: Text('#$rank', style: TextStyle(fontWeight: FontWeight.bold, color: _getRankColor(rank)))),
            const SizedBox(width: 12),
            CircleAvatar(backgroundImage: NetworkImage(avatar)),
          ],
        ),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(20)),
          child: Text(score.toString(), style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87)),
        ),
      ),
    );
  }

  Color _getRankColor(int rank) {
    if (rank == 1) return Colors.amber;
    if (rank == 2) return Colors.grey[400]!;
    if (rank == 3) return Colors.brown[300]!;
    return Colors.black87;
  }
}
