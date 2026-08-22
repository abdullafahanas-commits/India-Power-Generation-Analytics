import pandas as pd

# Load the raw dataset
df = pd.read_csv("../data/power_generation.csv")

# Display basic information
print("Original Dataset Shape:", df.shape)
print("\nColumn Names:")
print(df.columns.tolist())

# Standardize column names
df.columns = (
    df.columns
    .str.strip()
    .str.lower()
    .str.replace(" ", "_")
    .str.replace("/", "_")
    .str.replace("-", "_")
)

# Convert energy columns to numeric
energy_columns = df.columns.drop("state_ut", errors="ignore")

for column in energy_columns:
    df[column] = pd.to_numeric(df[column], errors="coerce")

# Replace missing values with zero
df = df.fillna(0)

# Create renewable energy total if needed
renewable_columns = [
    "wind",
    "solar",
    "bio_power",
    "small_hydro",
    "others"
]

existing_renewable_columns = [
    column for column in renewable_columns
    if column in df.columns
]

if existing_renewable_columns:
    df["renewable_energy_total"] = (
        df[existing_renewable_columns].sum(axis=1)
    )

# Display cleaned data summary
print("\nCleaned Dataset Shape:", df.shape)
print("\nMissing Values:")
print(df.isnull().sum())

# Save cleaned dataset
df.to_csv(
    "../data/cleaned_power_generation.csv",
    index=False
)

print("\nCleaned dataset saved successfully.")