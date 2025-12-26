import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:mega_pro/global/global_variables.dart';
import 'package:mega_pro/owner/own_quick_action.dart';

class OwnerDashboardClean extends StatelessWidget {
  const OwnerDashboardClean({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColors.background,
      appBar: AppBar(
        backgroundColor: const Color(0xFF2563EB),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Owner Dashboard",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),

      /// Floating Quick Action
      floatingActionButton: FloatingActionButton(
        backgroundColor: GlobalColors.primaryBlue,
        child: const Icon(Icons.flash_on, color: Colors.white),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => OwnerQuickActionsPage()),
          );
        },
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _kpiGrid(),
            const SizedBox(height: 24),

            _sectionHeader("Revenue Trend", "Last 6 months"),
            const SizedBox(height: 12),
            _revenueTrendChart(),

            const SizedBox(height: 24),
            _sectionHeader("Production by Product", "This month (tons)"),
            const SizedBox(height: 12),
            _productionBarChart(),

            const SizedBox(height: 24),
            _sectionHeader("Branch Performance", "View All"),
            const SizedBox(height: 12),
            _branchTile("Mumbai Branch", "₹18.5L", "1.5K tons", "₹15.2L"),
            _branchTile("Delhi Branch", "₹15.2L", "1.2K tons", "₹12.8L"),
            _branchTile("Bangalore Branch", "₹13.8L", "1.1K tons", "₹11.6L"),
          ],
        ),
      ),
    );
  }

  /// ---------------- KPI GRID ----------------
  Widget _kpiGrid() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      children: const [
        _KpiCard(
          icon: Icons.currency_rupee,
          title: "Total Revenue",
          value: "₹45.2L",
          growth: "12.5%",
        ),
        _KpiCard(
          icon: Icons.factory,
          title: "Production",
          value: "3.8K tons",
          growth: "8.3%",
        ),
        _KpiCard(
          icon: Icons.shopping_cart,
          title: "Total Sales",
          value: "₹38.5L",
          growth: "15.2%",
        ),
        _KpiCard(
          icon: Icons.people,
          title: "Active Dealers",
          value: "156",
          growth: "-2.1%",
          down: true,
        ),
      ],
    );
  }

  /// ---------------- LINE CHART ----------------
  Widget _revenueTrendChart() {
    return _card(
      SizedBox(
        height: 220,
        child: LineChart(
          LineChartData(
            minY: 40,
            maxY: 80,
            gridData: FlGridData(
              show: true,
              horizontalInterval: 10,
              getDrawingHorizontalLine: (value) =>
                  FlLine(color: Colors.grey.withOpacity(0.2)),
            ),
            borderData: FlBorderData(show: false),
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: 10,
                  getTitlesWidget: (value, _) => Text(
                    value.toInt().toString(),
                    style: const TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, _) {
                    const months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun"];
                    return Text(
                      months[value.toInt()],
                      style: const TextStyle(fontSize: 10, color: Colors.grey),
                    );
                  },
                ),
              ),
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
            ),
            lineBarsData: [
              LineChartBarData(
                spots: const [
                  FlSpot(0, 45),
                  FlSpot(1, 52),
                  FlSpot(2, 47),
                  FlSpot(3, 63),
                  FlSpot(4, 70),
                  FlSpot(5, 78),
                ],
                isCurved: true,
                barWidth: 3,
                color: GlobalColors.primaryBlue,
                dotData: FlDotData(show: true),
                belowBarData: BarAreaData(
                  show: true,
                  color: GlobalColors.primaryBlue.withOpacity(0.15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ---------------- BAR CHART ----------------
  Widget _productionBarChart() {
    return _card(
      SizedBox(
        height: 250,
        child: BarChart(
          BarChartData(
            maxY: 1300,
            gridData: FlGridData(
              show: true,
              horizontalInterval: 100,
              getDrawingHorizontalLine: (value) =>
                  FlLine(color: Colors.grey.withOpacity(0.2)),
            ),
            borderData: FlBorderData(show: false),
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: 100,
                  reservedSize: 28,
                  getTitlesWidget: (value, _) => Text(
                    value.toInt().toString(),
                    style: const TextStyle(fontSize: 9, color: Colors.grey),
                  ),
                ),
              ),

              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, _) {
                    const labels = ["Feed A", "Feed B", "Feed C", "Feed D"];
                    return Text(
                      labels[value.toInt()],
                      style: const TextStyle(fontSize: 10, color: Colors.grey),
                    );
                  },
                ),
              ),
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
            ),
            barGroups: [
              _bar(0, 850),
              _bar(1, 1200),
              _bar(2, 950),
              _bar(3, 780),
            ],
          ),
        ),
      ),
    );
  }

  BarChartGroupData _bar(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          width: 24,
          borderRadius: BorderRadius.circular(6),
          color: GlobalColors.primaryBlue.withOpacity(0.25),
        ),
      ],
    );
  }

  /// ---------------- BRANCH TILE ----------------
  Widget _branchTile(
    String name,
    String revenue,
    String production,
    String sales,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: _boxDecoration(),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: GlobalColors.primaryBlue.withOpacity(0.1),
            child: Icon(Icons.apartment, color: GlobalColors.primaryBlue),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _metric("Revenue", revenue),
                    _metric("Production", production),
                    _metric("Sales", sales),
                  ],
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right),
        ],
      ),
    );
  }

  Widget _metric(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }

  /// ---------------- COMMON ----------------
  Widget _sectionHeader(String title, String action) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(action, style: TextStyle(color: GlobalColors.primaryBlue)),
      ],
    );
  }

  Widget _card(Widget child) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _boxDecoration(),
      child: child,
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      color: GlobalColors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: GlobalColors.shadow,
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }
}

