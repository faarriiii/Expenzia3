import 'package:exenzia/database/database_store.dart';
import 'package:exenzia/model/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddExpenses extends StatefulWidget {
  final TransactionModel? transaction;

  const AddExpenses({super.key,  this.transaction});

  @override
  State<AddExpenses> createState() => _AddExpensesState();
}

class _AddExpensesState extends State<AddExpenses> {
  late String _selectedType;
  late TextEditingController _nameController;
  late TextEditingController _amountController;
  late DateTime _selectedDate;

  final Color primaryGreen = const Color(0xFF2C7A70);

  @override
  void initState() {
    super.initState();
    // Initialize form with existing SQL data
    _selectedType = widget.transaction!.transactionType; // e.g. 'Expense[span_1](start_span)'[span_1](end_span)
    _nameController = TextEditingController(text: widget.transaction?.name); // e.g. 'Upwork[span_2](start_span)'[span_2](end_span)
    _amountController = TextEditingController(
      text: widget.transaction?.amount.toStringAsFixed(2), // e.g. '850.00[span_3](start_span)'[span_3](end_span)
    );
    _selectedDate = widget.transaction!.date;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(primary: primaryGreen),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  Future<void> _saveTransaction() async {
    final rawAmount = _amountController.text.replaceAll(RegExp(r'[^0-9.]'), '');
    final parsedAmount = double.tryParse(rawAmount) ?? 0.0;

    final updated = TransactionModel(
      id: widget.transaction?.id,
      transactionType: _selectedType,
      name: _nameController.text.trim(),
      amount: parsedAmount,
      date: _selectedDate,
    );

    // SQL UPDATE execution
    await DatabaseHelper.instance.updateTransaction(updated);

    if (mounted) {
      Navigator.pop(context, true); // Pop screen and notify caller of changes
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryGreen, // Top bar background[span_4](start_span)[span_4](end_span)
      appBar: AppBar(
        title: const Text('Edit Transaction', style: TextStyle(color: Colors.white)), //[span_5](start_span)[span_5](end_span)
        backgroundColor: primaryGreen,
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white), //[span_6](start_span)[span_6](end_span)
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 28.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // TRANSACTION TYPE
                    _buildLabel('TRANSACTION TYPE'), //[span_7](start_span)[span_7](end_span)
                    DropdownButtonFormField<String>(
                      value: _selectedType,
                      items: ['Expense', 'Income'].map((val) {
                        return DropdownMenuItem(value: val, child: Text(val));
                      }).toList(),
                      onChanged: (val) => setState(() => _selectedType = val!),
                      decoration: _inputDecoration(),
                    ),
                    const SizedBox(height: 20),

                    // NAME
                    _buildLabel('NAME'), //[span_8](start_span)[span_8](end_span)
                    TextFormField(
                      controller: _nameController,
                      decoration: _inputDecoration(),
                    ),
                    const SizedBox(height: 20),

                    // AMOUNT
                    _buildLabel('AMOUNT'), //[span_9](start_span)[span_9](end_span)
                    TextFormField(
                      controller: _amountController,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      decoration: _inputDecoration(
                        prefixText: '₹ ', //[span_10](start_span)[span_10](end_span)
                        suffix: GestureDetector(
                          onTap: () => _amountController.clear(), //[span_11](start_span)[span_11](end_span)
                          child: Text(
                            'Clear', //[span_12](start_span)[span_12](end_span)
                            style: TextStyle(
                              color: primaryGreen,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // DATE
                    _buildLabel('DATE'), //[span_13](start_span)[span_13](end_span)
                    InkWell(
                      onTap: _pickDate,
                      child: InputDecorator(
                        decoration: _inputDecoration(
                          suffixIcon: const Icon(Icons.calendar_month, color: Colors.grey), //[span_14](start_span)[span_14](end_span)
                        ),
                        child: Text(
                          DateFormat('EEE, d MMM yyyy').format(_selectedDate), // Displays e.g., "Tue, 22 Feb 2026[span_15](start_span)"[span_15](end_span)
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),

                    const Spacer(),

                    // SAVE BUTTON
                    ElevatedButton(
                      onPressed: _saveTransaction, //[span_16](start_span)[span_16](end_span)
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryGreen, //[span_17](start_span)[span_17](end_span)
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'Save', //[span_18](start_span)[span_18](end_span)
                        style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.grey),
      ),
    );
  }

  InputDecoration _inputDecoration({String? prefixText, Widget? suffix, Widget? suffixIcon}) {
    return InputDecoration(
      prefixText: prefixText,
      prefixStyle: const TextStyle(fontSize: 16, color: Colors.black),
      suffix: suffix,
      suffixIcon: suffixIcon,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: primaryGreen, width: 1.5),
      ),
    );
  }
}