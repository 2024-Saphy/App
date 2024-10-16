import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageProviderModel with ChangeNotifier {
  final List<XFile> _images = [];

  List<XFile> get images => _images;

  Future<void> addImage(XFile image) async {
    _images.add(image);
    notifyListeners(); // 상태가 변경되었음을 알림
  }

  void removeImage(int index) {
    _images.removeAt(index);
    notifyListeners();
  }

  void clearImages() {
    _images.clear();
    notifyListeners();
  }
}
