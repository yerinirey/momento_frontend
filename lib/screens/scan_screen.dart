// lib/screens/scan_screen.dart

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:provider/provider.dart';

import '../providers/image_store.dart';
import '../providers/moment_store.dart';
import 'confirm_scan_screen.dart';
import 'moments_screen.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  late CameraController _controller;
  late Future<void> _initFuture;
  bool _isCapturing = false;

  final List<String> _labels = [
    'Front View',
    'Back View',
    'Left Side',
    'Right Side',
    'Top View',
    'Bottom View',
  ];

  @override
  void initState() {
    super.initState();
    _initFuture = _setupCamera();
  }

  Future<void> _setupCamera() async {
    final cameras = await availableCameras();
    final camera = cameras.firstWhere(
      (c) => c.lensDirection == CameraLensDirection.back,
      orElse: () => cameras.first,
    );
    _controller = CameraController(
      camera,
      ResolutionPreset.high,
      enableAudio: false,
    );
    await _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _takePhoto() async {
    final imageStore = context.read<ImageStore>();
    if (_isCapturing || imageStore.images.length >= _labels.length) return;

    setState(() => _isCapturing = true);
    try {
      final photo = await _controller.takePicture();
      imageStore.addImage(photo.path);
    } catch (e) {
      debugPrint('사진 촬영 에러: $e');
    } finally {
      setState(() => _isCapturing = false);
    }
  }

  void _goBackStep() {
    final imageStore = context.read<ImageStore>();
    imageStore.removeLast();
  }

  Future<void> _completeScan() async {
    final imageStore = context.read<ImageStore>();
    final momentStore = context.read<MomentStore>();
    final images = imageStore.images;
    if (images.isEmpty) return;

    // 확인버튼 눌렀을 때 ConfirmScanScreen으로 이동
    final confirmed = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (_) => ConfirmScanScreen(imagePaths: images),
      ),
    );
    if (confirmed != true) {
      // 1. 다시 찍기
      return;
    }

    // 2. 확인
    // 첫 번째 사진을 대표 이미지로 삼아 MomentsScreen에 모델 생성중 아이템 추가
    momentStore.addMoment(images.first);
    // 스캔 데이터 초기화
    imageStore.clear();

    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const MomentsScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final total = _labels.length;

    return FutureBuilder<void>(
      future: _initFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final captured = context.watch<ImageStore>().images.length;

        return Scaffold(
          body: Stack(
            children: [
              CameraPreview(_controller),

              // 상단 안내 텍스트
              Positioned(
                top: 48,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    color: Colors.black54,
                    child: Text(
                      'Please scan: ${_labels[min(captured, total - 1)]}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

              // progress 바
              Positioned(
                bottom: 120,
                left: 16,
                right: 16,
                child: Column(
                  children: [
                    LinearProgressIndicator(
                      value: captured / total,
                      backgroundColor: Colors.white24,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Colors.lightBlueAccent,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '$captured / $total captured',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),

              // 버튼
              Positioned(
                bottom: 48,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // 1. 뒤로가기버튼: 사진 재촬영
                    FloatingActionButton(
                      heroTag: 'backBtn',
                      onPressed: captured > 0 ? _goBackStep : null,
                      backgroundColor:
                          captured > 0 ? Colors.orange : Colors.grey,
                      child: const Icon(Icons.arrow_back),
                    ),
                    // 2. 촬영버튼 / (6장 전부 찍었을 때) 완료버튼
                    if (captured < total) ...[
                      FloatingActionButton(
                        heroTag: 'captureBtn',
                        onPressed: _takePhoto,
                        backgroundColor:
                            _isCapturing ? Colors.grey : Colors.blueAccent,
                        child: _isCapturing
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Icon(Icons.camera_alt),
                      ),
                    ] else ...[
                      FloatingActionButton(
                        heroTag: 'doneBtn',
                        onPressed: _completeScan,
                        backgroundColor: Colors.green,
                        child: const Icon(Icons.check),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