/// ---------------- KPI CARD ----------------
class _KpiCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final String growth;
  final bool down;

  const _KpiCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.growth,
    this.down = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: GlobalColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: GlobalColors.shadow,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 28, color: GlobalColors.primaryBlue),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Text(title, style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 8),
          Text(
            "${down ? "↓" : "↑"} $growth",
            style: TextStyle(
              color: down ? Colors.red : Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}





// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:mega_pro/global/global_variables.dart';
// import 'package:mega_pro/owner/own_emp_icon.dart';
// import 'package:mega_pro/owner/own_inventory_icon.dart';
// import 'package:mega_pro/owner/own_quick_action.dart';
// import 'package:mega_pro/owner/own_sales.dart';

// class OwnerDashboardClean extends StatefulWidget {
//   const OwnerDashboardClean({super.key});

//   @override
//   State<OwnerDashboardClean> createState() => _OwnerDashboardCleanState();
// }

// class _OwnerDashboardCleanState extends State<OwnerDashboardClean> {
//   String selectedState = "Maharashtra";
//   int? _touchedBarIndex;

//   final List<FlSpot> _orderTrendData = [
//     FlSpot(0, 320),
//     FlSpot(1, 410),
//     FlSpot(2, 380),
//     FlSpot(3, 450),
//     FlSpot(4, 470),
//     FlSpot(5, 520),
//     FlSpot(6, 580),
//     FlSpot(7, 540),
//     FlSpot(8, 490),
//     FlSpot(9, 510),
//     FlSpot(10, 560),
    
//   ];

//   final List<Map<String, dynamic>> branches = [
//     {"name": "Pune", "orders": 488, "revenue": 12.5},
//     {"name": "Mumbai", "orders": 312, "revenue": 19.2},
//     {"name": "Nagpur", "orders": 196, "revenue": 7.8},
//     {"name": "Nashik", "orders": 248, "revenue": 9.3},
//     {"name": "Bengaluru", "orders": 220, "revenue": 10.2},
//   ];

//   List<BarChartGroupData> _generateImprovedBranchBars() {
//     return List.generate(branches.length, (i) {
//       final isTouched = i == _touchedBarIndex;
//       return BarChartGroupData(
//         x: i,
//         barRods: [
//           BarChartRodData(
//             toY: branches[i]["orders"].toDouble(),
//             width: isTouched ? 22 : 20,
//             color: isTouched
//                 ? GlobalColors.primaryBlue
//                 : GlobalColors.primaryBlue,
//             borderRadius: BorderRadius.circular(4),
//             backDrawRodData: BackgroundBarChartRodData(
//               show: true,
//               toY: 600,
//               color: GlobalColors.chartBackgroundBar,
//             ),
//           ),
//         ],
//       );
//     });
//   }

//   double _getDynamicMaxY() {
//     final maxOrders =
//         branches.map((b) => b["orders"]).reduce((a, b) => a > b ? a : b);
//     return (maxOrders * 1.2).toDouble();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: GlobalColors.background,
//       appBar: AppBar(
//         backgroundColor: GlobalColors.primaryBlue,
//         title: const Text(
//           "Owner Dashboard",
//           style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
//         ),
//         iconTheme: const IconThemeData(color: Colors.white),
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         backgroundColor: GlobalColors.primaryBlue,
//         label: const Text("Quick Action", style: TextStyle(color: Colors.white)),
//         icon: const Icon(Icons.flash_on),
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (_) => OwnerQuickActionsPage()),
//           );
//         },
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             _buildQuickStats(),
//             const SizedBox(height: 20),
//             _buildCharts(),
//             const SizedBox(height: 20),
//             _buildKPICardsGrid(),
//             const SizedBox(height: 20),
//             _buildMarketingManagerPerformance(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildQuickStats() {
//     return Wrap(
//       spacing: 18,
//       children: [
//         _quickIcon(Icons.currency_rupee, "Sales", const SalesPage()),
//         _quickIcon(Icons.people, "Employees", const EmployeesPage()),
//         _quickIcon(Icons.inventory, "Inventory", const InventoryPage()),
//       ],
//     );
//   }

