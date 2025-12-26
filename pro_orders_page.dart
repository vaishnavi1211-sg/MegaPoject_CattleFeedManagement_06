import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mega_pro/global/global_variables.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {

  List<Map<String, dynamic>> _orders = [
    {
      "orderId": "ORD-001",
      "customer": "ABC Dairy Farm",
      "product": "Cattle Feed Premium",
      "quantity": 50.0,
      "unit": "MT",
      "status": "Pending",
      "dueDate": "2025-12-20",
    },
    {
      "orderId": "ORD-002",
      "customer": "XYZ Livestock",
      "product": "Cattle Feed Standard",
      "quantity": 75.0,
      "unit": "MT",
      "status": "Pending",
      "dueDate": "2025-12-18",
    },
    {
      "orderId": "ORD-003",
      "customer": "Green Fields Farm",
      "product": "Cattle Feed Premium",
      "quantity": 100.0,
      "unit": "MT",
      "status": "Pending",
      "dueDate": "2025-12-15",
    },
  ];

  void _removeOrder(int index) {
    setState(() {
      _orders.removeAt(index);
    });
  }

  void _completeOrder(int index) {
    setState(() {
      _orders[index]["status"] = "Completed";
    });
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Completed":
        return AppColors.primaryBlue;
      case "In Progress":
        return Colors.orange;
      case "Pending":
        return GlobalColors.primaryBlue;
      default:
        return Colors.grey;
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
          "Order Management",
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
                "Active Orders",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),

              ..._orders.asMap().entries.map((entry) {
                final index = entry.key;
                final order = entry.value;

                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: GlobalColors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: _getStatusColor(order["status"]).withOpacity(0.3),
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
                          Text(
                            order["orderId"],
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.grey[800],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: _getStatusColor(order["status"])
                                  .withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              order["status"],
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: _getStatusColor(order["status"]),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      Text(
                        order["customer"],
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),

                      Text(
                        "${order["product"]} - ${order["quantity"]} ${order["unit"]}",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 4),

                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            size: 14,
                            color: Colors.grey[600],
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "Due: ${order["dueDate"]}",
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (order["status"] != "Completed")
                            ElevatedButton.icon(
                              onPressed: () => _completeOrder(index),
                              icon: const Icon(Icons.check, size: 16),
                              label: Text(
                                "Complete",
                                style: GoogleFonts.poppins(fontSize: 12),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryBlue,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                              ),
                            ),
                          const SizedBox(width: 8),

                          ElevatedButton.icon(
                            onPressed: () => _removeOrder(index),
                            icon: const Icon(Icons.delete, size: 16),
                            label: Text(
                              "Remove",
                              style: GoogleFonts.poppins(fontSize: 12),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.lightestBlue,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
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
    );
  }
}
