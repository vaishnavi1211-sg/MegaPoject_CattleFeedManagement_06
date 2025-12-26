import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mega_pro/global/global_variables.dart';

class EmployeeProfileDashboard extends StatefulWidget {
  const EmployeeProfileDashboard({super.key});

  @override
  State<EmployeeProfileDashboard> createState() =>
      _EmployeeProfileDashboardState();
}

class _EmployeeProfileDashboardState
    extends State<EmployeeProfileDashboard> {
  final ImagePicker picker = ImagePicker();
  File? profileImage;

  Map<String, dynamic> employeeData = {
    'empId': 'CF2024-001',
    'empName': 'Rajesh Kumar',
    'position': 'Feed Production Manager',
    'department': 'Production',
    'branch': 'Main Plant',
    'district': 'Mumbai',
    'joiningDate': DateTime(2019, 3, 15),
    'status': 'Active',
    'performance': 88.5,
    'attendance': 94.2,
    'salary': 75000,
    'phone': '+91 98765 43210',
    'email': 'rajesh.kumar@cattlefeed.com',
  };

  List<Map<String, dynamic>> recentActivities = [
    {
      'date': DateTime.now().subtract(const Duration(days: 1)),
      'activity': 'Submitted monthly production report',
    },
    {
      'date': DateTime.now().subtract(const Duration(days: 2)),
      'activity': 'Quality check passed for batch #CF2401',
    },
  ];

  Future<void> pickProfileImage() async {
    final XFile? file =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 75);
    if (file != null) {
      setState(() => profileImage = File(file.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColors.background,
      appBar: AppBar(
        backgroundColor: GlobalColors.primaryBlue,
        title: const Text("Employee Profile", style: TextStyle(color: GlobalColors.white, fontWeight: FontWeight.bold),),
        //centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          _buildProfileHeader(),
          Expanded(child: _buildTabSection()),
        ],
      ),
    );
  }

  // ================= HEADER =================
  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: const BoxDecoration(
        color: GlobalColors.primaryBlue,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(22),
          bottomRight: Radius.circular(22),
        ),
      ),
      child: Row(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 52,
                backgroundColor: GlobalColors.white,
                backgroundImage:
                    profileImage != null ? FileImage(profileImage!) : null,
                child: profileImage == null
                    ? Text(
                        employeeData['empName']
                            .substring(0, 2)
                            .toUpperCase(),
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: GlobalColors.primaryBlue,
                        ),
                      )
                    : null,
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: pickProfileImage,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: GlobalColors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.edit,
                        size: 18, color: GlobalColors.primaryBlue),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  employeeData['empName'],
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: GlobalColors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  employeeData['position'],
                  style: const TextStyle(
                      color: AppColors.mutedText, fontSize: 14),
                ),
                const SizedBox(height: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.successLight,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    employeeData['status'],
                    style: const TextStyle(
                      color: AppColors.ratingAmber,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  // ================= TABS =================
  Widget _buildTabSection() {
    return DefaultTabController(
      length: 4,
      child: Column(
        children: [
          const TabBar(
            labelColor: GlobalColors.primaryBlue,
            unselectedLabelColor: GlobalColors.textGrey,
            indicatorColor: GlobalColors.primaryBlue,
            tabs: [
              Tab(text: "Personal"),
              Tab(text: "Employment"),
              Tab(text: "Performance"),
              Tab(text: "Activity"),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                _personalTab(),
                _employmentTab(),
                _performanceTab(),
                _activityTab(),
              ],
            ),
          )
        ],
      ),
    );
  }

  // ================= PERSONAL =================
  Widget _personalTab() {
    return _sectionWrapper(
      _infoCard(
        title: "Contact Information",
        icon: Icons.person,
        children: [
          _infoRow("Phone", employeeData['phone'], Icons.phone),
          _infoRow("Email", employeeData['email'], Icons.email),
          _infoRow("District", employeeData['district'], Icons.location_on),
        ],
      ),
    );
  }

  // ================= EMPLOYMENT =================
  Widget _employmentTab() {
    return _sectionWrapper(
      _infoCard(
        title: "Employment Details",
        icon: Icons.work,
        children: [
          _infoRow("Employee ID", employeeData['empId'], Icons.badge),
          _infoRow("Department", employeeData['department'], Icons.apartment),
          _infoRow("Branch", employeeData['branch'], Icons.factory),
          _infoRow(
            "Joining Date",
            DateFormat("dd MMM yyyy").format(employeeData['joiningDate']),
            Icons.calendar_today,
          ),
        ],
      ),
    );
  }

  // ================= PERFORMANCE =================
  Widget _performanceTab() {
    return _sectionWrapper(
      Column(
        children: [
          _metricCard(
              "Performance", employeeData['performance'], "%"),
          _metricCard(
              "Attendance", employeeData['attendance'], "%"),
          _salaryCard(),
        ],
      ),
    );
  }

  // ================= ACTIVITY =================
  Widget _activityTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: recentActivities.length,
      itemBuilder: (_, i) {
        final a = recentActivities[i];
        return Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          child: ListTile(
            leading: const Icon(Icons.event,
                color: GlobalColors.primaryBlue),
            title: Text(a['activity']),
            subtitle:
                Text(DateFormat("dd MMM yyyy").format(a['date'])),
          ),
        );
      },
    );
  }

  // ================= COMPONENTS =================
  Widget _sectionWrapper(Widget child) =>
      SingleChildScrollView(padding: const EdgeInsets.all(16), child: child);

  Widget _infoCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: GlobalColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowGrey,
            blurRadius: 12,
            offset: const Offset(0, 6),
          )
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(icon, color: GlobalColors.primaryBlue),
              const SizedBox(width: 8),
              Text(title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: GlobalColors.primaryBlue)),
            ],
          ),
          const Divider(),
          ...children,
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: GlobalColors.primaryBlue),
          const SizedBox(width: 12),
          Expanded(
            child: Text("$label: $value",
                style: const TextStyle(fontSize: 15)),
          ),
        ],
      ),
    );
  }

  Widget _metricCard(String title, double value, String suffix) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: GlobalColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: AppColors.shadowGrey, blurRadius: 10),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
                  const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: value / 100,
            color: GlobalColors.primaryBlue,
            backgroundColor: AppColors.softGreyBg,
          ),
          const SizedBox(height: 6),
          Text("${value.toStringAsFixed(1)}$suffix",
              style:
                  const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _salaryCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.lightBlue,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Monthly Salary",
              style: TextStyle(fontWeight: FontWeight.bold)),
          Text("₹${employeeData['salary']}",
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: GlobalColors.primaryBlue)),
        ],
      ),
    );
  }
}

















// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:image_picker/image_picker.dart';

// void main() {
//   runApp(const CattleFeedApp());
// }

// class CattleFeedApp extends StatelessWidget {
//   const CattleFeedApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Cattle Feed Project',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         scaffoldBackgroundColor: const Color.fromARGB(255, 144, 164, 224),
//         fontFamily: 'Poppins',
//         primaryColor: const Color(0xFF2563EB),
//         appBarTheme: const AppBarTheme(
//           backgroundColor: Color(0xFF2563EB),
//           elevation: 4,
//           iconTheme: IconThemeData(color: Colors.white),
//           titleTextStyle: TextStyle(
//             fontSize: 20,
//             color: Colors.white,
//             fontWeight: FontWeight.w700,
//           ),
//         ),
//       ),
//       home: const EmployeeProfileDashboard(),
//     );
//   }
// }

// class EmployeeProfileDashboard extends StatefulWidget {
//   const EmployeeProfileDashboard({super.key});

//   @override
//   State<EmployeeProfileDashboard> createState() =>
//       _EmployeeProfileDashboardState();
// }

// class _EmployeeProfileDashboardState extends State<EmployeeProfileDashboard> {
//   final ImagePicker picker = ImagePicker();
//   File? profileImage;

//   final Color blue = const Color(0xFF2563EB);

//   Map<String, dynamic> employeeData = {
//     'empId': 'CF2024-001',
//     'empName': 'Rajesh Kumar',
//     'position': 'Feed Production Manager',
//     'department': 'Production',
//     'branch': 'Main Plant',
//     'district': 'Mumbai',
//     'joiningDate': DateTime(2019, 3, 15),
//     'status': 'Active',
//     'performance': 88.5,
//     'attendance': 94.2,
//     'salary': 75000,
//     'phone': '+91 98765 43210',
//     'email': 'rajesh.kumar@cattlefeed.com',
//   };

