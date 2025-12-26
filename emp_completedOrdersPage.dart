import 'package:flutter/material.dart';
import 'package:mega_pro/global/global_variables.dart';

class CompletedOrdersPage extends StatelessWidget {
  const CompletedOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,

      // -------- APP BAR (FIXED & MATCHING TotalOrdersPage) --------
      appBar: AppBar(
        backgroundColor: GlobalColors.primaryBlue,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Completed Orders",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.cardBg,
              ),
            ),
            SizedBox(height: 2),
            Text(
              "History & Records",
              style: TextStyle(
                fontSize: 13,
                color: AppColors.mutedText,
              ),
            ),
          ],
        ),
      ),

      // -------- BODY --------
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
        children: [
          _monthTitle("October 2023"),
          _orderCard(
            id: "#ORD-4921",
            name: "Krishna Dairy Farm",
            date: "Oct 24",
            bags: "25 Bags",
            amount: "₹ 12,500",
            status: "DELIVERED",
            statusColor: AppColors.successGreen,
          ),
          _orderCard(
            id: "#ORD-4890",
            name: "Anand Traders",
            date: "Oct 22",
            bags: "100 Bags",
            amount: "₹ 45,000",
            status: "DELIVERED",
            statusColor: AppColors.successGreen,
          ),
          _orderCard(
            id: "#ORD-4855",
            name: "Shree Ram Gaushala",
            date: "Oct 20",
            bags: "15 Bags",
            amount: "₹ 8,200",
            status: "CANCELLED",
            statusColor: GlobalColors.textGrey,
            cancelled: true,
          ),

          const SizedBox(height: 26),

          _monthTitle("September 2023"),
          _orderCard(
            id: "#ORD-4712",
            name: "Gopal Dairy",
            date: "Sep 28",
            bags: "45 Bags",
            amount: "₹ 22,100",
            status: "DELIVERED",
            statusColor: AppColors.successGreen,
          ),
          _orderCard(
            id: "#ORD-4688",
            name: "Modern Cattle Farm",
            date: "Sep 25",
            bags: "30 Bags",
            amount: "₹ 18,750",
            status: "DELIVERED",
            statusColor: AppColors.successGreen,
          ),
        ],
      ),
    );
  }

  // ================= UI COMPONENTS =================

  Widget _monthTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
          color: AppColors.mutedText,
        ),
      ),
    );
  }

  Widget _orderCard({
    required String id,
    required String name,
    required String date,
    required String bags,
    required String amount,
    required String status,
    required Color statusColor,
    bool cancelled = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: GlobalColors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowGrey,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // LEFT
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  id,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: cancelled
                        ? AppColors.mutedText
                        : AppColors.primaryBlue,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: cancelled
                        ? AppColors.mutedText
                        : AppColors.primaryText,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "$date • $bags",
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.secondaryText,
                  ),
                ),
              ],
            ),
          ),

          // RIGHT
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  decoration:
                      cancelled ? TextDecoration.lineThrough : null,
                  color: cancelled
                      ? AppColors.mutedText
                      : AppColors.primaryText,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
