import 'dart:math';

class InvestmentLogic {
  // --- FD Calculator ---
  static double calculateFD(double principal, double rate, double years) {
    // Compound Interest: A = P(1 + r/n)^(nt)
    // Assuming quarterly compounding (n=4) for standard Indian FDs
    return principal * pow((1 + (rate / 100) / 4), 4 * years);
  }

  // --- RD Calculator ---
  static double calculateRD(double monthlyDeposit, double rate, double months) {
    // RD Formula: M = P * n + P * n(n+1)/2 * r/12/100 (Simple Interest approximation often used)
    // Precise Compounding: M = P * ((1+r/400)^(4n/12) - 1) / (1-(1+r/400)^(-1/3)) ... messy.
    // Standard Bank Formula (Quarterly Compounding):
    double r = rate / 100;
    double maturityAmount = 0;
    for (int i = 0; i < months; i++) {
      // Each installment compounds for remaining months
      double monthsRemaining = months - i;
      maturityAmount += monthlyDeposit * pow((1 + r / 4), 4 * (monthsRemaining / 12));
    }
    return maturityAmount;
  }

  // --- EMI Calculator ---
  static double calculateEMI(double principal, double rate, double tenureYears) {
    double r = rate / 12 / 100; // Monthly rate
    double n = tenureYears * 12; // Months
    // E = P * r * (1+r)^n / ((1+r)^n - 1)
    return (principal * r * pow(1 + r, n)) / (pow(1 + r, n) - 1);
  }

  // --- SWP Calculator ---
  static Map<String, dynamic> calculateSWP(double investment, double withdrawal, double rate, double years) {
    double balance = investment;
    double monthlyRate = rate / 12 / 100;
    int months = (years * 12).toInt();
    double totalWithdrawn = 0;

    for (int i = 0; i < months; i++) {
      if (balance <= 0) break;
      double interest = balance * monthlyRate;
      balance += interest;
      balance -= withdrawal;
      totalWithdrawn += withdrawal;
    }
    return {
      'finalBalance': balance > 0 ? balance : 0,
      'totalWithdrawn': totalWithdrawn
    };
  }

  // --- PPF Calculator ---
  static double calculatePPF(double annualDeposit, double years) {
    // Current PPF Rate approx 7.1% (Variable)
    double rate = 7.1 / 100;
    double amount = 0;
    for (int i = 0; i < years; i++) {
      amount = (amount + annualDeposit) * (1 + rate);
    }
    return amount;
  }
}
