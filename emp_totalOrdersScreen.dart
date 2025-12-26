import 'package:flutter/material.dart';
import 'package:mega_pro/global/global_variables.dart';

class TotalOrdersPage extends StatefulWidget {
  const TotalOrdersPage({super.key});

  @override
  State<TotalOrdersPage> createState() => _TotalOrdersPageState();
}

class _TotalOrdersPageState extends State<TotalOrdersPage> {
  final TextEditingController _searchCtrl = TextEditingController();

  final List<Map<String, dynamic>> _allOrders = [
    {
      "date": "TODAY, 25 OCT",
      "name": "Krishna Dairy Farm",
      "code": "KD",
      "order": "#8821",
      "bags": "50 Bags",
      "status": "Pending",
      "color": GlobalColors.warning,
    },
    {
      "date": "TODAY, 25 OCT",
      "name": "Anand Traders",
      "code": "AT",
      "order": "#8820",
      "bags": "15 Bags",
      "status": "Dispatched",
      "color": AppColors.primaryBlue,
    },
    {
      "date": "YESTERDAY, 24 OCT",
      "name": "Goshala #4",
      "code": "G4",
      "order": "#8815",
      "bags": "10 Bags",
      "status": "Delivered",
      "color": GlobalColors.success,
    },
    {
      "date": "YESTERDAY, 24 OCT",
      "name": "Vijay Feed Center",
      "code": "VF",
      "order": "#8812",
      "bags": "25 Bags",
      "status": "Cancelled",
      "color": GlobalColors.danger,
    },
    {
      "date": "OLDER",
      "name": "Shree Ram Dairy",
      "code": "SR",
      "order": "#8799",
      "bags": "40 Bags",
      "status": "Delivered",
      "color": GlobalColors.success,
    },
  ];

  int _visibleCount = 4;
  String _query = "";

  @override
  Widget build(BuildContext context) {
    final filtered = _allOrders.where((o) {
      return o["name"].toLowerCase().contains(_query) ||
          o["order"].toLowerCase().contains(_query);
    }).toList();

    final visibleOrders = filtered.take(_visibleCount).toList();

    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,

      // ---------- APP BAR ----------
      appBar: AppBar(
        backgroundColor: GlobalColors.primaryBlue,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Total Orders",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.cardBg,
              ),
            ),
            SizedBox(height: 2),
            Text(
              "Consolidated view",
              style: TextStyle(
                fontSize: 13,
                color: AppColors.mutedText,
              ),
            ),
          ],
        ),
      ),

      // ---------- BODY ----------
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _searchBox(),
          const SizedBox(height: 18),

          for (int i = 0; i < visibleOrders.length; i++)
            _buildOrderWithHeader(visibleOrders, i),

          if (_visibleCount < filtered.length) _loadMoreButton(),
        ],
      ),
    );
  }

  // ================= UI =================

  Widget _searchBox() {
    return TextField(
      controller: _searchCtrl,
      onChanged: (v) {
        setState(() => _query = v.toLowerCase());
      },
      decoration: InputDecoration(
        hintText: "Search orders...",
        prefixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: GlobalColors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildOrderWithHeader(List orders, int index) {
    final current = orders[index];
    final showHeader =
        index == 0 || orders[index - 1]["date"] != current["date"];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showHeader)
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 8),
            child: Text(
              current["date"],
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: AppColors.mutedText,
                letterSpacing: 0.8,
              ),
            ),
          ),
        _orderCard(current),
      ],
    );
  }

  Widget _orderCard(Map data) {
    final disabled = data["status"] == "Cancelled";

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
        children: [
          CircleAvatar(
            radius: 26,
            backgroundColor: AppColors.lightestBlue,
            child: Text(
              data["code"],
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryBlue,
              ),
            ),
          ),
          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data["name"],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: disabled
                        ? AppColors.mutedText
                        : AppColors.primaryText,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Text(
                      data["order"],
                      style: const TextStyle(
                        color: AppColors.primaryBlue,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Text("•", style: TextStyle(color: AppColors.mutedText)),
                    const SizedBox(width: 6),
                    Text(
                      data["bags"],
                      style:
                          const TextStyle(color: AppColors.secondaryText),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: (data["color"] as Color).withOpacity(0.12),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              data["status"],
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: data["color"],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _loadMoreButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Center(
        child: TextButton.icon(
          onPressed: () {
            setState(() {
              _visibleCount += 2;
            });
          },
          icon: const Icon(Icons.expand_more),
          label: const Text(
            "Load More",
            style: TextStyle(fontSize: 15),
          ),
          style: TextButton.styleFrom(
            foregroundColor: AppColors.primaryBlue,
            backgroundColor: AppColors.lightBlue,
            padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ),
    );
  }
}
