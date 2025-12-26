import 'package:flutter/material.dart';
import 'package:mega_pro/global/global_variables.dart';

class PendingOrdersPage extends StatefulWidget {
  const PendingOrdersPage({super.key});

  @override
  State<PendingOrdersPage> createState() => _PendingOrdersPageState();
}

class _PendingOrdersPageState extends State<PendingOrdersPage> {
  final TextEditingController _searchCtrl = TextEditingController();
  String _query = "";

  final List<Map<String, dynamic>> _pendingOrders = [
    {
      "id": "#ORD-8832",
      "time": "Today, 10:30 AM",
      "name": "Krishna Dairy Farm",
      "amount": "₹ 24,500",
      "status": "Pending",
      "statusColor": GlobalColors.warning,
      "product": "50 Bags • Premium Feed A",
    },
    {
      "id": "#ORD-8831",
      "time": "Yesterday",
      "name": "Anand Traders",
      "amount": "₹ 58,000",
      "status": "Processing",
      "statusColor": GlobalColors.warning,
      "product": "120 Bags • Standard Mix",
    },
    {
      "id": "#ORD-8830",
      "time": "Oct 22",
      "name": "Gauri Gaushala",
      "amount": "₹ 8,250",
      "status": "Payment Due",
      "statusColor": GlobalColors.danger,
      "product": "15 Bags • Mineral Mix",
    },
    {
      "id": "#ORD-8829",
      "time": "Oct 20",
      "name": "Patel Agri Solutions",
      "amount": "₹ 95,000",
      "status": "Awaiting Stock",
      "statusColor": AppColors.secondaryText,
      "product": "200 Bags • Type B",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredOrders = _pendingOrders.where((o) {
      return o["name"].toLowerCase().contains(_query) ||
          o["id"].toLowerCase().contains(_query);
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,

      // ---------- APP BAR ----------
      appBar: AppBar(
         backgroundColor: GlobalColors.primaryBlue,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        
        title: const Text(
          "Pending Orders",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.cardBg,
          ),
        ),
      ),

      // ---------- BODY ----------
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _searchBox(),
          const SizedBox(height: 12),

          for (final order in filteredOrders) _orderCard(order),
        ],
      ),
    );
  }

  // ================= SEARCH =================

  Widget _searchBox() {
    return TextField(
      controller: _searchCtrl,
      onChanged: (v) => setState(() => _query = v.toLowerCase()),
      decoration: InputDecoration(
        hintText: "Search by Order ID or Name...",
        prefixIcon: const Icon(Icons.search, size: 20),
        filled: true,
        fillColor: GlobalColors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide:
              BorderSide(color: AppColors.primaryBlue.withOpacity(0.3)),
        ),
      ),
    );
  }

  // ================= ORDER CARD =================

  Widget _orderCard(Map<String, dynamic> data) {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ---------- TOP ROW ----------
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          data["id"],
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryBlue,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          data["time"],
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppColors.mutedText,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      data["name"],
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryText,
                      ),
                    ),
                  ],
                ),
              ),

              // ---------- AMOUNT + STATUS ----------
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    data["amount"],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: (data["statusColor"] as Color).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      data["status"].toUpperCase(),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: data["statusColor"],
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 14),

          // ---------- PRODUCT ----------
          Row(
            children: [
              const Icon(
                Icons.inventory_2_outlined,
                size: 18,
                color: AppColors.secondaryText,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  data["product"],
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.secondaryText,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // ---------- VIEW DETAILS ----------
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: () {
                // TODO: Navigate to pending order detail page
              },
              icon: const Icon(Icons.arrow_forward, size: 16),
              label: const Text(
                "View Details",
                style: TextStyle(fontSize: 12),
              ),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primaryBlue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
