import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:mega_pro/employee/emp_attendance.dart';
import 'package:mega_pro/employee/emp_completedOrdersPage.dart';
import 'package:mega_pro/employee/emp_create_order_page.dart';
import 'package:mega_pro/employee/emp_pendingOrdersScreen.dart';
import 'package:mega_pro/employee/emp_profile.dart';
import 'package:mega_pro/employee/emp_recent_order_page.dart';
import 'package:mega_pro/employee/emp_totalOrdersScreen.dart';
import 'package:mega_pro/global/global_variables.dart';

class EmployeeDashboard extends StatefulWidget {
  const EmployeeDashboard({super.key});

  @override
  State<EmployeeDashboard> createState() => _EmployeeDashboardState();
}

class _EmployeeDashboardState extends State<EmployeeDashboard> {
  int _selectedIndex = 0;

  final List<Widget> bottomPages = const [
    EmployeeDashboard(),
    CattleFeedOrderScreen(),
    RecentOrdersScreen(),
    EmployeeProfileDashboard(),
  ];

  @override
  Widget build(BuildContext context) {
    final months = [
      'Jan','Feb','Mar','Apr','May','Jun',
      'Jul','Aug','Sep','Oct','Nov','Dec'
    ];

    final performance = [60, 70, 65, 80, 75, 85, 88, 82, 90, 92, 95, 98];

    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      drawer: _buildDrawer(context),

      appBar: AppBar(
        backgroundColor: GlobalColors.primaryBlue,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Employee Dashboard",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// MARK ATTENDANCE
            InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        const EmployeeAttendancePage(cameras: []),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: _cardDecoration(),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: GlobalColors.primaryBlue,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Iconsax.calendar_1,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Mark Attendance",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Tap to mark now",
                          style: TextStyle(
                            color: GlobalColors.textGrey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 28),

            /// ORDERS OVERVIEW
            const Text(
              "Orders Overview",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                _summaryCard(
                  title: "Total Orders",
                  value: "124",
                  icon: Iconsax.shopping_cart,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const TotalOrdersPage(),
                      ),
                    );
                  },
                ),
                const SizedBox(width: 12),
                _summaryCard(
                  title: "Pending",
                  value: "8",
                  icon: Iconsax.timer,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const PendingOrdersPage(),
                      ),
                    );
                  },
                ),
                const SizedBox(width: 12),
                _summaryCard(
                  title: "Completed",
                  value: "116",
                  icon: Iconsax.tick_circle,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const CompletedOrdersPage(),
                      ),
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: 28),

            /// PERFORMANCE GRAPH
            Container(
              padding: const EdgeInsets.all(16),
              decoration: _cardDecoration(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Employee Achievement",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "Monthly performance (%)",
                    style:
                        TextStyle(color: GlobalColors.textGrey, fontSize: 13),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 220,
                    child: BarChart(
                      BarChartData(
                        maxY: 100,
                        borderData: FlBorderData(show: false),
                        gridData: FlGridData(
                          show: true,
                          horizontalInterval: 20,
                          getDrawingHorizontalLine: (v) =>
                              FlLine(color: GlobalColors.chartGrid),
                        ),
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              interval: 20,
                              getTitlesWidget: (v, _) =>
                                  Text("${v.toInt()}%",
                                      style: const TextStyle(fontSize: 10)),
                            ),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (v, _) =>
                                  Text(months[v.toInt()],
                                      style: const TextStyle(fontSize: 10)),
                            ),
                          ),
                          rightTitles:
                              AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          topTitles:
                              AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        ),
                        barGroups: List.generate(12, (i) {
                          return BarChartGroupData(
                            x: i,
                            barRods: [
                              BarChartRodData(
                                toY: performance[i].toDouble(),
                                width: 10,
                                borderRadius: BorderRadius.circular(6),
                                color: GlobalColors.primaryBlue,
                              ),
                            ],
                          );
                        }),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),
          ],
        ),
      ),

      /// BOTTOM NAV
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: GlobalColors.primaryBlue,
        unselectedItemColor: GlobalColors.textGrey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() => _selectedIndex = index);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => bottomPages[index]),
          );
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Iconsax.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Iconsax.add_square), label: "Create"),
          BottomNavigationBarItem(icon: Icon(Iconsax.receipt_item), label: "Orders"),
          BottomNavigationBarItem(icon: Icon(Iconsax.user), label: "Profile"),
        ],
      ),
    );
  }

  /// DRAWER
  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              color: GlobalColors.primaryBlue,
            ),
            accountName: const Text("Alex Johnson"),
            accountEmail: const Text("Employee"),
          ),
          ListTile(
            leading: const Icon(Iconsax.user),
            title: const Text("My Profile"),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const EmployeeProfileDashboard(),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Iconsax.logout, color: GlobalColors.danger),
            title: const Text(
              "Logout",
              style: TextStyle(color: GlobalColors.danger),
            ),
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  /// SUMMARY CARD (CLICKABLE)
  static Widget _summaryCard({
    required String title,
    required String value,
    required IconData icon,
    VoidCallback? onTap,
  }) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: _cardDecoration(),
          child: Column(
            children: [
              Icon(icon, color: GlobalColors.primaryBlue),
              const SizedBox(height: 6),
              Text(
                value,
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Text(
                title,
                style: const TextStyle(
                    color: GlobalColors.textGrey, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: GlobalColors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: AppColors.shadowGrey,
          blurRadius: 12,
        ),
      ],
    );
  }
}





// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:iconsax_flutter/iconsax_flutter.dart';
// import 'package:mega_pro/employee/emp_attendance.dart';
// import 'package:mega_pro/employee/emp_create_order_page.dart';
// import 'package:mega_pro/employee/emp_profile.dart';
// import 'package:mega_pro/employee/emp_recent_order_page.dart';
// import 'package:mega_pro/global/global_variables.dart';

// class EmployeeDashboard extends StatefulWidget {
//   const EmployeeDashboard({super.key});

//   @override
//   State<EmployeeDashboard> createState() => _EmployeeDashboardState();
// }

// class _EmployeeDashboardState extends State<EmployeeDashboard> {
//   int _selectedIndex = 0;

//   final List<Widget> bottomPages = [
//     const EmployeeDashboard(),
//     const CattleFeedOrderScreen(),
//     const RecentOrdersScreen(),
//     const EmployeeProfileDashboard(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final months = [
//       'Jan','Feb','Mar','Apr','May','Jun',
//       'Jul','Aug','Sep','Oct','Nov','Dec'
//     ];

//     final performance = [60, 70, 65, 80, 75, 85, 88, 82, 90, 92, 95, 98];

//     return Scaffold(
//       backgroundColor: AppColors.scaffoldBg,
//       drawer: _buildDrawer(context),

//       appBar: AppBar(
//         backgroundColor: GlobalColors.primaryBlue,
//         elevation: 0,
//         iconTheme: const IconThemeData(color: Colors.white),
//         title: const Text(
//           "Employee Dashboard",
//           style: TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ),

//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             /// MARK ATTENDANCE
//             Row(
//               children: [
//                 Expanded(
//                   child: InkWell(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) =>
//                               const EmployeeAttendancePage(cameras: []),
//                         ),
//                       );
//                     },
//                     child: Container(
//                       padding: const EdgeInsets.all(14),
//                       decoration: _cardDecoration(),
//                       child: Row(
//                         children: [
//                           Container(
//                             padding: const EdgeInsets.all(6),
//                             decoration: BoxDecoration(
//                               color: GlobalColors.primaryBlue,
//                               shape: BoxShape.circle,
//                             ),
//                             child: const Icon(
//                               Iconsax.calendar_1,
//                               color: Colors.white,
//                               size: 20,
//                             ),
//                           ),
//                           const SizedBox(width: 10),
//                           const Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 "Mark Attendance",
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.w600,
//                                   fontSize: 15,
//                                 ),
//                               ),
//                               SizedBox(height: 4),
//                               Text(
//                                 "Tap to mark now",
//                                 style: TextStyle(
//                                   color: GlobalColors.textGrey,
//                                   fontSize: 12,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),

