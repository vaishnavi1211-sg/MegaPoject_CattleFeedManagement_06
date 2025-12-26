import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mega_pro/global/global_variables.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Access the initialized Supabase client
final supabase = Supabase.instance.client;

class MakeOrderPage extends StatefulWidget {
  const MakeOrderPage({super.key});

  @override
  State<MakeOrderPage> createState() => _MakeOrderPageState();
}

class _MakeOrderPageState extends State<MakeOrderPage> {
  final _formKey = GlobalKey<FormState>();

  // Form Controllers and State
  final TextEditingController _customerNameController =
      TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  // Hardcoded lists for form dropdowns
  final List<String> _districts = ['Kolhapur', 'Sangli', 'Pune'];
  final List<String> _productCategories = ['Feed', 'Fertilizer', 'Seeds'];
  final List<String> _orderStatuses = ['Pending', 'Dispatched', 'Delivered'];

  String? _selectedDistrict;
  String? _selectedCategory;
  String? _selectedStatus;

  // Placeholder for sales rep ID
  final int _salesRepId = 3;

  // --- SUPABASE INSERT FUNCTION ---
  Future<void> _submitOrder() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        final String talukaPlaceholder =
            _selectedDistrict == 'Kolhapur' ? 'Karvir' : 'Miraj';

        final Map<String, dynamic> newOrder = {
          'order_date':
              DateTime.now().toIso8601String().substring(0, 10),
          'district': _selectedDistrict!,
          'taluka': talukaPlaceholder,
          'customer_name': _customerNameController.text,
          'sales_rep_id': _salesRepId,
          'product_category': _selectedCategory!,
          'quantity_tons': double.parse(_quantityController.text),
          'status': _selectedStatus!,
        };

        await supabase.from('orders').insert(newOrder);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  'Order for ${_customerNameController.text} logged successfully!'),
            ),
          );
          Navigator.pop(context);
        }
      } on PostgrestException catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error submitting order: ${e.message}')),
          );
        }
      } catch (_) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('An unexpected error occurred.')),
          );
        }
      }
    }
  }

  // --- BUILD METHOD ---
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalColors.primaryBlue,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          "Log New Order",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Order Details",
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              /// CUSTOMER NAME
              TextFormField(
                controller: _customerNameController,
                decoration: const InputDecoration(
                  labelText: 'Customer/Retailer Name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person_outline),
                ),
                validator: (value) =>
                    value == null || value.isEmpty
                        ? 'Please enter the customer name'
                        : null,
              ),
              const SizedBox(height: 16),

              /// DISTRICT
              DropdownButtonFormField<String>(
                value: _selectedDistrict,
                decoration: const InputDecoration(
                  labelText: 'District',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.location_on),
                ),
                items: _districts
                    .map(
                      (v) => DropdownMenuItem(
                        value: v,
                        child: Text(v),
                      ),
                    )
                    .toList(),
                onChanged: (v) => setState(() => _selectedDistrict = v),
                validator: (v) =>
                    v == null ? 'Select a district' : null,
              ),
              const SizedBox(height: 16),

              /// PRODUCT CATEGORY
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: const InputDecoration(
                  labelText: 'Product Category',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.category),
                ),
                items: _productCategories
                    .map(
                      (v) => DropdownMenuItem(
                        value: v,
                        child: Text(v),
                      ),
                    )
                    .toList(),
                onChanged: (v) => setState(() => _selectedCategory = v),
                validator: (v) =>
                    v == null ? 'Select a product category' : null,
              ),
              const SizedBox(height: 16),

              /// QUANTITY
              TextFormField(
                controller: _quantityController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Quantity (Tons)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.scale),
                ),
                validator: (v) =>
                    v == null || double.tryParse(v) == null
                        ? 'Enter a valid quantity in Tons'
                        : null,
              ),
              const SizedBox(height: 16),

              /// STATUS
              DropdownButtonFormField<String>(
                value: _selectedStatus,
                decoration: const InputDecoration(
                  labelText: 'Order Status',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.info_outline),
                ),
                items: _orderStatuses
                    .map(
                      (v) => DropdownMenuItem(
                        value: v,
                        child: Text(v),
                      ),
                    )
                    .toList(),
                onChanged: (v) => setState(() => _selectedStatus = v),
                validator: (v) =>
                    v == null ? 'Select an order status' : null,
              ),
              const SizedBox(height: 32),

              /// SUBMIT BUTTON
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton.icon(
                  onPressed: _submitOrder,
                  icon: const Icon(Icons.save),
                  label: Text(
                    "Log Order",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: GlobalColors.primaryBlue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
