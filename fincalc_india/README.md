# FinCalc India 🇮🇳

A comprehensive financial calculator app for the Indian market, built with Flutter.

## Features 🚀

- **Investment:** SIP, Lumpsum, FD, RD.
- **Taxation (FY 2025-26):** 
  - New Regime vs Old Regime comparison.
  - Capital Gains (LTCG 12.5%, STCG 20%).
- **Loans:** EMI Calculator with amortization schedule.
- **Retirement:** EPF, NPS corpus estimator.

## Tech Stack 🛠️

- **Framework:** Flutter (Dart)
- **UI:** Material 3 Design
- **State Management:** SetState (Simple), Provider (Scalable)

## Getting Started

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/your-username/fincalc-india.git
    cd fincalc-india
    ```

2.  **Install dependencies:**
    ```bash
    flutter pub get
    ```

3.  **Run on Android/iOS:**
    ```bash
    flutter run
    ```

## Project Structure

```
lib/
├── main.dart             # Entry point & Routing
├── screens/              # UI Screens
│   ├── dashboard_screen.dart
│   ├── sip_calculator.dart
│   ├── income_tax_calculator.dart
│   └── placeholders.dart # Stubs for other calcs
├── utils/                # Business Logic
│   └── tax_logic.dart    # Indian Tax Rules (FY25-26)
└── widgets/              # Reusable UI components
```

## License

MIT
