"""
Sales Data Analysis & Business Intelligence
===========================================
Analyses a sales dataset with Pandas/NumPy to surface revenue trends,
customer behaviour and top-performing products.

Run:  python sales_analysis.py
"""
import pandas as pd

DATA_PATH = "data/sales_data.csv"


def load_data(path: str = DATA_PATH) -> pd.DataFrame:
    df = pd.read_csv(path, parse_dates=["order_date"])
    # Derived revenue column
    df["revenue"] = df["quantity"] * df["unit_price"]
    df["month"] = df["order_date"].dt.to_period("M").astype(str)
    return df


def revenue_by_category(df: pd.DataFrame) -> pd.DataFrame:
    return (
        df.groupby("category")
        .agg(total_revenue=("revenue", "sum"), orders=("order_id", "count"))
        .sort_values("total_revenue", ascending=False)
    )


def monthly_revenue_trend(df: pd.DataFrame) -> pd.DataFrame:
    trend = (
        df.groupby("month")["revenue"]
        .sum()
        .reset_index()
        .sort_values("month")
    )
    # Month-over-month growth % using a window-style diff
    trend["mom_growth_pct"] = trend["revenue"].pct_change() * 100
    return trend


def top_products(df: pd.DataFrame, n: int = 5) -> pd.DataFrame:
    return (
        df.groupby("product")
        .agg(total_revenue=("revenue", "sum"), units_sold=("quantity", "sum"))
        .sort_values("total_revenue", ascending=False)
        .head(n)
    )


def customer_value(df: pd.DataFrame) -> pd.DataFrame:
    """Rank customers by total spend to understand customer behaviour."""
    cust = (
        df.groupby("customer_id")
        .agg(
            total_spend=("revenue", "sum"),
            order_count=("order_id", "nunique"),
            avg_order_value=("revenue", "mean"),
        )
        .sort_values("total_spend", ascending=False)
    )
    # Cumulative revenue share (window-function style) to find top contributors
    cust["cumulative_share_pct"] = (
        cust["total_spend"].cumsum() / cust["total_spend"].sum() * 100
    ).round(1)
    return cust


def region_performance(df: pd.DataFrame) -> pd.DataFrame:
    return (
        df.groupby("region")
        .agg(total_revenue=("revenue", "sum"), orders=("order_id", "count"))
        .sort_values("total_revenue", ascending=False)
    )


def main() -> None:
    df = load_data()

    print("=" * 60)
    print(" SALES DATA ANALYSIS — BUSINESS INSIGHTS")
    print("=" * 60)

    print(f"\n📦 Total records: {len(df)} | "
          f"💰 Total revenue: ₹{df['revenue'].sum():,.0f}")

    print("\n--- Revenue by Category ---")
    print(revenue_by_category(df).to_string())

    print("\n--- Monthly Revenue Trend (MoM growth) ---")
    print(monthly_revenue_trend(df).to_string(index=False))

    print("\n--- Top Products ---")
    print(top_products(df).to_string())

    print("\n--- Customer Value Ranking ---")
    print(customer_value(df).to_string())

    print("\n--- Region Performance ---")
    print(region_performance(df).to_string())


if __name__ == "__main__":
    main()