//             const SizedBox(height: 28),

//             /// ORDERS OVERVIEW
//             const Text(
//               "Orders Overview",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//             ),
//             const SizedBox(height: 12),

//             Row(
//               children: [
//                 _summaryCard("Total Orders", "124", Iconsax.shopping_cart),
//                 const SizedBox(width: 12),
//                 _summaryCard("Pending", "8", Iconsax.timer),
//                 const SizedBox(width: 12),
//                 _summaryCard("Completed", "116", Iconsax.tick_circle),
//               ],
//             ),

//             const SizedBox(height: 28),

//             /// PERFORMANCE GRAPH
//             Container(
//               padding: const EdgeInsets.all(16),
//               decoration: _cardDecoration(),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     "Employee Achievement",
//                     style: TextStyle(
//                         fontSize: 16, fontWeight: FontWeight.w600),
//                   ),
//                   const SizedBox(height: 6),
//                   const Text(
//                     "Monthly performance (%)",
//                     style: TextStyle(
//                         color: GlobalColors.textGrey, fontSize: 13),
//                   ),
//                   const SizedBox(height: 20),

//                   SizedBox(
//                     height: 220,
//                     child: BarChart(
//                       BarChartData(
//                         maxY: 100,
//                         borderData: FlBorderData(show: false),
//                         gridData: FlGridData(
//                           show: true,
//                           horizontalInterval: 20,
//                           getDrawingHorizontalLine: (v) =>
//                               FlLine(color: GlobalColors.chartGrid),
//                         ),
//                         titlesData: FlTitlesData(
//                           leftTitles: AxisTitles(
//                             sideTitles: SideTitles(
//                               showTitles: true,
//                               interval: 20,
//                               getTitlesWidget: (v, _) =>
//                                   Text("${v.toInt()}%",
//                                       style:
//                                           const TextStyle(fontSize: 10)),
//                             ),
//                           ),
//                           bottomTitles: AxisTitles(
//                             sideTitles: SideTitles(
//                               showTitles: true,
//                               getTitlesWidget: (v, _) =>
//                                   Text(months[v.toInt()],
//                                       style:
//                                           const TextStyle(fontSize: 10)),
//                             ),
//                           ),
//                           rightTitles:
//                               AxisTitles(sideTitles: SideTitles(showTitles: false)),
//                           topTitles:
//                               AxisTitles(sideTitles: SideTitles(showTitles: false)),
//                         ),
//                         barGroups: List.generate(12, (i) {
//                           return BarChartGroupData(
//                             x: i,
//                             barRods: [
//                               BarChartRodData(
//                                 toY: performance[i].toDouble(),
//                                 width: 10,
//                                 borderRadius: BorderRadius.circular(6),
//                                 color: GlobalColors.primaryBlue,
//                               ),
//                             ],
//                           );
//                         }),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 28),

//             /// MONTHLY TARGET
//             Container(
//               padding: const EdgeInsets.all(20),
//               decoration: _cardDecoration(),
//               child: Row(
//                 children: [
//                   SizedBox(
//                     height: 90,
//                     width: 90,
//                     child: Stack(
//                       fit: StackFit.expand,
//                       children: [
//                         CircularProgressIndicator(
//                           value: 0.75,
//                           strokeWidth: 10,
//                           backgroundColor:
//                               GlobalColors.chartBackgroundBar,
//                           color: GlobalColors.primaryBlue,
//                         ),
//                         Center(
//                           child: Text(
//                             "75%",
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 18,
//                               color: GlobalColors.primaryBlue,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(width: 20),
//                   const Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "Monthly Target",
//                         style: TextStyle(
//                             fontSize: 16, fontWeight: FontWeight.w600),
//                       ),
//                       SizedBox(height: 4),
//                       Text(
//                         "120 / 160 hours completed",
//                         style: TextStyle(
//                             color: GlobalColors.textGrey, fontSize: 13),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 28),
//           ],
//         ),
//       ),