//   List<Map<String, dynamic>> recentActivities = [
//     {
//       'date': DateTime.now().subtract(const Duration(days: 1)),
//       'activity': 'Submitted monthly production report',
//     },
//     {
//       'date': DateTime.now().subtract(const Duration(days: 2)),
//       'activity': 'Quality check passed for batch #CF2401',
//     },
//     {
//       'date': DateTime.now().subtract(const Duration(days: 3)),
//       'activity': 'Team meeting: New feed formulation discussion',
//     },
//     {
//       'date': DateTime.now().subtract(const Duration(days: 5)),
//       'activity': 'Training session on safety protocols',
//     },
//     {
//       'date': DateTime.now().subtract(const Duration(days: 7)),
//       'activity': 'Achieved monthly production target',
//     },
//   ];

//   Future<void> pickProfileImage() async {
//     final XFile? file =
//         await picker.pickImage(source: ImageSource.gallery, imageQuality: 75);
//     if (file != null) {
//       setState(() {
//         profileImage = File(file.path);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Employee Profile"),
//         centerTitle: true,
//       ),


    
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             _buildBlueProfileHeader(),
//             const SizedBox(height: 20),
//             _buildTabSection(),
//           ],
//         ),
//       ),
//     );
//   }

//   // ⭐ BLUE PROFILE HEADER
//   Widget _buildBlueProfileHeader() {
//     return Container(
//       padding: const EdgeInsets.all(22),
//       decoration: BoxDecoration(
//         color: blue,
//         borderRadius: const BorderRadius.only(
//           bottomLeft: Radius.circular(22),
//           bottomRight: Radius.circular(22),
//         ),
//       ),

//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Stack(
//             clipBehavior: Clip.none,
//             children: [
//               CircleAvatar(
//                 radius: 55,
//                 backgroundColor: Colors.white,
//                 backgroundImage:
//                     profileImage != null ? FileImage(profileImage!) : null,
//                 child: profileImage == null
//                     ? Text(
//                         employeeData['empName'].toString().substring(0, 2).toUpperCase(),
//                         style: TextStyle(
//                           fontSize: 32,
//                           color: blue,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       )
//                     : null,
//               ),
//               Positioned(
//                 bottom: -5,
//                 right: -5,
//                 child: GestureDetector(
//                   onTap: pickProfileImage,
//                   child: Container(
//                     padding: const EdgeInsets.all(6),
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: Colors.white,
//                     ),
//                     child: Icon(Icons.edit, size: 20, color: blue),
//                   ),
//                 ),
//               )
//             ],
//           ),

//           const SizedBox(width: 20),

//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   employeeData['empName'],
//                   style: const TextStyle(
//                     fontSize: 22,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//                 const SizedBox(height: 4),

//                 Text(
//                   employeeData['position'],
//                   style: const TextStyle(
//                     fontSize: 15,
//                     color: Colors.white70,
//                   ),
//                 ),
//                 const SizedBox(height: 8),

//                 Row(
//                   children: [
//                     const Icon(Icons.business, size: 16, color: Colors.white70),
//                     const SizedBox(width: 5),
//                     Text(
//                       "${employeeData['department']} • ${employeeData['branch']}",
//                       style: const TextStyle(color: Colors.white70),
//                     ),
//                   ],
//                 ),

//                 const SizedBox(height: 4),

//                 Row(
//                   children: [
//                     const Icon(Icons.location_pin, size: 16, color: Colors.white70),
//                     const SizedBox(width: 5),
//                     Text(
//                       employeeData['district'],
//                       style: const TextStyle(color: Colors.white70),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // ⭐ TAB SECTION
//   Widget _buildTabSection() {
//     return DefaultTabController(
//       length: 4,
//       child: Column(
//         children: [
//           Container(
//             color: Colors.white,
//             child: TabBar(
//               labelColor: blue,
//               unselectedLabelColor: Colors.grey,
//               indicatorColor: blue,
//               labelStyle: const TextStyle(fontWeight: FontWeight.w600),
//               tabs: const [
//                 Tab(text: "Personal", icon: Icon(Icons.person_outline)),
//                 Tab(text: "Employment", icon: Icon(Icons.work_outline)),
//                 Tab(text: "Performance", icon: Icon(Icons.bar_chart)),
//                 Tab(text: "Activity", icon: Icon(Icons.history)),
//               ],
//             ),
//           ),

