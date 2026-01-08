# ManagerSalary_AnalysisPrep

This repository contains a comprehensive data cleaning and standardization workflow for the Manager Salary dataset. The goal of this project is to transform raw, messy salary data into a clean, normalized format suitable for reliable statistical analysis and visualization.

## 🚀 Project Overview
Salary data often suffers from inconsistent naming conventions (e.g., "Sao Paulo" vs "São Paulo"), varying currency formats, and job title sprawl. This project implements a structured pipeline to:
- **Standardize Locations:** Uses a global city reference dataset to normalize city and country names.
- **Categorize Industries & Titles:** Groups fragmented job roles into broader, analysis-friendly categories.
- **Normalize Salaries:** Converts disparate salary figures into a consistent format for comparison.
- **Flag Outliers:** Identifies unusually high or low salary entries for manual review.

## 📂 Project Structure
- `dataset/`: Contains the raw input files and the final cleaned reference datasets.
- `queries/`: SQL scripts used for the data cleaning, join logic, and normalization.
- `LICENSE`: MIT License.

## 🛠️ Tools Used
- **SQL:** Core logic for data transformation and cleaning.
- **CSV/Excel:** Initial data source and reference tables.
- **Reference Data:** Integrated global city/country datasets for geolocation standardization.

## 📈 Cleaning Logic
1. **Encoding Fixes:** Resolves common UTF-8 encoding issues (e.g., fixing `SÃ£o Paulo` to `São Paulo`).
2. **Title Normalization:** Mapping thousands of unique strings to a set of core professional categories.
3. **Geographic Validation:** Cross-referencing city names against a master list to ensure high data integrity for mapping.

## 📝 License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🤝 Contributing
Feel free to open an issue or submit a pull request if you have suggestions for improving the cleaning scripts or expanding the reference datasets.