//   Widget _quickIcon(IconData icon, String label, Widget page) {
//     return GestureDetector(
//       onTap: () => Navigator.push(
//           context, MaterialPageRoute(builder: (_) => page)),
//       child: Container(
//         width: 80,
//         height: 80,
//         decoration: _boxDecoration(),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(icon, color: GlobalColors.primaryBlue, size: 28),
//             const SizedBox(height: 6),
//             Text(label, style: const TextStyle(fontSize: 12)),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildCharts() {
//     return Column(
//       children: [
//         _chartCard(
//           "Branch Monthly Orders",
//           BarChart(
//             BarChartData(
//               maxY: _getDynamicMaxY(),
//               barGroups: _generateImprovedBranchBars(),
//               borderData: FlBorderData(
//                 show: true,
//                 border: Border.all(color: GlobalColors.chartGrid),
//               ),
//               gridData: FlGridData(
//                 //show: true,
//                 drawVerticalLine: false,
//                 getDrawingHorizontalLine: (_) =>
//                     FlLine(color: GlobalColors.chartGrid),
//               ),
//             ),
//           ),
//         ),
//         const SizedBox(height: 20),
//         _chartCard(
//           "Order Trend (12 Months)",
//           LineChart(
//             LineChartData(
//               minY: 0,
//               maxY: 600,
//               lineBarsData: [
//                 LineChartBarData(
//                   spots: _orderTrendData,
//                   isCurved: true,
//                   barWidth: 2,
//                   color: GlobalColors.primaryBlue,
//                   belowBarData: BarAreaData(
//                     show: true,
//                     // ignore: deprecated_member_use
//                     color: GlobalColors.primaryBlue.withOpacity(0.15),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildKPICardsGrid() {
//     return GridView.count(
//       crossAxisCount: 2,
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       crossAxisSpacing: 12,
//       mainAxisSpacing: 12,
//       children: [
//         _kpiCard("Total Revenue", "₹42.8 Cr", Icons.show_chart, GlobalColors.success),
//         _kpiCard("Total Orders", "11,248", Icons.shopping_bag, GlobalColors.primaryBlue),
//         _kpiCard("Avg Delivery", "2.1 Days", Icons.access_time, GlobalColors.warning),
//         _kpiCard("Distributors", "128", Icons.local_shipping, GlobalColors.purple),
//       ],
//     );
//   }

//   Widget _kpiCard(
//       String title, String value, IconData icon, Color color) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: _boxDecoration(),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Icon(icon, color: color),
//           const SizedBox(height: 8),
//           Text(title, style: const TextStyle(color: Colors.grey)),
//           Text(value,
//               style:
//                   const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//         ],
//       ),
//     );
//   }

//   Widget _buildMarketingManagerPerformance() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text("Marketing Managers Performance",
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//         const SizedBox(height: 12),
//         _mmTile("Rohit Sharma", "12 Leads Converted", GlobalColors.success),
//         _mmTile("Aditi Patil", "5 Pending Follow-ups", GlobalColors.warning),
//         _mmTile("Vikas More", "Performance Down", GlobalColors.danger),
//       ],
//     );
//   }

//   Widget _mmTile(String name, String stats, Color color) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       padding: const EdgeInsets.all(16),
//       decoration: _boxDecoration(),
//       child: Row(
//         children: [
//           CircleAvatar(radius: 5, backgroundColor: color),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
//                 Text(stats),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   BoxDecoration _boxDecoration() {
//     return BoxDecoration(
//       color: GlobalColors.white,
//       borderRadius: BorderRadius.circular(14),
//       boxShadow: [
//         BoxShadow(
//           color: GlobalColors.shadow,
//           blurRadius: 8,
//           offset: const Offset(0, 3),
//         ),
//       ],
//     );
//   }

