// ScanScreen에서 촬영 진행중인 6장에 대한 저장소
import 'package:flutter/foundation.dart';

class ImageStore extends ChangeNotifier {
  final List<String> _images = [];
  List<String> get images => List.unmodifiable(_images);

  void addImage(String path) {
    _images.add(path);
    notifyListeners();
  }

  void removeLast() {
    if (_images.isNotEmpty) {
      _images.removeLast();
      notifyListeners();
    }
  }

  void clear() {
    _images.clear();
    notifyListeners();
  }
}
