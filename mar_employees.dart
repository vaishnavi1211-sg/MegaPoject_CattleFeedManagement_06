import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mega_pro/global/global_variables.dart';


class EmployeeDetailPage extends StatelessWidget {
  const EmployeeDetailPage({super.key});

  // Mock Employee Data (Sales are in Tons)
  final List<Map<String, dynamic>> _employeeData = const [
    {
      "name": "Arjun Kulkarni",
      "id": "EMP001",
      "district": "Kolhapur",
      "role": "Sales Rep (Karvir, Panhala)",
      "total_sales": 380,
      "phone": "98765 12345",
      "email": "arjun.k@corp.com"
    },
    {
      "name": "Priya Deshmukh",
      "id": "EMP002",
      "district": "Kolhapur",
      "role": "Sales Rep (Shirol, Kagal)",
      "total_sales": 320,
      "phone": "90123 45678",
      "email": "priya.d@corp.com"
    },
    {
      "name": "Rohit Jadhav",
      "id": "EMP003",
      "district": "Pune",
      "role": "Regional Manager",
      "total_sales": 775,
      "phone": "92345 67890",
      "email": "rohit.j@corp.com"
    },
    {
      "name": "Sneha Patil",
      "id": "EMP004",
      "district": "Sangli",
      "role": "Sales Rep (Miraj, Walwa)",
      "total_sales": 275,
      "phone": "87654 32109",
      "email": "sneha.p@corp.com"
    },
    {
      "name": "Vikram Singh",
      "id": "EMP005",
      "district": "Satara",
      "role": "Sales Rep (Karad, Koregaon)",
      "total_sales": 350,
      "phone": "89012 34567",
      "email": "vikram.s@corp.com"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      appBar: AppBar(
        backgroundColor: GlobalColors.primaryBlue,
        title: Text(
          "Employee Directory",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _employeeData.length,
        itemBuilder: (context, index) {
          final employee = _employeeData[index];
          return EmployeeCard(employee: employee);
        },
      ),
    );
  }
}

class EmployeeCard extends StatelessWidget {
  const EmployeeCard({super.key, required this.employee});

  final Map<String, dynamic> employee;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// NAME + ROLE
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.lightBlue,
                  child: const Icon(
                    Icons.person,
                    color: GlobalColors.primaryBlue,
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      employee["name"],
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      employee["role"],
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: AppColors.secondaryText,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  employee["id"],
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: AppColors.mutedText,
                  ),
                ),
              ],
            ),

            const Divider(height: 24),

            /// LOCATION + PHONE
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildDetailChip(
                    Icons.location_on, employee["district"]),
                _buildDetailChip(Icons.phone, employee["phone"]),
              ],
            ),

            const SizedBox(height: 12),

            _buildSalesInfo(),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailChip(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.mutedText),
        const SizedBox(width: 4),
        Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 13,
            color: AppColors.primaryText,
          ),
        ),
      ],
    );
  }

  Widget _buildSalesInfo() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.lightBlue,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Total Sales (YTD):",
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: AppColors.primaryText,
            ),
          ),
          Text(
            '${employee["total_sales"].toStringAsFixed(0)} T',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: GlobalColors.primaryBlue,
            ),
          ),
        ],
      ),
    );
  }
}
