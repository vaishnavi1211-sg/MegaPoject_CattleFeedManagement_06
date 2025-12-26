import 'package:flutter/material.dart';

class CattleFeedOrderScreen extends StatefulWidget {
  const CattleFeedOrderScreen({super.key});

  @override
  State<CattleFeedOrderScreen> createState() => _CattleFeedOrderScreenState();
}

class _CattleFeedOrderScreenState extends State<CattleFeedOrderScreen> {
  double feedQuantity = 0.0;
  String? selectedCategory;

  final TextEditingController orderIdController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();

  List<String> categories = [
    "Forages",
    "Concentrates",
    "Protein Meals",
    "Supplements",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2563EB),
        elevation: 2,
        centerTitle: true,
                iconTheme: const IconThemeData(color: Colors.white,),

        title: const Text(
          "Feed Order Form",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 120),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            _titleHeader("Order Details"),
            _buildCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLabel("Order Reference ID"),
                  _buildTextField(
                    controller: orderIdController,
                    hint: "Enter Order ID",
                    icon: Icons.tag,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            _titleHeader("Customer Details"),
            _buildCard(
              child: Column(
                children: [
                  _buildLabel("Full Name"),
                  _buildTextField(
                    controller: nameController,
                    hint: "e.g. John Doe",
                  ),
                  const SizedBox(height: 18),

                  _buildLabel("Delivery Address"),
                  _buildTextField(
                    controller: addressController,
                    hint: "e.g. 123 Farm Lane",
                    icon: Icons.location_on,
                  ),
                  const SizedBox(height: 18),

                  _buildLabel("Mobile Number"),
                  _buildTextField(
                    controller: mobileController,
                    hint: "10 digit mobile number",
                    icon: Icons.call,
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            _titleHeader("Order Specifications"),
            _buildCard(
              child: Column(
                children: [
                  _buildLabel("Product Category"),
                  _buildDropdown(),
                  const SizedBox(height: 20),

                  _buildLabel("Feed Quantity (Tons)"),
                  _buildQuantityInput(),
                ],
              ),
            ),

            const SizedBox(height: 25),
            _buildDeliveryCard(),
          ],
        ),
      ),

      bottomNavigationBar: _buildFooterButton(),
    );
  }

  // --------------------------------------------------------
  Widget _titleHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w800,
          color: Color(0xFF1E3A8A),
        ),
      ),
    );
  }

  Widget _buildCard({required Widget child}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.shade100,
              blurRadius: 18,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: child,
      ),
    );
  }

  Widget _buildLabel(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: Color(0xFF64748B),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    IconData? icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return SizedBox(
      height: 55,
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: const Color(0xFFF9FAFB),
          suffixIcon:
              icon != null ? Icon(icon, color: const Color(0xFF2563EB)) : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown() {
    return Container(
      height: 55,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue.shade100),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: const Text("Select Category"),
          value: selectedCategory,
          items: categories
              .map((c) => DropdownMenuItem(value: c, child: Text(c)))
              .toList(),
          onChanged: (value) => setState(() => selectedCategory = value),
        ),
      ),
    );
  }

  Widget _buildQuantityInput() {
    return SizedBox(
      height: 60,
      child: TextField(
        controller: quantityController,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        onChanged: (v) {
          setState(() {
            feedQuantity = double.tryParse(v) ?? 0.0;
          });
        },
        decoration: InputDecoration(
          hintText: "Enter Quantity",
          suffixText: "Tons",
          prefixIcon: const Icon(Icons.scale, color: Color(0xFF2563EB)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
    );
  }

  Widget _buildDeliveryCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          color: Colors.white,
          border: Border.all(color: Colors.blue.shade100),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Total Load",
                style: TextStyle(fontSize: 14, color: Colors.grey)),
            Text("${feedQuantity.toStringAsFixed(1)} T",
                style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E3A8A))),
          ],
        ),
      ),
    );
  }

  Widget _buildFooterButton() {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: SizedBox(
        height: 55,
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF2563EB),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
          onPressed: _placeOrder,
          child: const Text(
            "Place Order",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }

  // --------------------------------------------------------
  void _placeOrder() {
    final mobile = mobileController.text.trim();

    if (mobile.length != 10 || int.tryParse(mobile) == null) {
      _showError("Enter valid 10 digit mobile number");
      return;
    }

    if (feedQuantity <= 0 || selectedCategory == null) {
      _showError("Please fill all required fields");
      return;
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Order Successful ✅"),
        content: Text(
            "Mobile: $mobile\nQuantity: ${feedQuantity.toStringAsFixed(1)} Tons"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          )
        ],
      ),
    );
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg)));
  }
}