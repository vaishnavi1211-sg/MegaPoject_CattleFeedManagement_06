import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mega_pro/global/global_variables.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {

  final Map<String, Map<String, dynamic>> _inventoryData = {
    "Maize/Corn": {"stock": 450.0, "unit": "MT", "reorderLevel": 100.0},
    "Soybean Meal": {"stock": 210.0, "unit": "MT", "reorderLevel": 50.0},
    "Cotton Seed Cake": {"stock": 95.0, "unit": "MT", "reorderLevel": 100.0},
    "Wheat Bran": {"stock": 180.0, "unit": "MT", "reorderLevel": 75.0},
    "Mineral Mix": {"stock": 45.0, "unit": "MT", "reorderLevel": 20.0},
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          "Inventory Management",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Current Stock Levels",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),

              ..._inventoryData.entries.map((entry) {
                final name = entry.key;
                final stock = entry.value["stock"] as double;
                final unit = entry.value["unit"] as String;
                final reorderLevel = entry.value["reorderLevel"] as double;
                final isLowStock = stock < reorderLevel;

                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: GlobalColors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isLowStock
                          ? GlobalColors.primaryBlue.withOpacity(0.3)
                          : AppColors.primaryBlue.withOpacity(0.3),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "${stock.toStringAsFixed(1)} $unit",
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: isLowStock
                                    ? GlobalColors.primaryBlue
                                    : AppColors.primaryBlue,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Reorder at: ${reorderLevel.toStringAsFixed(1)} $unit",
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        isLowStock
                            ? Icons.warning_amber
                            : Icons.check_circle,
                        size: 36,
                        color: isLowStock
                            ? GlobalColors.primaryBlue
                            : AppColors.primaryBlue,
                      ),
                    ],
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
