import 'package:flutter/material.dart';

class TrackOrderScreen extends StatelessWidget {
  final String orderId;
  const TrackOrderScreen({super.key, required this.orderId});

  static const Color primary = Color(0xFF135BEC);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),
      appBar: AppBar(
        backgroundColor: primary,
        elevation: 0,
        title: const Text(
          "Track Delivery",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          /// DRIVER CARD (CALL OPTION REMOVED)
          Container(
            margin: const EdgeInsets.fromLTRB(16, 16, 16, 10),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: LinearGradient(
                colors: [primary, primary.withOpacity(0.85)],
              ),
              boxShadow: [
                BoxShadow(
                  color: primary.withOpacity(0.35),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                )
              ],
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 28,
                  backgroundImage:
                      NetworkImage("https://i.pravatar.cc/150?img=12"),
                ),
                const SizedBox(width: 14),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Mike R",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        "Truck #TX-409 • Cattle Feed Unit",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          /// CONTENT
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _infoCard(
                    icon: Icons.receipt_long,
                    title: "Order ID",
                    value: orderId,
                  ),
                  _infoCard(
                    icon: Icons.location_on,
                    title: "Current Location",
                    value: "Near Springfield Highway 42",
                  ),
                  const SizedBox(height: 16),

                  /// DELIVERY PROGRESS
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: Offset(0, 6),
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Delivery Progress",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 22),

                        _timelineStep(
                          icon: Icons.inventory_2,
                          title: "Order Placed",
                          subtitle: "Order successfully confirmed",
                          time: "10:00 AM",
                          status: StepStatus.done,
                        ),
                        _timelineStep(
                          icon: Icons.check_circle,
                          title: "Packed & Ready",
                          subtitle: "Feed packed and ready",
                          time: "11:30 AM",
                          status: StepStatus.done,
                        ),
                        _timelineStep(
                          icon: Icons.local_shipping,
                          title: "Out for Delivery",
                          subtitle: "Driver is heading to your farm",
                          time: "Now",
                          status: StepStatus.active,
                        ),
                        _timelineStep(
                          icon: Icons.home,
                          title: "Delivered",
                          subtitle: "Expected at main gate",
                          time: "2:00 PM",
                          status: StepStatus.pending,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  /// INFO CARD
  Widget _infoCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: primary),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  /// TIMELINE STEP
  Widget _timelineStep({
    required IconData icon,
    required String title,
    required String subtitle,
    required String time,
    required StepStatus status,
  }) {
    Color color = status == StepStatus.active
        ? primary
        : status == StepStatus.done
            ? Colors.green
            : Colors.grey;

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: Colors.white, size: 18),
              ),
              Container(
                width: 2,
                height: 42,
                color: Colors.grey.shade300,
              ),
            ],
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                    Text(
                      time,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

enum StepStatus { done, active, pending }



// import 'package:flutter/material.dart';
// import 'package:mega_pro/global/global_variables.dart';

// class TrackOrderScreen extends StatelessWidget {
//   final String orderId;

//   const TrackOrderScreen({super.key, required this.orderId});

//   @override
//   Widget build(BuildContext context) {
//     Color primary = GlobalColors.primaryBlue;

//     return Scaffold(
//       backgroundColor: AppColors.softGreyBg,
//       appBar: AppBar(
//         backgroundColor: primary,
//         elevation: 0,
//         centerTitle: true,
//         title: const Text(
//           "Feed Order Form",
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         leading: IconButton(
//           icon:
//               const Icon(Icons.arrow_back_ios_new, color: Colors.white),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: SafeArea(
//         child: Column(
//           children: [
//             Expanded(
//               child: SingleChildScrollView(
//                 padding: const EdgeInsets.all(16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     /// ORDER CARD
//                     Card(
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(16)),
//                       elevation: 4,
//                       shadowColor: AppColors.borderGrey,
//                       child: Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: Column(
//                           children: [
//                             Row(
//                               mainAxisAlignment:
//                                   MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Column(
//                                   crossAxisAlignment:
//                                       CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       "Order Number",
//                                       style: TextStyle(
//                                         fontSize: 12,
//                                         color:
//                                             AppColors.secondaryText,
//                                       ),
//                                     ),
//                                     const SizedBox(height: 4),
//                                     Text(
//                                       orderId,
//                                       style: const TextStyle(
//                                         fontSize: 18,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 Container(
//                                   padding:
//                                       const EdgeInsets.symmetric(
//                                           horizontal: 12,
//                                           vertical: 4),
//                                   decoration: BoxDecoration(
//                                     color:
//                                         AppColors.successLight,
//                                     borderRadius:
//                                         BorderRadius.circular(50),
//                                   ),
//                                   child: Row(
//                                     children: const [
//                                       Icon(Icons.check_circle,
//                                           color:
//                                               GlobalColors.success,
//                                           size: 16),
//                                       SizedBox(width: 4),
//                                       Text(
//                                         "Paid",
//                                         style: TextStyle(
//                                             fontSize: 12,
//                                             fontWeight:
//                                                 FontWeight.bold),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             const Divider(height: 24),
//                             Row(
//                               crossAxisAlignment:
//                                   CrossAxisAlignment.start,
//                               children: [
//                                 Container(
//                                   width: 48,
//                                   height: 48,
//                                   decoration: BoxDecoration(
//                                     color: AppColors.lightBlue,
//                                     borderRadius:
//                                         BorderRadius.circular(12),
//                                   ),
//                                   child: Icon(Icons.location_on,
//                                       color: primary, size: 24),
//                                 ),
//                                 const SizedBox(width: 12),
//                                 Expanded(
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         "Current Location",
//                                         style: TextStyle(
//                                           fontSize: 10,
//                                           fontWeight:
//                                               FontWeight.bold,
//                                           color:
//                                               AppColors.secondaryText,
//                                         ),
//                                       ),
//                                       const SizedBox(height: 4),
//                                       const Text(
//                                         "Near Springfield Hwy 42",
//                                         style: TextStyle(
//                                             fontSize: 16,
//                                             fontWeight:
//                                                 FontWeight.bold),
//                                       ),
//                                       const SizedBox(height: 6),
//                                       Row(
//                                         children: [
//                                           Container(
//                                             width: 8,
//                                             height: 8,
//                                             decoration:
//                                                 const BoxDecoration(
//                                               color: GlobalColors
//                                                   .success,
//                                               shape: BoxShape.circle,
//                                             ),
//                                           ),
//                                           const SizedBox(width: 6),
//                                           Text(
//                                             "Updated just now",
//                                             style: TextStyle(
//                                               fontSize: 10,
//                                               color:
//                                                   AppColors.secondaryText,
//                                             ),
//                                           ),
//                                         ],
//                                       )
//                                     ],
//                                   ),
//                                 )
//                               ],
//                             ),
//                             const Divider(height: 24),
//                             Row(
//                               children: [
//                                 const CircleAvatar(
//                                   radius: 24,
//                                   backgroundImage: NetworkImage(
//                                       "https://lh3.googleusercontent.com/aida-public/AB6AXuAJAgWdMQjS9wZlonocS9M8prP0hFBjQ8rUEcYLH3vKs6fRMLkJvGCjwZotsTVIIruNC6_c0d0rz4O0tvJ_KZwz77yvpUjpqjjuLdbfZvRBze6ACUMDcMde__ijr8n_cLuOmC0R-uWmAcTmkWhSjyK1Mgt868_09_azJKqdiAGQ0lFkVAaTlN31Xf-AWpoAWUs3dU78wc_p5uidxzGoL9bo-Cfg3ArQBWqh3uUaH8S7sCurlLtU_08KkA8Xf_pwh1GQLHX_amZ3M5CR"),
//                                 ),
//                                 const SizedBox(width: 12),
//                                 Expanded(
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: const [
//                                       Text(
//                                         "Mike R.",
//                                         style: TextStyle(
//                                             fontWeight:
//                                                 FontWeight.bold,
//                                             fontSize: 14),
//                                       ),
//                                       Text(
//                                         "Truck #TX-409 • Cattle Feed Unit",
//                                         style: TextStyle(
//                                             fontSize: 12,
//                                             color:
//                                                 GlobalColors.textGrey),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 ElevatedButton(
//                                   onPressed: () {},
//                                   style:
//                                       ElevatedButton.styleFrom(
//                                     backgroundColor: primary,
//                                     shape:
//                                         RoundedRectangleBorder(
//                                       borderRadius:
//                                           BorderRadius.circular(12),
//                                     ),
//                                     padding:
//                                         const EdgeInsets.all(12),
//                                   ),
//                                   child: const Icon(Icons.call,
//                                       color: Colors.white),
//                                 )
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),

//                     const SizedBox(height: 20),

//                     /// DELIVERY PROGRESS
//                     Card(
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(16)),
//                       elevation: 4,
//                       shadowColor: AppColors.borderGrey,
//                       child: Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: Column(
//                           crossAxisAlignment:
//                               CrossAxisAlignment.start,
//                           children: [
//                             const Text(
//                               "Delivery Progress",
//                               style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight:
//                                       FontWeight.bold),
//                             ),
//                             const SizedBox(height: 16),
//                             Column(
//                               children: [
//                                 timelineStep(
//                                     Icons.inventory_2,
//                                     GlobalColors
//                                         .chartBackgroundBar,
//                                     "Order Placed",
//                                     "Your order has been received.",
//                                     "10:00 AM"),
//                                 timelineStep(
//                                     Icons.check_circle,
//                                     GlobalColors
//                                         .chartBackgroundBar,
//                                     "Packed & Ready",
//                                     "Quality check completed.",
//                                     "11:30 AM"),
//                                 timelineStep(
//                                     Icons.local_shipping,
//                                     GlobalColors.primaryBlue,
//                                     "Out for Delivery",
//                                     "Driver is on the way to your farm.",
//                                     "Now",
//                                     isActive: true),
//                                 timelineStep(
//                                     Icons.home,
//                                     AppColors.mutedText,
//                                     "Delivered",
//                                     "Expected arrival at main gate.",
//                                     "Est. 2:00 PM"),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget timelineStep(
//     IconData icon,
//     Color iconColor,
//     String title,
//     String subtitle,
//     String time, {
//     bool isActive = false,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 16.0),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Column(
//             children: [
//               Container(
//                 width: 32,
//                 height: 32,
//                 decoration: BoxDecoration(
//                   color: iconColor,
//                   shape: BoxShape.circle,
//                   boxShadow: isActive
//                       ? [
//                           BoxShadow(
//                             color: GlobalColors
//                                 .chartBackgroundBar,
//                             blurRadius: 8,
//                             spreadRadius: 1,
//                           )
//                         ]
//                       : null,
//                 ),
//                 child: Icon(icon,
//                     color: isActive
//                         ? Colors.white
//                         : GlobalColors.black,
//                     size: 18),
//               ),
//               Container(
//                 width: 2,
//                 height: 50,
//                 color: GlobalColors.chartGrid,
//               ),
//             ],
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment:
//                       MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       title,
//                       style: TextStyle(
//                         fontWeight: isActive
//                             ? FontWeight.bold
//                             : FontWeight.w600,
//                         fontSize: 14,
//                         color: isActive
//                             ? GlobalColors.primaryBlue
//                             : GlobalColors.black,
//                       ),
//                     ),
//                     Text(
//                       time,
//                       style: TextStyle(
//                         fontSize: 12,
//                         color: isActive
//                             ? GlobalColors.primaryBlue
//                             : GlobalColors.textGrey,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 2),
//                 Text(
//                   subtitle,
//                   style: const TextStyle(
//                     fontSize: 12,
//                     color: AppColors.secondaryText,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
