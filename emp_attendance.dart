import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mega_pro/global/global_variables.dart';

class EmployeeAttendancePage extends StatefulWidget {
  final List<CameraDescription> cameras;
  const EmployeeAttendancePage({super.key, required this.cameras});

  @override
  State<EmployeeAttendancePage> createState() => _EmployeeAttendancePageState();
}

class _EmployeeAttendancePageState extends State<EmployeeAttendancePage> {
  CameraController? _controller;
  XFile? _capturedImage;
  final _nameController = TextEditingController(text: "John Doe");
  final _idController = TextEditingController(text: "CF-8821");

  @override
  void initState() {
    super.initState();
    if (widget.cameras.isNotEmpty) {
      _controller =
          CameraController(widget.cameras[0], ResolutionPreset.medium);
      _controller!.initialize().then((_) {
        if (!mounted) return;
        setState(() {});
      });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    _nameController.dispose();
    _idController.dispose();
    super.dispose();
  }

  Future<void> captureImage() async {
    if (_controller != null && _controller!.value.isInitialized) {
      final XFile image = await _controller!.takePicture();
      setState(() => _capturedImage = image);
    }
  }

  Future<void> pickFromGallery() async {
    final XFile? image =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() => _capturedImage = image);
    }
  }

  void switchCamera() {
    if (widget.cameras.length > 1) {
      final newIndex =
          (_controller!.description == widget.cameras[0] ? 1 : 0);
      _controller =
          CameraController(widget.cameras[newIndex], ResolutionPreset.medium);
      _controller!.initialize().then((_) {
        if (!mounted) return;
        setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalColors.primaryBlue,
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Colors.white, size: 28),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Mark Attendance",
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 140),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 8),
                  const Text(
                    "Capture Selfie",
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Please ensure your face is clearly visible",
                    style:
                        TextStyle(fontSize: 14, color: GlobalColors.textGrey),
                  ),
                  const SizedBox(height: 12),

                  /// Camera Preview
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.width * 0.75,
                    decoration: BoxDecoration(
                      color: AppColors.softGreyBg,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: AppColors.borderGrey,
                        width: 2,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: _capturedImage != null
                          ? Image.file(
                              File(_capturedImage!.path),
                              fit: BoxFit.cover,
                            )
                          : (_controller != null &&
                                  _controller!.value.isInitialized
                              ? CameraPreview(_controller!)
                              : const Center(
                                  child: CircularProgressIndicator(),
                                )),
                    ),
                  ),

                  const SizedBox(height: 16),

                  /// Camera Controls
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: pickFromGallery,
                        icon: const Icon(Icons.photo_library),
                        color: GlobalColors.textGrey,
                        iconSize: 28,
                      ),
                      const SizedBox(width: 24),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: GlobalColors.primaryBlue,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.lightBlue,
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: IconButton(
                          onPressed: captureImage,
                          icon: const Icon(Icons.photo_camera),
                          color: Colors.white,
                          iconSize: 36,
                        ),
                      ),
                      const SizedBox(width: 24),
                      IconButton(
                        onPressed: switchCamera,
                        icon: const Icon(Icons.cameraswitch),
                        color: GlobalColors.textGrey,
                        iconSize: 28,
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  /// STATUS CARDS
                  Row(
                    children: [
                      Expanded(
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          elevation: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: const [
                                    Icon(Icons.schedule,
                                        color:
                                            GlobalColors.primaryBlue),
                                    SizedBox(width: 4),
                                    Text("Time",
                                        style: TextStyle(
                                            fontSize: 10,
                                            color:
                                                GlobalColors.textGrey)),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  TimeOfDay.now().format(context),
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}",
                                  style: const TextStyle(
                                      fontSize: 12,
                                      color:
                                          GlobalColors.textGrey),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          elevation: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: const [
                                    Icon(Icons.location_on,
                                        color:
                                            GlobalColors.primaryBlue),
                                    SizedBox(width: 4),
                                    Text("Location",
                                        style: TextStyle(
                                            fontSize: 10,
                                            color:
                                                GlobalColors.textGrey)),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  "123 Farm Road, Sector 4",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: const [
                                    CircleAvatar(
                                      radius: 4,
                                      backgroundColor:
                                          GlobalColors.success,
                                    ),
                                    SizedBox(width: 4),
                                    Text("GPS Active",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color:
                                                GlobalColors.success)),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  /// FORM
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person),
                      labelText: "Employee Name",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _idController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.badge),
                      labelText: "Employee ID",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                ],
              ),
            ),

            /// SUBMIT BUTTON
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(16),
                color: GlobalColors.white.withOpacity(0.9),
                child: ElevatedButton.icon(
                  onPressed: () {
                    if (_nameController.text.isEmpty ||
                        _idController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text(
                                "Please fill Employee Name and ID!")),
                      );
                      return;
                    }
                    if (_capturedImage != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text(
                                "Attendance submitted successfully!")),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content:
                                Text("Please capture selfie first!")),
                      );
                    }
                  },
                  icon: const Icon(Icons.send, size: 20, color: Color(0xFFF9FAFB),),
                  label: const Text(
                    "Submit Attendance",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFFF9FAFB)),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: GlobalColors.primaryBlue,
                    padding:
                        const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