//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _selectedIndex,
//         selectedItemColor: GlobalColors.primaryBlue,
//         unselectedItemColor: GlobalColors.textGrey,
//         type: BottomNavigationBarType.fixed,
//         onTap: (index) {
//           setState(() => _selectedIndex = index);
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (_) => bottomPages[index]),
//           );
//         },
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Iconsax.home), label: "Home"),
//           BottomNavigationBarItem(icon: Icon(Iconsax.add_square), label: "Create"),
//           BottomNavigationBarItem(icon: Icon(Iconsax.receipt_item), label: "Orders"),
//           BottomNavigationBarItem(icon: Icon(Iconsax.user), label: "Profile"),
//         ],
//       ),
//     );
//   }

//   /// Drawer
//   Drawer _buildDrawer(BuildContext context) {
//     return Drawer(
//       child: Column(
//         children: [
//           UserAccountsDrawerHeader(
//             decoration:
//                 BoxDecoration(color: GlobalColors.primaryBlue),
//             accountName: const Text("Alex Johnson"),
//             accountEmail: const Text("Employee"),
//           ),
//           ListTile(
//             leading: const Icon(Iconsax.user),
//             title: const Text("My Profile"),
//             onTap: () => Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (_) => const EmployeeProfileDashboard(),
//               ),
//             ),
//           ),
//           ListTile(
//             leading:
//                 const Icon(Iconsax.logout, color: GlobalColors.danger),
//             title: const Text(
//               "Logout",
//               style: TextStyle(color: GlobalColors.danger),
//             ),
//             onTap: () => Navigator.pop(context),
//           ),
//         ],
//       ),
//     );
//   }

//   /// Summary Card
//   static Widget _summaryCard(
//       String title, String value, IconData icon) {
//     return Expanded(
//       child: Container(
//         padding: const EdgeInsets.all(14),
//         decoration: _cardDecoration(),
//         child: Column(
//           children: [
//             Icon(icon, color: GlobalColors.primaryBlue),
//             const SizedBox(height: 6),
//             Text(value,
//                 style: const TextStyle(
//                     fontSize: 18, fontWeight: FontWeight.w600)),
//             Text(title,
//                 style: const TextStyle(
//                     color: GlobalColors.textGrey, fontSize: 12)),
//           ],
//         ),
//       ),
//     );
//   }

//   static BoxDecoration _cardDecoration() {
//     return BoxDecoration(
//       color: GlobalColors.white,
//       borderRadius: BorderRadius.circular(16),
//       boxShadow: [
//         BoxShadow(
//           color: AppColors.shadowGrey,
//           blurRadius: 12,
//         ),
//       ],
//     );
//   }
// }






// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:iconsax_flutter/iconsax_flutter.dart';
// import 'package:mega_pro/employee/emp_attendance.dart';
// import 'package:mega_pro/employee/emp_create_order_page.dart';
// import 'package:mega_pro/employee/emp_profile.dart';
// import 'package:mega_pro/employee/emp_recent_order_page.dart';

// class EmployeeDashboard extends StatefulWidget {
//   const EmployeeDashboard({super.key});

//   @override
//   State<EmployeeDashboard> createState() => _EmployeeDashboardState();
// }

// class _EmployeeDashboardState extends State<EmployeeDashboard> {
//   int _selectedIndex = 0;