//   Widget _chartCard(String title, Widget chart) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: _boxDecoration(),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(title,
//               style:
//                   const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//           const SizedBox(height: 12),
//           SizedBox(height: 220, child: chart),
//         ],
//       ),
//     );
//   }
// }






















// // import 'package:flutter/material.dart';

// // class OwnerDashboard extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.blue.shade50,

// //       appBar: AppBar(
// //         elevation: 0,
// //         backgroundColor: Colors.blue.shade700,
// //         flexibleSpace: Container(
// //           decoration: BoxDecoration(
// //             gradient: LinearGradient(
// //               colors: [
// //                 Colors.blue.shade800,
// //                 Colors.blue.shade600,
// //               ],
// //               begin: Alignment.topLeft,
// //               end: Alignment.bottomRight,
// //             ),
// //           ),
// //         ),
// //         title: Text(
// //           "Owner Dashboard",
// //           style: TextStyle(
// //             fontWeight: FontWeight.bold,
// //             color: Colors.white,
// //             letterSpacing: 0.5,
// //           ),
// //         ),
// //         centerTitle: true,
// //       ),

// //       body: SingleChildScrollView(
// //         padding: const EdgeInsets.all(16),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
            
// //             _buildHeaderSection(),

// //             SizedBox(height: 20),

// //             /// MAIN DASHBOARD SECTIONS
// //             _buildGlassCard(
// //               Icons.factory,
// //               "Today’s Production Summary",
// //               "• Feed Produced: 820 bags\n"
// //               "• Machines Running: 100%\n"
// //               "• Delays: None\n"
// //               "• Efficiency: 94%",
// //             ),

// //             _buildGlassCard(
// //               Icons.inventory_rounded,
// //               "Inventory Alerts",
// //               "• Maize: Low (18%) – Order soon\n"
// //               "• Mineral Mix: Stable\n"
// //               "• Soybean expires in 6 days",
// //             ),

// //             _buildGlassCard(
// //               Icons.currency_rupee,
// //               "Financial Snapshot",
// //               "• Revenue Today: ₹52,000\n"
// //               "• Pending: ₹85,000\n"
// //               "• Expenses: ₹12,500\n"
// //               "• Profit: ₹39,500",
// //             ),

// //             _buildGlassCard(
// //               Icons.people_alt,
// //               "Distributor Performance",
// //               "• Best: Shree Traders (26 orders)\n"
// //               "• Lowest: VJ Feeds (4 orders)\n"
// //               "• Payment Issues: 1 Distributor",
// //             ),

// //             _buildGlassCard(
// //               Icons.feedback_rounded,
// //               "Customer Feedback",
// //               "• Complaints: 2 today\n"
// //               "• Issue: Dispatch delays\n"
// //               "• Action Required: West Zone route fix",
// //             ),

// //             _buildGlassCard(
// //               Icons.auto_awesome,
// //               "AI Business Insights",
// //               "• Demand will rise by 14%\n"
// //               "• Increase pellet feed by 200 bags\n"
// //               "• Pricing revision +3% recommended",
// //             ),

// //             _buildGlassCard(
// //               Icons.build_circle_rounded,
// //               "Upcoming Maintenance",
// //               "• Mixer Service in 3 days\n"
// //               "• Vehicle #2 oil change pending\n"
// //               "• Safety Inspection next week",
// //             ),

// //             _buildGlassCard(
// //               Icons.group_work_rounded,
// //               "Team Performance",
// //               "• Production: 92%\n"
// //               "• Packing: 1,200 bags/hr\n"
// //               "• Staff Absent: 3",
// //             ),

// //             _buildGlassCard(
// //               Icons.trending_up_rounded,
// //               "Overall Business Overview",
// //               "• Monthly Sales: ₹12,80,000\n"
// //               "• Production: 21,500 bags\n"
// //               "• Growth: +8%",
// //             ),

// //             SizedBox(height: 30),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   /// HEADER – Welcome + Quick Stats
// //   Widget _buildHeaderSection() {
// //     return Container(
// //       padding: EdgeInsets.all(18),
// //       decoration: BoxDecoration(
// //         borderRadius: BorderRadius.circular(18),
// //         gradient: LinearGradient(
// //           colors: [Colors.blue.shade800, Colors.blue.shade600],
// //           begin: Alignment.topLeft,
// //           end: Alignment.bottomRight,
// //         ),
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.blue.shade300.withOpacity(0.4),
// //             blurRadius: 10,
// //             offset: Offset(0, 6),
// //           ),
// //         ],
// //       ),

// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Text(
// //             "Good Evening,",
// //             style: TextStyle(
// //               color: Colors.white,
// //               fontSize: 22,
// //               fontWeight: FontWeight.bold,
// //               letterSpacing: 0.5,
// //             ),
// //           ),
// //           SizedBox(height: 6),
// //           Text(
// //             "Here’s today’s business performance at a glance.",
// //             style: TextStyle(
// //               color: Colors.white.withOpacity(0.9),
// //               fontSize: 15,
// //             ),
// //           ),

// //           SizedBox(height: 20),

// //           Row(
// //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //             children: [
// //               _quickStat("Revenue", "₹52k"),
// //               _quickStat("Orders", "62"),
// //               _quickStat("Growth", "+8%"),
// //             ],
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   /// QUICK STATS BOXES
// //   Widget _quickStat(String title, String value) {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         Text(
// //           value,
// //           style: TextStyle(
// //             fontSize: 22,
// //             color: Colors.white,
// //             fontWeight: FontWeight.bold,
// //           ),
// //         ),
// //         Text(
// //           title,
// //           style: TextStyle(
// //             fontSize: 13,
// //             color: Colors.white70,
// //           ),
// //         ),
// //       ],
// //     );
// //   }

// //   /// GLASSMORPHISM CARD COMPONENT
// //   Widget _buildGlassCard(IconData icon, String title, String content) {
// //     return Container(
// //       margin: EdgeInsets.only(bottom: 16),
// //       padding: EdgeInsets.all(16),
// //       decoration: BoxDecoration(
// //         borderRadius: BorderRadius.circular(16),
// //         color: Colors.white.withOpacity(0.65),
// //         border: Border.all(color: Colors.blue.withOpacity(0.2), width: 1),
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.blue.shade200.withOpacity(0.25),
// //             blurRadius: 12,
// //             spreadRadius: 1,
// //             offset: Offset(0, 4),
// //           ),
// //         ],
// //       ),

// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Row(
// //             children: [
// //               CircleAvatar(
// //                 radius: 22,
// //                 backgroundColor: Colors.blue.shade100,
// //                 child: Icon(icon, color: Colors.blue.shade800, size: 26),
// //               ),
// //               SizedBox(width: 12),
// //               Expanded(
// //                 child: Text(
// //                   title,
// //                   style: TextStyle(
// //                     fontSize: 18,
// //                     fontWeight: FontWeight.w700,
// //                     color: Colors.blue.shade900,
// //                   ),
// //                 ),
// //               ),
// //             ],
// //           ),

// //           SizedBox(height: 12),

// //           Text(
// //             content,
// //             style: TextStyle(
// //               fontSize: 15,
// //               color: Colors.blue.shade800,
// //               height: 1.45,
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }


// // import 'package:flutter/material.dart';
// // import 'package:google_fonts/google_fonts.dart';

// // // OWNER DASHBOARD UI (Blue & White Theme)
// // // Elegant, Clean, Responsive

// // class OwnerDashboard extends StatelessWidget {
// //   const OwnerDashboard({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.white,
// //       appBar: AppBar(
// //         backgroundColor: Colors.blueAccent,
// //         elevation: 0,
// //         centerTitle: true,
// //         title: Text(
// //           "Owner Dashboard",
// //           style: GoogleFonts.poppins(
// //             fontSize: 22,
// //             fontWeight: FontWeight.w600,
// //             color: Colors.white,
// //           ),
// //         ),
// //       ),

// //       body: SingleChildScrollView(
// //         padding: const EdgeInsets.all(20),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [

// //             /// Greeting Section
// //             Text(
// //               "Welcome back, Owner!",
// //               style: GoogleFonts.poppins(
// //                 fontSize: 20,
// //                 fontWeight: FontWeight.w600,
// //                 color: Colors.black87,
// //               ),
// //             ),
// //             const SizedBox(height: 10),
// //             Text(
// //               "Here’s your business overview",
// //               style: GoogleFonts.poppins(
// //                 fontSize: 15,
// //                 color: Colors.black54,
// //               ),
// //             ),

// //             const SizedBox(height: 25),

