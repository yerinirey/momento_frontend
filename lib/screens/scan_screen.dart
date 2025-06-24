import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  final ImagePicker _picker = ImagePicker();
  final List<File> _capturedImages = [];
  String _objectName = '';

  final List<String> _angleLabels = [
    'Front View',
    'Back View',
    'Left Side',
    'Right Side',
    'Top View',
    'Bottom View'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Scan Object',
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
            const Text('Object Name',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            TextField(
              onChanged: (value) => setState(() => _objectName = value),
              decoration: InputDecoration(
                hintText: 'Enter object name...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.blue),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _showImageSourceDialog,
                    icon: const Icon(Icons.camera_alt),
                    label: const Text('Take Photos'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _pickFromGallery,
                    icon: const Icon(Icons.photo_library, color: Colors.blue),
                    label: const Text('From Gallery'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: const BorderSide(color: Colors.blue),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            if (_capturedImages.isNotEmpty) ...[
              const SizedBox(height: 24),
              Row(
                children: [
                  const Text('Captured Images',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                  const Spacer(),
                  Text('${_capturedImages.length}/6'),
                ],
              ),
              const SizedBox(height: 8),
              LinearProgressIndicator(
                value: _capturedImages.length / 6,
                backgroundColor: Colors.grey[300],
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
              const SizedBox(height: 16),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1,
                ),
                itemCount: 6,
                itemBuilder: (context, index) => _buildImageSlot(index),
              ),
              const SizedBox(height: 24),
              _buildTipsSection(),
            ]
          ],
        ),
      ),
    );
  }

  Widget _buildImageSlot(int index) {
    bool hasImage = index < _capturedImages.length;
    String angleLabel =
        index < _angleLabels.length ? _angleLabels[index] : 'Extra View';

    return Container(
      decoration: BoxDecoration(
        color: hasImage ? Colors.transparent : Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: hasImage ? Colors.blue : Colors.grey[300]!,
          width: hasImage ? 2 : 1,
        ),
      ),
      child: hasImage
          ? Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(_capturedImages[index], fit: BoxFit.cover),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    color: Colors.black.withOpacity(0.7),
                    child: Text(
                      angleLabel,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () =>
                        setState(() => _capturedImages.removeAt(index)),
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.close,
                          size: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add_a_photo, color: Colors.grey[400], size: 32),
                const SizedBox(height: 8),
                Text(angleLabel,
                    style: TextStyle(color: Colors.grey[600], fontSize: 12)),
              ],
            ),
    );
  }

  Widget _buildTipsSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.lightbulb_outline, color: Colors.blue),
              SizedBox(width: 8),
              Text('Photography Tips',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '• Take photos from different angles\n'
            '• Ensure good lighting and clear background\n'
            '• Keep the object in the center\n'
            '• Avoid shadows and reflections',
            style:
                TextStyle(color: Colors.blue[700], fontSize: 14, height: 1.4),
          )
        ],
      ),
    );
  }

  void _showImageSourceDialog() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text('Camera'),
            onTap: () {
              Navigator.pop(context);
              _takePicture();
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: const Text('Gallery'),
            onTap: () {
              Navigator.pop(context);
              _pickFromGallery();
            },
          ),
        ],
      ),
    );
  }

  Future<void> _takePicture() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        setState(() => _capturedImages.add(File(image.path)));
      }
    } catch (e) {
      _showError('Failed to take picture: $e');
    }
  }

  Future<void> _pickFromGallery() async {
    try {
      final List<XFile> images = await _picker.pickMultiImage();
      if (images.isNotEmpty) {
        setState(() {
          for (var image in images) {
            if (_capturedImages.length < 6) {
              _capturedImages.add(File(image.path));
            }
          }
        });
      }
    } catch (e) {
      _showError('Failed to pick images: $e');
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }
}
