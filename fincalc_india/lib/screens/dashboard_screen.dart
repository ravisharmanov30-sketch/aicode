import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  final List<Map<String, dynamic>> _calculators = const [
    {'title': 'SIP', 'icon': Icons.trending_up, 'route': '/sip'},
    {'title': 'FD/RD', 'icon': Icons.savings, 'route': '/fd_rd'},
    {'title': 'Loan EMI', 'icon': Icons.account_balance, 'route': '/emi'},
    {'title': 'Income Tax', 'icon': Icons.description, 'route': '/tax'},
    {'title': 'Capital Gains', 'icon': Icons.attach_money, 'route': '/gains'},
    {'title': 'PF/NPS', 'icon': Icons.elderly, 'route': '/retirement'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FinCalc India'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.1,
          ),
          itemCount: _calculators.length,
          itemBuilder: (context, index) {
            final calc = _calculators[index];
            return Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: InkWell(
                onTap: () {
                  // Navigate to specific calculator (Placeholder for now)
                  Navigator.pushNamed(context, calc['route']);
                },
                borderRadius: BorderRadius.circular(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      calc['icon'],
                      size: 40,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      calc['title'],
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
