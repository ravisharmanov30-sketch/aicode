# AI Funnel Assessment Portal 🤖

A streamlined, enterprise-grade web application for submitting, evaluating, and tracking AI initiatives within an organization. Built with Python and Streamlit, this tool acts as a centralized funnel to govern the lifecycle of AI projects from ideation to production.

![Streamlit](https://img.shields.io/badge/Streamlit-FF4B4B?style=for-the-badge&logo=Streamlit&logoColor=white)
![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)

## 🌟 Key Features

The application is divided into three core modules designed for different stakeholders:

### 1. 📝 Idea Submission (Employee Facing)
- **Structured Intake Form:** Captures critical details including Problem Statement, Expected ROI/Benefit, Executive Sponsor, and Strategic Priority.
- **Department Tagging:** Categorizes ideas by department (IT, HR, Finance, etc.) for better portfolio management.
- **Automated Validation:** Ensures all required fields are populated before submission.

### 2. 🔍 Evaluator Dashboard (Review Committee Facing)
A multi-stage governance workflow to filter and approve high-potential use cases:
- **Stage 1: Screening:** Rapid "Pass/Fail" based on alignment with organizational goals.
- **Stage 2: Business Value Assessment:** Quantitative scoring (Low to Critical) of potential impact with reviewer notes.
- **Stage 3: Risk Review:** detailed checklist for Data Privacy, Tech Debt, and Regulatory Compliance.
- **Final Decision:** Formal "Approve" or "Reject" outcome with recorded risk factors.

### 3. 📊 Analytics & Portfolio View (Leadership Facing)
- **Real-time Metrics:** Track Total Ideas, Approval Rates, and Backlog size.
- **Visualizations:**
  - *Ideas by Department:* Identify which teams are innovating.
  - *Status Distribution:* Monitor the bottleneck in the evaluation pipeline.
  - *Value Matrix:* See where the high-value opportunities lie.

## 🛠️ Tech Stack

- **Frontend/Backend:** [Streamlit](https://streamlit.io/)
- **Data Persistence:** Local JSON-based storage (`ideas_db.json`) for zero-setup deployment.
- **Data Processing:** Pandas

## 🚀 Getting Started

### Prerequisites
- Python 3.8+
- pip

### Installation

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/ravisharmanov30-sketch/aicode.git
    cd aicode
    ```

2.  **Install dependencies:**
    ```bash
    pip install -r requirements.txt
    ```

3.  **Run the application:**
    ```bash
    streamlit run ai_assessment_app.py
    ```

4.  **Access the App:**
    Open your browser and navigate to `http://localhost:8501`.

## 📂 Project Structure

```
aicode/
├── ai_assessment_app.py   # Main application logic
├── ideas_db.json          # Local database (auto-generated on first run)
├── requirements.txt       # Python dependencies
└── README.md              # Project documentation
```

## 🔮 Future Roadmap

- [ ] **User Authentication:** Integrate SSO/OAuth for secure access.
- [ ] **Database Integration:** Migrate from JSON to PostgreSQL/SQLite for scalability.
- [ ] **Email Notifications:** Auto-alert sponsors when status changes.
- [ ] **ROI Calculator:** Advanced modeling for cost vs. benefit analysis.

## 🤝 Contributing

Contributions are welcome! Please fork the repository and submit a pull request.

## 📄 License

This project is open-source and available under the MIT License.
