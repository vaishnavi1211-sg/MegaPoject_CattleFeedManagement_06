import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mega_pro/global/global_variables.dart';

import 'package:mega_pro/widgets/pro_stock_status_grid.dart';

import '../production/pro_inventory_page.dart';
import '../production/pro_orders_page.dart';
import '../production/pro_dispatch_page.dart';

class ProductionManagerDashboard extends StatefulWidget {
  const ProductionManagerDashboard({super.key});

  @override
  State<ProductionManagerDashboard> createState() =>
      _ProductionManagerDashboardState();
}

class _ProductionManagerDashboardState
    extends State<ProductionManagerDashboard> {
  // --- Simulated Metrics for CATTLE FEED ---
  final double _dailyOutput = 125.0; // Metric Tons / Day

  final Map<String, double> _stockData = {
    "Maize/Corn": 450.0,
    "Soybean Meal": 210.0,
    "Cotton Seed Cake": 95.0,
  };

  // --- QUICK ACTION CARD ---
  Widget _buildActionCard({
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 150,
        height: 120,
        decoration: BoxDecoration(
          color: GlobalColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 4,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 36, color: color),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Colors.grey[800],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          "Production Dashboard",
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
              /// DAILY PERFORMANCE
              Text(
                "Daily Performance",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: GlobalColors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Today's Output (Target: 120 MT)",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "${_dailyOutput.toStringAsFixed(1)} MT",
                      style: GoogleFonts.poppins(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryBlue,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              /// RAW MATERIAL STOCK STATUS
              StockStatusGrid(
                stockData: _stockData,
                themePrimary: GlobalColors.primaryBlue,
                themeSecondary: AppColors.primaryBlue,
              ),

              const SizedBox(height: 36),

              /// CORE ACTIONS
              Text(
                "Core Management Actions",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),

              Center(
                child: Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  alignment: WrapAlignment.center,
                  children: [
                    _buildActionCard(
                      title: "Track Inventory",
                      icon: Icons.inventory_2_outlined,
                      color: GlobalColors.primaryBlue,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const InventoryPage(),
                          ),
                        );
                      },
                    ),
                    _buildActionCard(
                      title: "Manage Orders",
                      icon: Icons.assignment,
                      color: GlobalColors.primaryBlue,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const OrdersPage(),
                          ),
                        );
                      },
                    ),
                    _buildActionCard(
                      title: "Dispatch Goods",
                      icon: Icons.local_shipping,
                      color: GlobalColors.primaryBlue,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const DispatchPage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 36),
            ],
          ),
        ),
      ),
    );
  }
}
