# 📊 Sales Data Analysis & Business Intelligence

An end-to-end **sales analytics** project that uncovers revenue trends, customer
behaviour and top-performing products using **SQL**, **Python (Pandas/NumPy)**
and **Power BI** dashboards.

## 🎯 Objectives

- Analyse sales datasets to identify revenue trends and customer behaviour
- Perform advanced SQL analysis using joins, CTEs, subqueries and window functions
- Build interactive dashboards and KPI reports for data-driven decisions

## ✨ What's Inside

- 🐍 **Python analysis** (`sales_analysis.py`) — revenue by category, monthly
  trend with MoM growth, top products, customer value ranking, region performance
- 🗫 **Advanced SQL** (`queries.sql`) — `JOIN`s, `WITH` CTEs, subqueries, and
  window functions (`LAG`, `RANK`, running totals / cumulative share)
- ️ **Schema** (`schema.sql`) — fact (`sales`) + dimension (`customers`) tables
- 📈 **Power BI** — guidance for building KPI dashboards from the model

## 🧱 Tech Stack

`SQL` · `Python` · `Pandas` · `NumPy` · `MySQL` · `Power BI`

## 🚀 Getting Started

```bash
# Python analysis (runs offline against the sample CSV)
pip install -r requirements.txt
python sales_analysis.py

# SQL analysis
mysql -u root -p < schema.sql      # create tables
mysql -u root -p sales_analytics < queries.sql
```

## 📂 Project Structure

```
Sales-Data-Analysis/
├── data/sales_data.csv     # sample sales data
├── sales_analysis.py       # Pandas/NumPy analysis
├── queries.sql             # joins, CTEs, window functions
├── schema.sql              # MySQL schema
├── requirements.txt
└── README.md
```

## 📈 Power BI Dashboard (suggested KPIs)

| KPI | Visual |
|-----|--------|
| Total Revenue | Card |
| Revenue by Category | Bar chart |
| Monthly Revenue Trend | Line chart |
| Top Products | Table |
| Region Performance | Map / column chart |

---

Built by [Roopa Juttada](https://github.com/roopajuttada08) 🚀
