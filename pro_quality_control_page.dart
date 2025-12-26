import 'package:flutter/material.dart';
import 'package:mega_pro/global/global_variables.dart';

class QualityControlPage extends StatelessWidget {
  const QualityControlPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Quality Control Reports",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: const Center(
        child: Text(
          "Detailed QC analysis and data go here.",
        ),
      ),
    );
  }
}