//   final List<Widget> bottomPages = [
//     EmployeeDashboard(),
//     const CattleFeedOrderScreen(),
//     const RecentOrdersScreen(),
//     const EmployeeProfileDashboard(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final months = [
//       'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
//       'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
//     ];

//     final performance = [60, 70, 65, 80, 75, 85, 88, 82, 90, 92, 95, 98];

//     return Scaffold(
//       backgroundColor: const Color(0xFFF4F6FA),
//       drawer: _buildDrawer(context),

//       appBar: AppBar(
//         backgroundColor: const Color(0xFF2563EB),
//         elevation: 0,
//         iconTheme: const IconThemeData(color: Colors.white),
//         title: const Text(
//           "Employee Dashboard",
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
//         ),
//       ),

//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             /// TODAY STATUS + MARK ATTENDANCE
//             Row(
//               children: [
                
//                 Expanded(
//                   child: InkWell(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (_) => const EmployeeAttendancePage(cameras: [],)),
//                       );
//                     },
//                     child: Container(
//                       padding: const EdgeInsets.all(14),
//                       decoration: _cardDecoration(),
//                       child: Row(
//                         children: [
//                           Container(
//                             padding: const EdgeInsets.all(6),
//                             decoration: const BoxDecoration(
//                               color: Color(0xFF2563EB),
//                               shape: BoxShape.circle,
//                             ),
//                             child: const Icon(Iconsax.calendar_1,
//                                 color: Colors.white, size: 20),
//                           ),
//                           const SizedBox(width: 10),
//                           const Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 "Mark Attendance",
//                                 style:
//                                     TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
//                               ),
//                               SizedBox(height: 4),
//                               Text(
//                                 "Tap to mark now",
//                                 style: TextStyle(color: Colors.grey, fontSize: 12),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),

//             const SizedBox(height: 28),

//             /// ORDERS OVERVIEW
//             const Text(
//               "Orders Overview",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//             ),
//             const SizedBox(height: 12),

//             Row(
//               children: [
//                 _summaryCard("Total Orders", "124", Iconsax.shopping_cart),
//                 const SizedBox(width: 12),
//                 _summaryCard("Pending", "8", Iconsax.timer),
//                 const SizedBox(width: 12),
//                 _summaryCard("Completed", "116", Iconsax.tick_circle),
//               ],
//             ),

//             const SizedBox(height: 28),

//             /// PERFORMANCE GRAPH
//             Container(
//               padding: const EdgeInsets.all(16),
//               decoration: _cardDecoration(),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     "Employee Achievement",
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//                   ),
//                   const SizedBox(height: 6),
//                   const Text(
//                     "Monthly performance (%)",
//                     style: TextStyle(color: Colors.grey, fontSize: 13),
//                   ),
//                   const SizedBox(height: 20),

//                   SizedBox(
//                     height: 220,
//                     child: BarChart(
//                       BarChartData(
//                         maxY: 100,
//                         borderData: FlBorderData(show: false),
//                         gridData: FlGridData(
//                           show: true,
//                           horizontalInterval: 20,
//                           getDrawingHorizontalLine: (v) =>
//                               FlLine(color: Colors.grey.shade300),
//                         ),
//                         titlesData: FlTitlesData(
//                           leftTitles: AxisTitles(
//                             sideTitles: SideTitles(
//                                 showTitles: true,
//                                 interval: 20,
//                                 getTitlesWidget: (v, _) =>
//                                     Text("${v.toInt()}%", style: const TextStyle(fontSize: 10))),
//                           ),
//                           bottomTitles: AxisTitles(
//                             sideTitles: SideTitles(
//                               showTitles: true,
//                               getTitlesWidget: (v, _) =>
//                                   Text(months[v.toInt()], style: const TextStyle(fontSize: 10)),
//                             ),
//                           ),
//                           rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//                           topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//                         ),
//                         barGroups: List.generate(12, (i) {
//                           return BarChartGroupData(
//                             x: i,
//                             barRods: [
//                               BarChartRodData(
//                                 toY: performance[i].toDouble(),
//                                 width: 10,
//                                 borderRadius: BorderRadius.circular(6),
//                                 color: const Color(0xFF2563EB),
//                               ),
//                             ],
//                           );
//                         }),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 28),

