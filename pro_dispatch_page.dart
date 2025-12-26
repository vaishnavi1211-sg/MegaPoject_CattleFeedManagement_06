import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mega_pro/global/global_variables.dart';

class DispatchPage extends StatefulWidget {
  const DispatchPage({super.key});

  @override
  State<DispatchPage> createState() => _DispatchPageState();
}

class _DispatchPageState extends State<DispatchPage> {

  final List<Map<String, dynamic>> _dispatches = [
    {
      "dispatchId": "DSP-001",
      "orderId": "ORD-003",
      "customer": "Green Fields Farm",
      "product": "Cattle Feed Premium",
      "quantity": 100.0,
      "unit": "MT",
      "vehicle": "TN-01-AB-1234",
      "driver": "Ravi Kumar",
      "status": "Delivered",
      "dispatchDate": "2025-12-15",
    },
    {
      "dispatchId": "DSP-002",
      "orderId": "ORD-002",
      "customer": "XYZ Livestock",
      "product": "Cattle Feed Standard",
      "quantity": 75.0,
      "unit": "MT",
      "vehicle": "TN-01-CD-5678",
      "driver": "Suresh Babu",
      "status": "In Transit",
      "dispatchDate": "2025-12-16",
    },
    {
      "dispatchId": "DSP-003",
      "orderId": "ORD-001",
      "customer": "ABC Dairy Farm",
      "product": "Cattle Feed Premium",
      "quantity": 50.0,
      "unit": "MT",
      "vehicle": "TN-01-EF-9012",
      "driver": "Arun Singh",
      "status": "Ready to Dispatch",
      "dispatchDate": "2025-12-17",
    },
  ];

  Color _getStatusColor(String status) {
    switch (status) {
      case "Delivered":
        return AppColors.primaryBlue;
      case "In Transit":
        return Colors.orange;
      case "Ready to Dispatch":
        return GlobalColors.primaryBlue;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case "Delivered":
        return Icons.check_circle;
      case "In Transit":
        return Icons.local_shipping;
      case "Ready to Dispatch":
        return Icons.schedule;
      default:
        return Icons.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          "Dispatch Management",
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
                "Dispatch Records",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),

              ..._dispatches.map((dispatch) {
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: GlobalColors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: _getStatusColor(dispatch["status"]).withOpacity(0.3),
                    ),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                dispatch["dispatchId"],
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.grey[800],
                                ),
                              ),
                              Text(
                                "Order: ${dispatch["orderId"]}",
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: _getStatusColor(dispatch["status"])
                                  .withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  _getStatusIcon(dispatch["status"]),
                                  size: 14,
                                  color: _getStatusColor(dispatch["status"]),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  dispatch["status"],
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: _getStatusColor(dispatch["status"]),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      Row(
                        children: [
                          Icon(Icons.business, size: 16, color: Colors.grey[600]),
                          const SizedBox(width: 4),
                          Text(
                            dispatch["customer"],
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),

                      Row(
                        children: [
                          Icon(Icons.inventory, size: 16, color: Colors.grey[600]),
                          const SizedBox(width: 4),
                          Text(
                            "${dispatch["product"]} - ${dispatch["quantity"]} ${dispatch["unit"]}",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),

                      Row(
                        children: [
                          Icon(Icons.local_shipping, size: 16, color: Colors.grey[600]),
                          const SizedBox(width: 4),
                          Text(
                            "${dispatch["vehicle"]} • ${dispatch["driver"]}",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),

                      Row(
                        children: [
                          Icon(Icons.calendar_today, size: 16, color: Colors.grey[600]),
                          const SizedBox(width: 4),
                          Text(
                            "Dispatch Date: ${dispatch["dispatchDate"]}",
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryBlue,
        onPressed: () {
          // add dispatch logic later
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
