import streamlit as st
import json
import os
import uuid
from datetime import datetime
import pandas as pd

# --- Configuration ---
DB_FILE = "ideas_db.json"
st.set_page_config(
    page_title="AI Ideas Assessment Portal",
    page_icon="🤖",
    layout="wide",
    initial_sidebar_state="expanded"
)

# --- Data Persistence ---
def load_data():
    if not os.path.exists(DB_FILE):
        return []
    try:
        with open(DB_FILE, "r") as f:
            return json.load(f)
    except json.JSONDecodeError:
        return []

def save_data(data):
    with open(DB_FILE, "w") as f:
        json.dump(data, f, indent=4)

# --- Helper Functions ---
def get_idea_by_id(ideas, idea_id):
    for idea in ideas:
        if idea["id"] == idea_id:
            return idea
    return None

def update_idea_status(ideas, idea_id, new_status, additional_data=None):
    for idea in ideas:
        if idea["id"] == idea_id:
            idea["status"] = new_status
            idea["updated_at"] = datetime.now().isoformat()
            if additional_data:
                idea.update(additional_data)
            save_data(ideas)
            return True
    return False

# --- UI Components ---
def render_header():
    st.title("🤖 AI Ideas Assessment Portal")
    st.markdown("---")

def render_sidebar():
    st.sidebar.header("Navigation")
    page = st.sidebar.radio("Go to", ["Submit Idea", "Evaluator Dashboard", "Analytics"])
    
    st.sidebar.markdown("---")
    st.sidebar.info(
        "**System Status**\n\n"
        "🟢 Database Active\n\n"
        "v1.0.0 | Enterprise Edition"
    )
    return page

# --- Pages ---

def page_submit_idea():
    st.subheader("📝 Submit New AI Initiative")
    st.markdown("Please provide details about your AI use case. Be specific about the problem and expected benefits.")
    
    with st.form("submission_form"):
        col1, col2 = st.columns(2)
        
        with col1:
            title = st.text_input("Idea Title", placeholder="e.g., Automated Customer Support Bot")
            department = st.selectbox("Department", ["IT", "HR", "Finance", "Sales", "Marketing", "Operations", "R&D"])
            
        with col2:
            sponsor = st.text_input("Executive Sponsor", placeholder="Name of Department Head")
            priority = st.selectbox("Strategic Priority", ["High", "Medium", "Low"])

        problem = st.text_area("Problem Statement", placeholder="Describe the current pain point or inefficiency...", height=100)
        benefit = st.text_area("Expected Benefit (ROI)", placeholder="Quantify efficiency gains, revenue increase, or cost reduction...", height=100)
        
        submitted = st.form_submit_button("Submit Proposal")
        
        if submitted:
            if title and problem and benefit:
                ideas = load_data()
                new_idea = {
                    "id": str(uuid.uuid4()),
                    "title": title,
                    "department": department,
                    "sponsor": sponsor,
                    "priority": priority,
                    "problem": problem,
                    "benefit": benefit,
                    "status": "Submitted",  # Initial status
                    "created_at": datetime.now().isoformat(),
                    "updated_at": datetime.now().isoformat(),
                    "screening_result": None,
                    "business_value": None,
                    "risk_score": None,
                    "final_decision": None
                }
                ideas.append(new_idea)
                save_data(ideas)
                st.success(f"✅ Idea '{title}' submitted successfully! It is now pending screening.")
            else:
                st.error("⚠️ Please fill in all required fields (Title, Problem, Benefit).")

