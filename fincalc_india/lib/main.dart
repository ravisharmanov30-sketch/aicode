import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'screens/dashboard_screen.dart';
import 'screens/sip_calculator.dart';
import 'screens/income_tax_calculator.dart';
import 'screens/placeholders.dart'; // Contains stubs for FD, EMI, Capital Gains, etc.

void main() {
  runApp(const FinCalcApp());
}

class FinCalcApp extends StatelessWidget {
  const FinCalcApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FinCalc India',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        textTheme: GoogleFonts.latoTextTheme(),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const DashboardScreen(),
        '/sip': (context) => const SIPCalculator(),
        '/fd_rd': (context) => const FDRDCalculator(),
        '/emi': (context) => const EMICalculator(),
        '/tax': (context) => const IncomeTaxCalculator(),
        '/gains': (context) => const CapitalGainsCalculator(),
        '/retirement': (context) => const RetirementCalculator(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