// //             /// Stats Cards Row
// //             Row(
// //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //               children: [
// //                 _buildStatCard(
// //                   title: "Total Sales",
// //                   value: "₹4,50,000",
// //                   icon: Icons.bar_chart,
// //                   color: Colors.blueAccent,
// //                 ),
// //                 _buildStatCard(
// //                   title: "Monthly Orders",
// //                   value: "120",
// //                   icon: Icons.shopping_bag,
// //                   color: Colors.lightBlue,
// //                 ),
// //               ],
// //             ),

// //             const SizedBox(height: 20),

// //             Row(
// //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //               children: [
// //                 _buildStatCard(
// //                   title: "Distributors",
// //                   value: "14",
// //                   icon: Icons.group,
// //                   color: Colors.indigo,
// //                 ),
// //                 _buildStatCard(
// //                   title: "Pending Payments",
// //                   value: "₹85,000",
// //                   icon: Icons.payments,
// //                   color: Colors.blueGrey,
// //                 ),
// //               ],
// //             ),

// //             const SizedBox(height: 30),

// //             /// Graph Placeholder
// //             _buildGraphCard(),

// //             const SizedBox(height: 30),

// //             /// Quick Actions
// //             Text(
// //               "Quick Actions",
// //               style: GoogleFonts.poppins(
// //                 fontSize: 18,
// //                 fontWeight: FontWeight.w600,
// //               ),
// //             ),
// //             const SizedBox(height: 15),

// //             _buildActionButton(Icons.analytics, "View Detailed Reports"),
// //             _buildActionButton(Icons.inventory, "Check Inventory Levels"),
// //             _buildActionButton(Icons.local_shipping, "Track Dispatch"),
// //             _buildActionButton(Icons.people_alt, "Distributor Performance"),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   /// --- Reusable Widgets --- ///

// //   Widget _buildStatCard({
// //     required String title,
// //     required String value,
// //     required IconData icon,
// //     required Color color,
// //   }) {
// //     return Container(
// //       width: 160,
// //       padding: const EdgeInsets.all(18),
// //       decoration: BoxDecoration(
// //         color: Colors.white,
// //         borderRadius: BorderRadius.circular(16),
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.black.withOpacity(0.05),
// //             blurRadius: 8,
// //             offset: const Offset(0, 3),
// //           ),
// //         ],
// //         border: Border.all(color: Colors.blueAccent.withOpacity(0.2)),
// //       ),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Container(
// //             padding: const EdgeInsets.all(10),
// //             decoration: BoxDecoration(
// //               color: color.withOpacity(0.15),
// //               borderRadius: BorderRadius.circular(12),
// //             ),
// //             child: Icon(icon, color: color, size: 28),
// //           ),
// //           const SizedBox(height: 12),
// //           Text(
// //             title,
// //             style: GoogleFonts.poppins(
// //               fontSize: 14,
// //               color: Colors.black54,
// //             ),
// //           ),
// //           const SizedBox(height: 6),
// //           Text(
// //             value,
// //             style: GoogleFonts.poppins(
// //               fontSize: 18,
// //               fontWeight: FontWeight.w600,
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildGraphCard() {
// //     return Container(
// //       height: 200,
// //       width: double.infinity,
// //       decoration: BoxDecoration(
// //         color: Colors.white,
// //         borderRadius: BorderRadius.circular(16),
// //         border: Border.all(color: Colors.blueAccent.withOpacity(0.2)),
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.black.withOpacity(0.05),
// //             blurRadius: 10,
// //           ),
// //         ],
// //       ),
// //       child: Center(
// //         child: Text(
// //           "[Graph Placeholder]",
// //           style: GoogleFonts.poppins(
// //             fontSize: 16,
// //             color: Colors.black45,
// //             fontStyle: FontStyle.italic,
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildActionButton(IconData icon, String label) {
// //     return Container(
// //       margin: const EdgeInsets.only(bottom: 12),
// //       decoration: BoxDecoration(
// //         borderRadius: BorderRadius.circular(14),
// //         border: Border.all(color: Colors.blueAccent.withOpacity(0.3)),
// //       ),
// //       child: ListTile(
// //         leading: Icon(icon, color: Colors.blueAccent, size: 26),
// //         title: Text(
// //           label,
// //           style: GoogleFonts.poppins(
// //             fontSize: 16,
// //             fontWeight: FontWeight.w500,
// //           ),
// //         ),
// //         trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.blueAccent),
// //       ),
// //     );
// //   }
// // }