//             //=========================================//
//             //      NEW MONTHLY TARGET (CIRCULAR)       //
//             //=========================================//
//             Container(
//               padding: const EdgeInsets.all(20),
//               decoration: _cardDecoration(),
//               child: Row(
//                 children: [
//                   /// Circular Progress
//                   SizedBox(
//                     height: 90,
//                     width: 90,
//                     child: Stack(
//                       fit: StackFit.expand,
//                       children: [
//                         CircularProgressIndicator(
//                           value: 0.75,
//                           strokeWidth: 10,
//                           backgroundColor: const Color(0xFFE3E8F1),
//                           color: const Color(0xFF2563EB),
//                         ),
//                         Center(
//                           child: Text(
//                             "75%",
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 18,
//                               color: Colors.blue.shade700,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),

//                   const SizedBox(width: 20),

//                   /// Target Details
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text(
//                         "Monthly Target",
//                         style:
//                             TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//                       ),
//                       const SizedBox(height: 4),
//                       const Text(
//                         "120 / 160 hours completed",
//                         style: TextStyle(color: Colors.grey, fontSize: 13),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 28),
//           ],
//         ),
//       ),

//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _selectedIndex,
//         selectedItemColor: const Color(0xFF2563EB),
//         unselectedItemColor: Colors.grey,
//         type: BottomNavigationBarType.fixed,
//         onTap: (index) {
//           setState(() => _selectedIndex = index);
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (_) => bottomPages[index]),
//           );
//         },
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Iconsax.home), label: "Home"),
//           BottomNavigationBarItem(icon: Icon(Iconsax.add_square), label: "Create"),
//           BottomNavigationBarItem(icon: Icon(Iconsax.receipt_item), label: "Orders"),
//           BottomNavigationBarItem(icon: Icon(Iconsax.user), label: "Profile"),
//         ],
//       ),
//     );
//   }

//   /// Drawer
//   Drawer _buildDrawer(BuildContext context) {
//     return Drawer(
//       child: Column(
//         children: [
//           UserAccountsDrawerHeader(
//             decoration: const BoxDecoration(color: Color(0xFF2563EB)),
//             accountName: const Text("Alex Johnson"),
//             accountEmail: const Text("Employee"),
//           ),
//           ListTile(
//             leading: const Icon(Iconsax.user),
//             title: const Text("My Profile"),
//             onTap: () => Navigator.push(
//               context,
//               MaterialPageRoute(builder: (_) => const EmployeeProfileDashboard()),
//             ),
//           ),
//           ListTile(
//             leading: const Icon(Iconsax.logout, color: Colors.red),
//             title: const Text("Logout", style: TextStyle(color: Colors.red)),
//             onTap: () => Navigator.pop(context),
//           ),
//         ],
//       ),
//     );
//   }

  
//   /// Summary
//   static Widget _summaryCard(String title, String value, IconData icon) {
//     return Expanded(
//       child: Container(
//         padding: const EdgeInsets.all(14),
//         decoration: _cardDecoration(),
//         child: Column(
//           children: [
//             Icon(icon, color: const Color(0xFF2563EB)),
//             const SizedBox(height: 6),
//             Text(value,
//                 style:
//                     const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
//             Text(title,
//                 style: const TextStyle(color: Colors.grey, fontSize: 12)),
//           ],
//         ),
//       ),
//     );
//   }

//   static BoxDecoration _cardDecoration() {
//     return BoxDecoration(
//       color: Colors.white,
//       borderRadius: BorderRadius.circular(16),
//       boxShadow: [
//         BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 12),
//       ],
//     );
//   }
// }
