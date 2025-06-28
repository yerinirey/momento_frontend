import 'package:flutter/material.dart';
import 'package:momento/screens/model_viewer_screen.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<List<String>> _loadModelPaths() async {
    final manifest = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifest);

    return manifestMap.keys
        .where((path) =>
            path.startsWith('assets/models/') && path.endsWith('.glb'))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Home',
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
            // 카테고리0: 임시 모델파일로 테스트
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Model TestField',
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

            FutureBuilder<List<String>>(
              future: _loadModelPaths(),
              builder: (context, snap) {
                if (snap.connectionState != ConnectionState.done) {
                  return const Center(child: CircularProgressIndicator());
                }
                final models = snap.data ?? [];
                if (models.isEmpty) {
                  return const Center(child: Text('모델이 없습니다.'));
                }
                return GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.85,
                  children:
                      models.map((mp) => _modelCard(context, mp)).toList(),
                );
              },
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

  Widget _modelCard(BuildContext context, String modelPath) {
    final baseName = modelPath.split('/').last.replaceAll('.glb', '');
    final thumb = 'assets/thumbnails/$baseName.png';

    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => ModelViewerScreen(modelPath: modelPath),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.asset(
                  thumb,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                baseName.toUpperCase(),
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
