import 'package:flutter/material.dart';
import 'package:mega_pro/employee/emp_track_order_page.dart';
import 'package:mega_pro/global/global_variables.dart';

class RecentOrdersScreen extends StatelessWidget {
  const RecentOrdersScreen({super.key});

  final List<Map<String, dynamic>> orders = const [
    {
      "status": "In Transit",
      "statusColor": GlobalColors.primaryBlue,
      "orderId": "#ORD-4920",
      "product": "Premium Dairy Mix",
      "date": "Oct 24, 2023",
      "quantity": "50 Bags",
      "image":
          "https://lh3.googleusercontent.com/aida-public/AB6AXuAJyaDiUMG1P_tfAhYQebWqHlf_dD6JGs74gnsli14jkCXqPsKkHOTXxoqCn8N2udfeZkhyk_Gx5ALoFO67guZfei4qytYz0SCU-A7ImT45CveLNz1VPBcQAPklHJfYTbrLPjxBIeTIUntxAzxE6xfH-kUpaTu2y2NdnIKqZIC-SgUrfhcpujkLYasRFXaZEj18UP8u_ULcNGiobhBieNBPrut7JpfV2wV6bRVe2ve5nThTFHg5ceZxlTo4cd79hVOCgRwzO0M_R6lI"
    },
    {
      "status": "Processing",
      "statusColor": GlobalColors.warning,
      "orderId": "#ORD-4890",
      "product": "High-Yield Cattle Feed",
      "date": "Oct 23, 2023",
      "quantity": "100 Bags",
      "image":
          "https://lh3.googleusercontent.com/aida-public/AB6AXuAgRL4DcCIPWxXYnVnVYLWrlfq8Wjjsl_bfyhsBscmqfro4sqvb7tnkjasS7o-9Uqzo0bQeR0_RT8DdH4FWstN_Exl9fi0fryZ6b5zc7-KHdV_YVBfGdnNCaZRpkgtj86CokEQ6vs9tKzsQgMr-Wr4nGhB4CNGtEGaMSu8QwMFhTtI-woh8hc5JdCJyTvfI6Az7St04j6EElKDYxO9_jWPbIi3JYY3SkE_gT_XH3u54JKvcZdHFyzffzmhx71beU3kMKhUORXngudsV"
    },
    {
      "status": "Delivered",
      "statusColor": GlobalColors.success,
      "orderId": "#ORD-4752",
      "product": "Standard Feed Mix",
      "date": "Oct 15, 2023",
      "quantity": "25 Bags",
      "image":
          "https://lh3.googleusercontent.com/aida-public/AB6AXuBFzHli_UvcCS220AkIVgULQiLxCWANYU2sMEVQhb6FYdKDhsRzy2Nf21Do4MqWPRhk5vVzdn0skCWF2PzsZ09ePo_p-7vHVAENBrcY5FjF_0S4sPDOtPGJhmhnbJANcBVhbNjWwhjklWMkhD37qi8zfn4GOZ0R8J4ND9KyaZEIUPYgQiUtG18W0gj5wbPyTjM6QGX4MR7TAx9zuBMreWJsIVn1PyJ5rDupyEZH2vlMXaLpx1TBGMnrGNnjLmhOVBnpIvrVFREJWot6"
    },
  ];

  @override
  Widget build(BuildContext context) {
    Color primary = GlobalColors.primaryBlue;
    Color primaryHover = AppColors.primaryBlue;

    return Scaffold(
      backgroundColor: AppColors.softGreyBg,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        elevation: 1,
        centerTitle: true,
        title: const Text(
          "Recent Orders",
          style: TextStyle(
            color: GlobalColors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: GlobalColors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.separated(
          itemCount: orders.length,
          separatorBuilder: (_, __) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final order = orders[index];
            return buildOrderCard(
              context,
              order,
              primary,
              primaryHover,
            );
          },
        ),
      ),
    );
  }

  Widget buildOrderCard(
    BuildContext context,
    Map<String, dynamic> order,
    Color primary,
    Color primaryHover,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: GlobalColors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.borderGrey),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowGrey,
            blurRadius: 4,
            spreadRadius: 1,
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: 64,
                  width: 64,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.borderGrey),
                    image: DecorationImage(
                      image: NetworkImage(order["image"]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color:
                              (order["statusColor"] as Color).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Text(
                          order["status"],
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: order["statusColor"],
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        order["orderId"],
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        order["product"],
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.secondaryText,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),

            const SizedBox(height: 12),
            Divider(color: AppColors.borderGrey),
            const SizedBox(height: 8),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Date",
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.mutedText,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      order["date"],
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      "Quantity",
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.mutedText,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      order["quantity"],
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 12),

            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        TrackOrderScreen(orderId: order["orderId"]),
                  ),
                );
              },
              icon: const Icon(Icons.local_shipping, size: 18),
              label: const Text("Track Order"),
              style: ElevatedButton.styleFrom(
                backgroundColor: primary,
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(44),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
