import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mega_pro/global/global_variables.dart';

class MaintenancePage extends StatelessWidget {
  const MaintenancePage({super.key});

  final List<Map<String, dynamic>> maintenanceRecords = const [
    {
      "machine": "Furnace A",
      "date": "2025-11-20",
      "type": "Planned Shutdown",
      "status": "Completed",
      "duration": "12 hrs"
    },
    {
      "machine": "Grinder C",
      "date": "2025-12-05",
      "type": "Emergency Repair",
      "status": "Pending",
      "duration": "N/A"
    },
    {
      "machine": "Conveyor B",
      "date": "2025-10-15",
      "type": "Scheduled Inspection",
      "status": "Completed",
      "duration": "4 hrs"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: Colors.white,
        title: Text(
          "Machine Maintenance Log",
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Recent and Upcoming Maintenance Schedules",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: GlobalColors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                  )
                ],
              ),
              child: DataTable(
                columnSpacing: 18.0,
                headingRowColor: MaterialStateProperty.resolveWith(
                  (states) => AppColors.lightBlue,
                ),
                columns: [
                  DataColumn(
                    label: Text(
                      'Machine',
                      style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Date',
                      style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Type',
                      style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Status',
                      style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Duration',
                      style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
                rows: maintenanceRecords.map((record) {
                  final Color statusColor =
                      record['status'] == 'Pending'
                          ? GlobalColors.danger
                          : GlobalColors.success;

                  return DataRow(
                    cells: [
                      DataCell(Text(record['machine'] as String)),
                      DataCell(Text(record['date'] as String)),
                      DataCell(Text(record['type'] as String)),
                      DataCell(
                        Text(
                          record['status'] as String,
                          style: TextStyle(
                            color: statusColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      DataCell(Text(record['duration'] as String)),
                    ],
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 30),

            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content:
                          Text('Add New Record feature coming soon!'),
                    ),
                  );
                },
                icon: const Icon(Icons.add_box),
                label: Text(
                  "Add New Maintenance Record",
                  style: GoogleFonts.poppins(fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
