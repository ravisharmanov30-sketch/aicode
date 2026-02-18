class TaxLogic {
  static const double stcgEquityRate = 20.0;
  static const double ltcgEquityRate = 12.5; // Updated Feb 2026
  static const double cess = 4.0; // Cess on Tax

  // --- Income Tax FY 2025-26 (New Regime) ---
  static double calculateNewRegimeTax(double taxableIncome) {
    if (taxableIncome <= 300000) return 0;
    
    double tax = 0;
    
    // Slab 1: 3-6L @ 5%
    if (taxableIncome > 300000) {
      double slabIncome = (taxableIncome > 600000) ? 300000 : (taxableIncome - 300000);
      tax += slabIncome * 0.05;
    }
    
    // Slab 2: 6-9L @ 10%
    if (taxableIncome > 600000) {
      double slabIncome = (taxableIncome > 900000) ? 300000 : (taxableIncome - 600000);
      tax += slabIncome * 0.10;
    }

    // Slab 3: 9-12L @ 15%
    if (taxableIncome > 900000) {
      double slabIncome = (taxableIncome > 1200000) ? 300000 : (taxableIncome - 900000);
      tax += slabIncome * 0.15;
    }

    // Slab 4: 12-15L @ 20%
    if (taxableIncome > 1200000) {
      double slabIncome = (taxableIncome > 1500000) ? 300000 : (taxableIncome - 1200000);
      tax += slabIncome * 0.20;
    }
    
    // Slab 5: >15L @ 30%
    if (taxableIncome > 1500000) {
      tax += (taxableIncome - 1500000) * 0.30;
    }

    // Section 87A Rebate (up to ₹25k tax if income <= 7L)
    if (taxableIncome <= 700000) return 0;

    return tax + (tax * cess / 100);
  }

  // --- Capital Gains ---
  static double calculateLTCG(double gainAmount) {
    // ₹1.25L exemption on Equity LTCG
    double taxableGain = (gainAmount > 125000) ? (gainAmount - 125000) : 0;
    return taxableGain * (ltcgEquityRate / 100);
  }

  static double calculateSTCG(double gainAmount) {
    return gainAmount * (stcgEquityRate / 100);
  }
}