//           SizedBox(
//             height: 560,
//             child: TabBarView(
//               children: [
//                 _buildPersonalInfoTab(),
//                 _buildEmploymentInfoTab(),
//                 _buildPerformanceTab(),
//                 _buildActivityTab(),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // ⭐ TABS CONTENT
//   Widget _buildPersonalInfoTab() {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(18),
//       child: Column(
//         children: [
//           _infoCard(
//             title: "Contact Information",
//             icon: Icons.contact_mail,
//             children: [
//               _infoRow("Mobile", employeeData['phone'], Icons.phone),
//               _infoRow("Email", employeeData['email'], Icons.email),
//               _infoRow("Emergency", "+91 98765 43211", Icons.call),
//             ],
//           ),
//           const SizedBox(height: 20),
//           _infoCard(
//             title: "Personal Details",
//             icon: Icons.person,
//             children: [
//               _infoRow("Date of Birth", "15 July 1985", Icons.cake),
//               _infoRow("Blood Group", "B+", Icons.bloodtype),
//               _infoRow("Aadhar", "XXXX XXXX 5678", Icons.credit_card),
//               _infoRow("PAN", "ABCDE1234F", Icons.badge),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildEmploymentInfoTab() {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(18),
//       child: Column(
//         children: [
//           _infoCard(
//             title: "Employment Details",
//             icon: Icons.work,
//             children: [
//               _infoRow("Employee ID", employeeData['empId'], Icons.badge),
//               _infoRow(
//                 "Joining Date",
//                 DateFormat("dd MMM yyyy").format(employeeData['joiningDate']),
//                 Icons.calendar_today,
//               ),
//               _infoRow(
//                 "Service",
//                 "${DateTime.now().difference(employeeData['joiningDate']).inDays ~/ 365} Years",
//                 Icons.timeline,
//               ),
//               _infoRow("Status", employeeData['status'], Icons.person_pin),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildPerformanceTab() {
//     return const Center(
//       child: Text("Performance Dashboard Coming Soon...",
//           style: TextStyle(color: Colors.grey)),
//     );
//   }

//   Widget _buildActivityTab() {
//     return ListView.builder(
//       padding: const EdgeInsets.all(18),
//       itemCount: recentActivities.length,
//       itemBuilder: (context, index) {
//         var a = recentActivities[index];
//         return Card(
//           elevation: 2,
//           margin: const EdgeInsets.symmetric(vertical: 8),
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
//           child: ListTile(
//             leading: Container(
//               padding: const EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                 color: blue.withOpacity(0.1),
//                 shape: BoxShape.circle,
//               ),
//               child: Icon(Icons.event, color: blue),
//             ),
//             title: Text(a['activity']),
//             subtitle: Text(DateFormat("dd MMM yyyy").format(a['date'])),
//           ),
//         );
//       },
//     );
//   }

//   // ⭐ REUSABLE UI COMPONENTS
//   Widget _infoCard({
//     required String title,
//     required IconData icon,
//     required List<Widget> children,
//   }) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black12.withOpacity(0.06),
//             blurRadius: 12,
//             offset: const Offset(0, 6),
//           )
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Icon(icon, color: blue, size: 22),
//               const SizedBox(width: 10),
//               Text(
//                 title,
//                 style: TextStyle(
//                   color: blue,
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 10),
//           const Divider(),
//           ...children,
//         ],
//       ),
//     );
//   }

//   Widget _infoRow(String label, String value, IconData icon) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: Row(
//         children: [
//           Icon(icon, size: 20, color: blue),
//           const SizedBox(width: 12),
//           Text(
//             "$label:",
//             style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
//           ),
//           const SizedBox(width: 6),
//           Expanded(
//             child: Text(
//               value,
//               style: const TextStyle(fontSize: 15, color: Colors.black87),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
