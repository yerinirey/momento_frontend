import 'package:flutter/material.dart';

class MyMomentoScreen extends StatelessWidget {
  const MyMomentoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'My Momento',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'My Momento',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),

            // 카테고리1: Favorites, 위젯화 예정
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Favorites',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                Row(
                  children: [
                    Text('See all',
                        style:
                            TextStyle(fontSize: 16, color: Colors.blueAccent)),
                    SizedBox(width: 4),
                    Icon(
                      Icons.chevron_right_outlined,
                      size: 20,
                      color: Colors.blueAccent,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 16,
              childAspectRatio: 0.85,
              children: List.generate(2, (_) => _placeholderCard()),
            ),

            const SizedBox(height: 32),

            // 카테고리2: Travel
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Travel',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                Row(
                  children: [
                    Text('See all',
                        style:
                            TextStyle(fontSize: 16, color: Colors.blueAccent)),
                    SizedBox(width: 4),
                    Icon(
                      Icons.chevron_right_outlined,
                      size: 20,
                      color: Colors.blueAccent,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 16,
              childAspectRatio: 0.85,
              children: List.generate(2, (_) => _placeholderCard()),
            ),

            const SizedBox(height: 32),

            // 카테고리3: School
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('School',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                Row(
                  children: [
                    Text('See all',
                        style:
                            TextStyle(fontSize: 16, color: Colors.blueAccent)),
                    SizedBox(width: 4),
                    Icon(
                      Icons.chevron_right_outlined,
                      size: 20,
                      color: Colors.blueAccent,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 16,
              childAspectRatio: 0.85,
              children: List.generate(2, (_) => _placeholderCard()),
            ),
          ],
        ),
      ),
    );
  }

  /// Simple grey placeholder card used for both favorites & travel items.
  Widget _placeholderCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
              ),
              child: const Center(
                child: Icon(Icons.image_outlined, size: 48, color: Colors.grey),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 16,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  height: 12,
                  width: 80,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
