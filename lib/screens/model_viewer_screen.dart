import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class ModelViewerScreen extends StatelessWidget {
  final String modelPath;
  const ModelViewerScreen({super.key, required this.modelPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('3D 모델 뷰어 - model_viewer_plus')),
      body: Center(
        child: ModelViewer(
          src: modelPath,
          alt: "3D Model",
          autoRotate: true,
          cameraControls: true,
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
