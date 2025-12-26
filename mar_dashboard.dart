import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:mega_pro/global/global_variables.dart';
import 'package:mega_pro/marketing/mar_employees.dart';
import 'package:mega_pro/marketing/mar_order.dart';
import 'package:mega_pro/marketing/mar_reporting.dart';

class MarketingManagerDashboard extends StatefulWidget {
  const MarketingManagerDashboard({super.key});

  @override
  State<MarketingManagerDashboard> createState() =>
      _MarketingManagerDashboardState();
}

class _MarketingManagerDashboardState
    extends State<MarketingManagerDashboard> {
  /// ---------------- SAMPLE DISTRICT → TALUKA DATA ----------------
  final Map<String, List<Map<String, dynamic>>> _data = {
    "Pune": [
      {"taluka": "Haveli", "sales": 320},
      {"taluka": "Mulshi", "sales": 260},
      {"taluka": "Junnar", "sales": 290},
      {"taluka": "Khed", "sales": 270},
      {"taluka": "Daund", "sales": 280},
    ],
    "Nashik": [
      {"taluka": "Niphad", "sales": 300},
      {"taluka": "Sinnar", "sales": 260},
      {"taluka": "Dindori", "sales": 280},
      {"taluka": "Malegaon", "sales": 310},
    ],
    "Ahmednagar": [
      {"taluka": "Rahata", "sales": 340},
      {"taluka": "Shrirampur", "sales": 320},
      {"taluka": "Sangamner", "sales": 300},
      {"taluka": "Akole", "sales": 260},
    ],
  };

  late List<String> _districts;
  late String _selectedDistrict;

  @override
  void initState() {
    super.initState();
    _districts = _data.keys.toList();
    _selectedDistrict = _districts.first;
  }

  double _totalSales(String district) =>
      _data[district]!.fold(0, (s, e) => s + e['sales']);

  LineChartData _chart(String district) {
    final list = _data[district]!;
    final maxY =
        list.map((e) => e['sales']).reduce((a, b) => a > b ? a : b) * 1.2;

    return LineChartData(
      minY: 0,
      maxY: maxY,
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        getDrawingHorizontalLine: (_) =>
            FlLine(color: AppColors.borderGrey),
      ),
      borderData: FlBorderData(show: false),
      titlesData: FlTitlesData(
        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 36,
            getTitlesWidget: (v, _) => Text(
              v.toInt().toString(),
              style: const TextStyle(fontSize: 10),
            ),
          ),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: (v, _) {
              final i = v.toInt();
              if (i < 0 || i >= list.length) return const SizedBox();
              return Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text(
                  list[i]['taluka'],
                  style: const TextStyle(fontSize: 10),
                ),
              );
            },
          ),
        ),
      ),
      lineBarsData: [
        LineChartBarData(
          spots: List.generate(
            list.length,
            (i) => FlSpot(i.toDouble(), list[i]['sales'].toDouble()),
          ),
          isCurved: true,
          color: GlobalColors.primaryBlue,
          barWidth: 3,
          dotData: const FlDotData(show: true),
          belowBarData: BarAreaData(
            show: true,
            color: AppColors.lightBlue,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      appBar: AppBar(
        backgroundColor: GlobalColors.primaryBlue,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'Marketing Manager',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "Sales Overview",
            style: GoogleFonts.poppins(
                fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),
          Text(
            "District-wise cattle feed performance",
            style: GoogleFonts.poppins(color: GlobalColors.textGrey),
          ),

          const SizedBox(height: 20),

          /// KPI CARD
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: GlobalColors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadowGrey,
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                )
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.lightBlue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.bar_chart,
                      color: GlobalColors.primaryBlue),
                ),
                const SizedBox(width: 14),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total Sales (Tons)",
                        style: GoogleFonts.poppins(
                            color: GlobalColors.textGrey, fontSize: 13),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _totalSales(_selectedDistrict)
                            .toStringAsFixed(0),
                        style: GoogleFonts.poppins(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: GlobalColors.primaryBlue),
                      ),
                    ])
              ],
            ),
          ),

          const SizedBox(height: 24),

          /// TALUKA CHART
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: GlobalColors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadowGrey,
                  blurRadius: 14,
                  offset: const Offset(0, 6),
                )
              ],
            ),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "Taluka-wise Sales Trend",
                style: GoogleFonts.poppins(
                    fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 6),
              Text(
                "Reported sales volume",
                style: GoogleFonts.poppins(
                    color: GlobalColors.textGrey),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 320,
                child: LineChart(_chart(_selectedDistrict)),
              ),
            ]),
          ),

          const SizedBox(height: 28),

          /// ACTIONS
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _action("Employees", Icons.people, context,
                  const EmployeeDetailPage()),
              _action("Make Order", Icons.shopping_cart, context,
                  const MakeOrderPage()),
              _action("Reports", Icons.bar_chart, context,
                  const EmployeeAttendancePage(cameras: [],)),
            ],
          ),
        ]),
      ),
    );
  }

  Widget _action(
      String text, IconData icon, BuildContext ctx, Widget page) {
    return SizedBox(
      height: 48,
      child: ElevatedButton.icon(
        icon: Icon(icon),
        label: Text(text),
        onPressed: () =>
            Navigator.push(ctx, MaterialPageRoute(builder: (_) => page)),
        style: ElevatedButton.styleFrom(
          backgroundColor: GlobalColors.primaryBlue,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 18),
        ),
      ),
    );
  }
}




// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:mega_pro/mar_employees.dart';
// import 'package:mega_pro/mar_order.dart';
// import 'package:mega_pro/mar_reporting.dart';



// // ===============================================
// // MARKETING MANAGER DASHBOARD (Main Screen)
// // ===============================================

// class MarketingManagerDashboard extends StatefulWidget {
//   const MarketingManagerDashboard({super.key});

//   @override
//   State<MarketingManagerDashboard> createState() =>
//       _MarketingManagerDashboardState();
// }

// class _MarketingManagerDashboardState extends State<MarketingManagerDashboard> {
//   final Color themePrimary = const Color(0xFF2563EB);
//   final Color bg = const Color(0xFFF9FAFB);

//   // Sales are now in Tons (T)
//   final Map<String, List<Map<String, dynamic>>> _districtTalukaData = {
//     "Kolhapur": [
//       {"taluka": "Karvir", "sales": 220},
//       {"taluka": "Panhala", "sales": 160},
//       {"taluka": "Shirol", "sales": 140},
//       {"taluka": "Hatkanangale", "sales": 110},
//       {"taluka": "Kagal", "sales": 180},
//       {"taluka": "Shahuwadi", "sales": 95},
//       {"taluka": "Ajara", "sales": 75},
//       {"taluka": "Gadhinglaj", "sales": 205},
//       {"taluka": "Chandgad", "sales": 130},
//       {"taluka": "Radhanagari", "sales": 120},
//       {"taluka": "Jat", "sales": 90},
//       {"taluka": "Bhudargad", "sales": 150},
//     ],
//     "Sangli": [
//       {"taluka": "Miraj", "sales": 180},
//       {"taluka": "Kavathe Mahankal", "sales": 130},
//       {"taluka": "Walwa", "sales": 95},
//       {"taluka": "Khanapur", "sales": 110},
//     ],
//     "Satara": [
//       {"taluka": "Karad", "sales": 210},
//       {"taluka": "Koregaon", "sales": 140},
//       {"taluka": "Phaltan", "sales": 125},
//     ],
//     "Pune": [
//       {"taluka": "Haveli", "sales": 300},
//       {"taluka": "Mulshi", "sales": 95},
//       {"taluka": "Shirur", "sales": 160},
//       {"taluka": "Baramati", "sales": 220},
//     ],
//   };

//   // Fixed the selected district to Kolhapur since the selector is removed.
//   final String _selectedDistrict = "Kolhapur"; 

//   double _getMaxY(List<Map<String, dynamic>> talukas) {
//     return talukas.isNotEmpty
//         ? (talukas
//                 .map((e) => (e['sales'] as num).toDouble())
//                 .reduce((a, b) => a > b ? a : b)) *
//               1.15
//         : 100.0;
//   }

//   LineChartData _buildLineChartDataForDistrict(String district) {
//     final talukas = _districtTalukaData[district] ?? [];
//     final spots = List<FlSpot>.generate(talukas.length, (i) {
//       final value = (talukas[i]['sales'] as num).toDouble();
//       return FlSpot(i.toDouble(), value);
//     });

//     return LineChartData(
//       gridData: FlGridData(
//         show: true,
//         drawVerticalLine: false,
//         horizontalInterval: _getMaxY(talukas) / 5,
//         getDrawingHorizontalLine: (value) =>
//             FlLine(color: Colors.grey.withOpacity(0.3), strokeWidth: 1),
//       ),
//       titlesData: FlTitlesData(
//         show: true,
//         rightTitles: const AxisTitles(
//           sideTitles: SideTitles(showTitles: false),
//         ),
//         topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
//         bottomTitles: AxisTitles(
//           sideTitles: SideTitles(
//             showTitles: true,
//             reservedSize: 80,
//             interval: 1,
//             getTitlesWidget: (value, meta) {
//               final i = value.toInt();
//               if (i < 0 || i >= talukas.length) {
//                 return const SizedBox.shrink();
//               }
//               return SideTitleWidget(
//                 axisSide: meta.axisSide,
//                 space: 10,
//                 child: Transform.rotate(
//                   angle: -0.6,
//                   child: Text(
//                     talukas[i]["taluka"],
//                     style: const TextStyle(fontSize: 11),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//         leftTitles: AxisTitles(
//           sideTitles: SideTitles(
//             showTitles: true,
//             reservedSize: 40,
//             getTitlesWidget: (value, meta) => Text(
//               value.toInt().toString(), // Show Y-axis values as integers
//               style: const TextStyle(fontSize: 11),
//             ),
//           ),
//         ),
//       ),
//       borderData: FlBorderData(
//         show: true,
//         border: Border.all(color: Colors.grey.withOpacity(0.5), width: 1),
//       ),
//       minX: 0,
//       maxX: (talukas.length - 1).toDouble(),
//       minY: 0,
//       maxY: _getMaxY(talukas),
//       lineBarsData: [
//         LineChartBarData(
//           spots: spots,
//           isCurved: true,
//           color: themePrimary,
//           barWidth: 4,
//           isStrokeCapRound: true,
//           dotData: const FlDotData(show: true),
//           belowBarData: BarAreaData(
//             show: true,
//             color: themePrimary.withOpacity(0.3),
//           ),
//         ),
//       ],
//     );
//   }