def page_evaluator_dashboard():
    st.subheader("🔍 Evaluator Dashboard")
    
    ideas = load_data()
    if not ideas:
        st.info("No ideas found in the database.")
        return

    # Filter by Status tabs
    tab1, tab2, tab3, tab4, tab5 = st.tabs([
        "1. Screening (Pending)", 
        "2. Business Value", 
        "3. Risk Review", 
        "Completed",
        "All Ideas"
    ])

    # --- Stage 1: Screening ---
    with tab1:
        pending_screening = [i for i in ideas if i["status"] == "Submitted"]
        if not pending_screening:
            st.info("No ideas pending screening.")
        
        for idea in pending_screening:
            with st.expander(f"{idea['title']} ({idea['department']})", expanded=True):
                col1, col2 = st.columns([3, 1])
                with col1:
                    st.markdown(f"**Problem:** {idea['problem']}")
                    st.markdown(f"**Benefit:** {idea['benefit']}")
                with col2:
                    st.caption(f"Submitted: {idea['created_at'][:10]}")
                    st.caption(f"Priority: {idea['priority']}")
                
                st.markdown("---")
                st.markdown("**Action:**")
                c1, c2 = st.columns(2)
                with c1:
                    if st.button("✅ Pass Screening", key=f"pass_{idea['id']}"):
                        update_idea_status(ideas, idea['id'], "Screening Passed", {"screening_result": "Pass"})
                        st.rerun()
                with c2:
                    if st.button("❌ Reject (Misaligned)", key=f"fail_{idea['id']}"):
                        update_idea_status(ideas, idea['id'], "Rejected", {"screening_result": "Fail", "final_decision": "Rejected"})
                        st.rerun()

    # --- Stage 2: Business Value ---
    with tab2:
        pending_value = [i for i in ideas if i["status"] == "Screening Passed"]
        if not pending_value:
            st.info("No ideas pending business value assessment.")
            
        for idea in pending_value:
            with st.expander(f"{idea['title']} - Value Assessment", expanded=True):
                st.write(f"**Benefit Claim:** {idea['benefit']}")
                
                with st.form(key=f"value_form_{idea['id']}"):
                    value_score = st.select_slider(
                        "Rate Business Value Potential",
                        options=["Low", "Medium", "High", "Critical"],
                        value="Medium"
                    )
                    notes = st.text_area("Evaluator Notes")
                    
                    if st.form_submit_button("Submit Assessment"):
                        update_idea_status(ideas, idea['id'], "Value Assessed", {
                            "business_value": value_score,
                            "value_notes": notes
                        })
                        st.rerun()

    # --- Stage 3: Risk Review ---
    with tab3:
        pending_risk = [i for i in ideas if i["status"] == "Value Assessed"]
        if not pending_risk:
            st.info("No ideas pending risk review.")
            
        for idea in pending_risk:
            with st.expander(f"{idea['title']} - Risk & Final Decision", expanded=True):
                st.info(f"**Previous Business Value Rating:** {idea.get('business_value', 'N/A')}")
                
                st.markdown("### Risk Assessment")
                c1, c2, c3 = st.columns(3)
                r1 = c1.checkbox("Data Privacy Concerns?", key=f"r1_{idea['id']}")
                r2 = c2.checkbox("High Tech Debt?", key=f"r2_{idea['id']}")
                r3 = c3.checkbox("Regulatory Compliance Issues?", key=f"r3_{idea['id']}")
                
                risk_level = "Low"
                if r1 or r2 or r3:
                    risk_level = "High" if (r1 and r2) or (r1 and r3) or (r2 and r3) else "Medium"
                if r1 and r2 and r3:
                    risk_level = "Critical"

                st.write(f"**Calculated Risk Level:** {risk_level}")
                
                st.markdown("### Final Decision")
                decision = st.radio("Outcome", ["Approve", "Reject"], horizontal=True, key=f"dec_{idea['id']}")
                
                if st.button("Finalize Review", key=f"final_{idea['id']}"):
                    final_status = "Approved" if decision == "Approve" else "Rejected"
                    update_idea_status(ideas, idea['id'], final_status, {
                        "risk_level": risk_level,
                        "risk_factors": {"privacy": r1, "tech_debt": r2, "compliance": r3},
                        "final_decision": decision
                    })
                    st.success(f"Idea {decision}d!")
                    st.rerun()

    # --- Completed ---
    with tab4:
        completed = [i for i in ideas if i["status"] in ["Approved", "Rejected"]]
        if not completed:
            st.info("No completed reviews yet.")
            
        for idea in completed:
            color = "green" if idea['status'] == "Approved" else "red"
            st.markdown(f"### :{color}[{idea['title']}]")
            st.write(f"**Status:** {idea['status']}")
            st.write(f"**Department:** {idea['department']}")
            st.write(f"**Final Decision:** {idea.get('final_decision', 'N/A')}")
            st.markdown("---")

    # --- All Ideas (Debug) ---
    with tab5:
        st.dataframe(pd.DataFrame(ideas))

def page_analytics():
    st.subheader("📊 Portfolio Analytics")
    ideas = load_data()
    
    if not ideas:
        st.warning("No data available for analytics.")
        return

    df = pd.DataFrame(ideas)

    # Top Metrics
    col1, col2, col3, col4 = st.columns(4)
    col1.metric("Total Ideas", len(df))
    col2.metric("Approved", len(df[df['status'] == 'Approved']))
    col3.metric("Rejected", len(df[df['status'] == 'Rejected']))
    col4.metric("Pending Review", len(df[~df['status'].isin(['Approved', 'Rejected'])]))

    st.markdown("---")

    # Charts
    c1, c2 = st.columns(2)
    
    with c1:
        st.markdown("#### Ideas by Department")
        if not df.empty:
            dept_counts = df['department'].value_counts()
            st.bar_chart(dept_counts)
        else:
            st.info("No data.")

    with c2:
        st.markdown("#### Status Distribution")
        if not df.empty:
            status_counts = df['status'].value_counts()
            st.bar_chart(status_counts)
        else:
            st.info("No data.")
            
    # Business Value vs Priority Matrix (if available)
    if 'business_value' in df.columns:
        st.markdown("#### Business Value Distribution")
        value_counts = df['business_value'].value_counts()
        st.bar_chart(value_counts)

# --- Main App Logic ---
def main():
    render_header()
    page = render_sidebar()
    
    if page == "Submit Idea":
        page_submit_idea()
    elif page == "Evaluator Dashboard":
        page_evaluator_dashboard()
    elif page == "Analytics":
        page_analytics()

if __name__ == "__main__":
    main()
