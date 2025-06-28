import 'package:flutter/foundation.dart';

/// confirm 시 생성중인 모델 나타내기: 현재 시점에 db가 없기 때문에 화면상으로 아이템 리스트업만 가능하도록..
class Moment {
  final String imagePath;
  String status;

  Moment({required this.imagePath, this.status = '생성중..'});
}

class MomentStore extends ChangeNotifier {
  final List<Moment> _moments = [];

  /// 읽기 전용으로 접근 가능
  List<Moment> get moments => List.unmodifiable(_moments);

  void addMoment(String imagePath) {
    _moments.add(Moment(imagePath: imagePath));
    notifyListeners();
  }

  void updateStatus(int index, String newStatus) {
    if (index < 0 || index >= _moments.length) return;
    _moments[index].status = newStatus;
    notifyListeners();
  }

  // /// 마지막 Moment 제거
  // void removeLast() {
  //   if (_moments.isNotEmpty) {
  //     _moments.removeLast();
  //     notifyListeners();
  //   }
  // }

  // /// 전체 Moment 초기화
  // void clear() {
  //   _moments.clear();
  //   notifyListeners();
  // }
}