//   double _districtTotalSales(String district) {
//     final talukas = _districtTalukaData[district] ?? [];
//     return talukas.fold<double>(
//       0,
//       (sum, e) => sum + (e['sales'] as num).toDouble(),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final talukaList = _districtTalukaData[_selectedDistrict] ?? [];
//     final lineChartData = _buildLineChartDataForDistrict(_selectedDistrict);

//     return Scaffold(
//       backgroundColor: bg,
//       appBar: AppBar(
//         backgroundColor: themePrimary,
//         title: Text(
//           "Marketing Manager Dashboard",
//           style: GoogleFonts.poppins(
//             fontWeight: FontWeight.w600,
//             color: Colors.white,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
              
//               // --- DISTRICT INFO CARD (Simplified) ---
//               Container(
//                 height: 80,
//                 width: double.infinity, // Take full width
//                 padding: const EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       'Sales for $_selectedDistrict (Tons)', // Updated title
//                       style: GoogleFonts.poppins(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.grey[700],
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       'Total: ${_districtTotalSales(_selectedDistrict).toStringAsFixed(0)} T',
//                       style: GoogleFonts.poppins(
//                         fontWeight: FontWeight.w700,
//                         fontSize: 20,
//                         color: themePrimary,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 18),
//               // ----------------------------------------
              
//               // Title
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "Taluka-wise Sales Trend",
//                     style: GoogleFonts.poppins(
//                       fontSize: 18,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   Text(
//                     "${talukaList.length} talukas",
//                     style: GoogleFonts.poppins(color: Colors.grey[600]),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 12),

//               // Line Chart
//               Container(
//                 height: 360,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(16),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.06),
//                       blurRadius: 14,
//                       offset: const Offset(0, 6),
//                     ),
//                   ],
//                 ),
//                 padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
//                 child: talukaList.isNotEmpty
//                     ? SingleChildScrollView(
//                         // <-- Handles horizontal overflow if many data points exist
//                         scrollDirection: Axis.horizontal,
//                         child: Row(
//                           // <-- Use Row to provide infinite horizontal constraints
//                           mainAxisSize: MainAxisSize
//                               .min, // <-- Key to let Row shrink-wrap content
//                           children: [
//                             SizedBox(
//                               // Calculate the required width: 40px for left title area +
//                               // 90px buffer for each data point. This forces the chart to be wide.
//                               width: 40.0 + (talukaList.length * 90.0),
//                               height:
//                                   344, // Match container height minus padding
//                               child: LineChart(lineChartData),
//                             ),
//                           ],
//                         ),
//                       )
//                     : Center(
//                         child: Text(
//                           "No Sales Data Available for $_selectedDistrict",
//                         ),
//                       ),
//               ),

//               const SizedBox(height: 24),

//               // Quick actions (View Employees, Make Order, & View Reports)
//               Center(
//                 // <--- This widget correctly centers the Wrap block
//                 child: Wrap(
//                   spacing: 12.0, // Horizontal space between buttons
//                   runSpacing: 12.0, // Vertical space between rows of buttons
//                   children: [
//                     // 1. View Employees Button
//                     SizedBox(
//                       height: 50,
//                       child: ElevatedButton.icon(
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => const EmployeeDetailPage(),
//                             ),
//                           );
//                         },
//                         icon: const Icon(Icons.people),
//                         label: const Text("View Employees"),
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: themePrimary,
//                           foregroundColor: Colors.white,
//                           padding: const EdgeInsets.symmetric(horizontal: 20),
//                         ),
//                       ),
//                     ),

//                     // 2. Make Order Button
//                     SizedBox(
//                       height: 50,
//                       child: ElevatedButton.icon(
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => const MakeOrderPage(),
//                             ),
//                           );
//                         },
//                         icon: const Icon(Icons.shopping_cart),
//                         label: const Text("Make Order"),
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.green,
//                           foregroundColor: Colors.white,
//                           padding: const EdgeInsets.symmetric(horizontal: 20),
//                         ),
//                       ),
//                     ),

//                     // 3. View Reports Button
//                     SizedBox(
//                       height: 50,
//                       child: ElevatedButton.icon(
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => const ReportingPage(),
//                             ),
//                           );
//                         },
//                         icon: const Icon(Icons.bar_chart), // Icon for reports
//                         label: const Text("View Reports"),
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor:
//                               Colors.orange, // New color for distinction
//                           foregroundColor: Colors.white,
//                           padding: const EdgeInsets.symmetric(horizontal: 20),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               const SizedBox(height: 36),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }