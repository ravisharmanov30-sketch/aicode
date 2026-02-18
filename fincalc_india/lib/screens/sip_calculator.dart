import 'dart:math';
import 'package:flutter/material.dart';

class SIPCalculator extends StatefulWidget {
  const SIPCalculator({super.key});

  @override
  State<SIPCalculator> createState() => _SIPCalculatorState();
}

class _SIPCalculatorState extends State<SIPCalculator> {
  final TextEditingController _amountController = TextEditingController(text: '5000');
  final TextEditingController _rateController = TextEditingController(text: '12');
  final TextEditingController _yearsController = TextEditingController(text: '10');

  double _investedAmount = 0;
  double _estReturns = 0;
  double _totalValue = 0;

  void _calculate() {
    double p = double.tryParse(_amountController.text) ?? 0;
    double r = double.tryParse(_rateController.text) ?? 0;
    double n = double.tryParse(_yearsController.text) ?? 0;

    double i = r / 12 / 100; // Monthly Rate
    double months = n * 12;

    // SIP Formula: M = P × ({[1 + i]^n - 1} / i) × (1 + i)
    double m = p * ((pow(1 + i, months) - 1) / i) * (1 + i);

    setState(() {
      _investedAmount = p * months;
      _totalValue = m;
      _estReturns = m - _investedAmount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SIP Calculator')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildInput("Monthly Investment (₹)", _amountController),
            _buildInput("Expected Return Rate (%)", _rateController),
            _buildInput("Time Period (Years)", _yearsController),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculate,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Calculate'),
            ),
            const SizedBox(height: 30),
            _buildResultCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildInput(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildResultCard() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _row('Invested Amount', '₹${_investedAmount.toStringAsFixed(0)}'),
            const Divider(),
            _row('Est. Returns', '₹${_estReturns.toStringAsFixed(0)}', color: Colors.green),
            const Divider(),
            _row('Total Value', '₹${_totalValue.toStringAsFixed(0)}', isBold: true),
          ],
        ),
      ),
    );
  }

  Widget _row(String label, String value, {bool isBold = false, Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
          Text(
            value,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: color ?? (isBold ? Colors.blue : Colors.black),
              fontSize: isBold ? 18 : 16,
            ),
          ),
        ],
      ),
    );
  }
}
