import 'package:flutter/material.dart';
import '../utils/tax_logic.dart';

class IncomeTaxCalculator extends StatefulWidget {
  const IncomeTaxCalculator({super.key});

  @override
  State<IncomeTaxCalculator> createState() => _IncomeTaxCalculatorState();
}

class _IncomeTaxCalculatorState extends State<IncomeTaxCalculator> {
  final TextEditingController _incomeController = TextEditingController(text: '1200000');
  double _tax = 0;
  String _regime = 'New';

  void _calculate() {
    double income = double.tryParse(_incomeController.text) ?? 0;
    setState(() {
      _tax = TaxLogic.calculateNewRegimeTax(income);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Income Tax Calculator')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<String>(
              value: _regime,
              items: const [
                DropdownMenuItem(value: 'New', child: Text('New Regime (FY 2025-26)')),
                DropdownMenuItem(value: 'Old', child: Text('Old Regime (Approx)')),
              ],
              onChanged: (value) {
                setState(() {
                  _regime = value!;
                });
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _incomeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Annual Income (₹)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculate,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Calculate Tax'),
            ),
            const SizedBox(height: 30),
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text('Estimated Tax (incl. Cess)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Text(
                      '₹${_tax.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 24, color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
