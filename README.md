# County-Level Economic Trends Analysis (2017–2022)

This project analyzes U.S. county-level economic trends between 2017 and 2022 using census data and visual analytics. The analysis focuses on **population**, **employment**, and **median housing price** changes, comparing performance across **Metropolitan**, **Micropolitan**, and **Rural** regions. The project combines R-based data processing with a Tableau dashboard and a LaTeX technical report.

---

## Objectives
- Quantify economic growth between 2017 and 2022 at the county level.
- Compare development patterns across different area classifications.
- Visualize spatial and statistical differences in regional performance.

---

## Methodology
- **Data Source:** U.S. Census Bureau — American Community Survey (ACS)  
- **Processing Tool:** R (`tidycensus`, `tigris`, and `tidyverse` libraries)  
- **Visualization Tools:** Tableau and LaTeX  

The dataset includes total values for 2017 and 2022 for each indicator, from which the percentage change was calculated:

\[
Change\ Rate = \frac{Value_{2022} - Value_{2017}}{Value_{2017}} \times 100
\]

---

## Deliverables
| File | Description |
|------|--------------|
| `data/cleanedgdp.csv` | Cleaned dataset containing population, employment, and housing values for 2017 & 2022 |
| `data/classification_.csv` | County classification dataset (Metropolitan, Micropolitan, Rural) |
| `dashboard/Tableau Workbook.twbx` | Interactive Tableau dashboard |
| `report/report.pdf` | Final LaTeX report explaining data, dashboard visuals, and results |
| `scripts/R_Script.pdf` | Full R workflow used for data retrieval and transformation |

---

## Key Insights
- Metropolitan counties experienced consistent population and employment growth.
- Rural counties showed greater housing price volatility but strong percentage increases.
- Employment change and population growth were strongly correlated.
- Economic development remained spatially diverse, with rural areas displaying wider variability.

---

## Tools and Technologies
- **R** – Data acquisition and computation  
- **Tableau** – Visualization and dashboard design  
- **LaTeX** – Academic-style report creation  
- **GitHub** – Version control and documentation  

---

## References
- U.S. Census Bureau – *American Community Survey (ACS)*  
- U.S. Department of Commerce – *Bureau of Economic Analysis (BEA)*  
- R Packages – *tidycensus, tidyverse, tigris*

