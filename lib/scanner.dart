import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'gemini_service.dart';

class Scanner extends StatefulWidget {
  @override
  _ScannerState createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;
  final ImagePicker _picker = ImagePicker();
  final GeminiService _geminiService = GeminiService();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    if (cameras.isEmpty) return;

    final firstCamera = cameras.first;
    _controller = CameraController(
      firstCamera,
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _controller!.initialize();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _processImage(Uint8List imageBytes) async {
    setState(() {
      _isLoading = true;
    });

    final result = await _geminiService.extractMedicationInfo(imageBytes);

    setState(() {
      _isLoading = false;
    });

    if (result != null) {
      _showEditDialog(result);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Failed to extract information. Please try again.')),
      );
    }
  }

  Future<void> _takePicture() async {
    try {
      await _initializeControllerFuture;
      final image = await _controller!.takePicture();
      final bytes = await image.readAsBytes();
      _processImage(bytes);
    } catch (e) {
      print(e);
    }
  }

  Future<void> _uploadPicture() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final bytes = await image.readAsBytes();
      _processImage(bytes);
    }
  }

  void _showEditDialog(Map<String, String> data) {
    final patientNameController =
        TextEditingController(text: data['patientName']);
    final medicationNameController =
        TextEditingController(text: data['medicationName']);
    final informationController =
        TextEditingController(text: data['information']);
    final dosageInstructionsController =
        TextEditingController(text: data['dosageInstructions']);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text('Check & Edit Information'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildEditableRow('Patient Name', patientNameController),
              _buildEditableRow('Medication Name', medicationNameController),
              _buildEditableRow('Information', informationController,
                  maxLines: 3),
              _buildEditableRow('When to Eat', dosageInstructionsController,
                  maxLines: 2),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // Collect edited data
              final editedData = {
                'patientName': patientNameController.text,
                'medicationName': medicationNameController.text,
                'information': informationController.text,
                'dosageInstructions': dosageInstructionsController.text,
              };
              
              print('Saving data: $editedData');
              // Logic to save this information to a list or database would go here
              
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Information saved successfully!')),
              );
            },
            child: Text('Confirm & Save'),
          ),
        ],
      ),
    );
  }

  Widget _buildEditableRow(String label, TextEditingController controller,
      {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
          TextField(
            controller: controller,
            maxLines: maxLines,
            decoration: InputDecoration(
              isDense: true,
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.all(10),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scanner', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: FutureBuilder<void>(
                  future: _initializeControllerFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return CameraPreview(_controller!);
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: _isLoading ? null : _takePicture,
                      icon: Icon(Icons.camera_alt),
                      label: Text('Scan'),
                    ),
                    ElevatedButton.icon(
                      onPressed: _isLoading ? null : _uploadPicture,
                      icon: Icon(Icons.photo_library),
                      label: Text('Upload'),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (_isLoading)
            Container(
              color: Colors.black54,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Analyzing with Gemini AI...',
                        style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
