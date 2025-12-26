# Bayesian Modeling of Neonatal Mortality
*Interpretable risk factors in small clinical datasets*

**Author:** Imose Iduozee

## Project Overview
This project applies **Bayesian logistic regression** to identify key clinical risk factors associated with neonatal mortality in very low birth-weight infants. Using a small, noisy healthcare dataset, the analysis compares **pooled** and **sex-stratified hierarchical models** to evaluate whether mortality risk differs by sex and whether increased model complexity improves inference.

Rather than optimizing a single predictive model, this project emphasizes:
- Interpretability over black-box performance
- Explicit uncertainty quantification
- Robust validation under data limitations

This mirrors real-world analytics scenarios where data is incomplete, high-stakes, and costly to collect.

---

## Problem Statement
Neonatal mortality remains a major public health concern, particularly among very low birth-weight infants. Clinicians rely on multiple indicators—such as birth weight, platelet count, and respiratory complications—to assess mortality risk.

However, clinical datasets are often small, heterogeneous, and incomplete, making traditional modeling approaches unstable or overconfident. This project explores how **Bayesian modeling** can extract meaningful risk signals while accounting for uncertainty.

Observed mortality counts grouped by sex motivated comparison between pooled and hierarchical modeling approaches.

<img width="225" height="180" alt="image" src="https://github.com/user-attachments/assets/bbfd49df-491f-4ed2-b1a8-5449a4e39df8" />


---

## Data
- **Source:** Publicly available *Very Low Birth Weight Infants* dataset (Duke University Medical Center)
- **Time period:** 1981–1987
- **Initial size:** 671 infants
- **Final analyzed subset:** 174 infants (after data cleaning)
- **Outcome variable:** Neonatal mortality (binary)

### Key Predictors
- Birth weight  
- Platelet count  
- Pneumothorax  
- Intraventricular hemorrhage (IVH)  
- Sex  

Although the dataset is historical and small, it reflects common challenges in healthcare and bioinformatics analytics, where uncertainty must be modeled rather than ignored.

---

## Approach
Prior to modeling, feature selection was performed using correlation analysis and variance inflation factors (VIF) to reduce multicollinearity and improve interpretability.

<img width="238" height="198" alt="image" src="https://github.com/user-attachments/assets/33a640f1-e84a-4d0e-bbef-fdff26506922" />


Two Bayesian logistic regression models were constructed:

### 1. Pooled Bayesian Logistic Regression
- Assumes a shared mortality risk structure across all infants
- Models mortality as a function of selected clinical predictors
- Serves as a baseline model

### 2. Hierarchical Bayesian Logistic Regression
- Includes sex as a group-level (random intercept) effect
- Allows baseline mortality risk to vary between male and female infants
- Retains the same clinical predictors as the pooled model

The goal was not to maximize predictive accuracy, but to evaluate how modeling assumptions affect inference under limited data conditions.

---

## Model Validation & Evaluation
To ensure reliability and interpretability, both models were evaluated using:
- Convergence diagnostics (R̂ ≈ 1, high effective sample sizes)
- Posterior predictive checks to assess model fit
- Leave-One-Out Cross-Validation (PSIS-LOO) for model comparison
- Inspection of Pareto k values to identify influential observations

Both models converged without divergences and showed stable posterior behavior.

Posterior predictive checks were used to evaluate whether simulated outcomes aligned with observed data.

<img width="210" height="192" alt="image" src="https://github.com/user-attachments/assets/50e5e3e0-0cce-4440-9a36-525474d92789" />


When stratified by sex, the hierarchical model showed good calibration for female infants but persistent miscalibration for males, indicating limited benefit from added model complexity.

<img width="212" height="192" alt="image" src="https://github.com/user-attachments/assets/b5764460-4ff0-4597-a573-1e32bd8ffdc3" />


Model comparison was performed using PSIS-LOO cross-validation. Pareto k diagnostics indicated no influential observations (k < 0.7), supporting the reliability of the comparison.

<img width="227" height="181" alt="image" src="https://github.com/user-attachments/assets/55a30c9e-a03c-42d1-80d8-d61187761f84" /> <img width="233" height="181" alt="image" src="https://github.com/user-attachments/assets/2fd63b6d-8c06-4e56-8587-1d067bdc85e6" />

Non-hierarchical model vs hierarchical model of PSIS-LOO diagnostics showing absence of influential observations (Pareto k < 0.7)


---

## Key Results & Insights
- **Birth weight and platelet count** were strongly associated with neonatal mortality
- **Pneumothorax and IVH** substantially increased mortality risk
- Introducing sex as a hierarchical grouping factor did **not** meaningfully improve predictive performance
- Both models achieved approximately **93% classification accuracy**, interpreted cautiously due to class imbalance and small sample size
- PSIS-LOO showed negligible differences between pooled and hierarchical models

**Main insight:** Early neonatal mortality risk in this dataset is dominated by clinical factors rather than sex-specific baseline differences.

---

## Interpretation Under Data Limitations
This project highlights an important analytical lesson: **increasing model complexity does not necessarily improve inference when data is limited**.

Bayesian modeling provided a principled framework for:
- Quantifying uncertainty
- Incorporating prior medical knowledge
- Avoiding overconfident conclusions from small samples

---

## Tools & Methods
- **Language:** R  
- **Libraries:** `tidyverse`, `brms` (Stan backend), `loo`  
- **Techniques:** Bayesian regression, hierarchical modeling, model diagnostics, posterior predictive checks, PSIS-LOO cross-validation

---

## Potential Extensions
With larger or more recent datasets, future work could explore:
- Time-to-event (survival) modeling
- External validation on modern NICU cohorts
- Additional clinical covariates
- Non-linear or interaction effects

---

## Key Takeaway
This project demonstrates how Bayesian modeling and careful validation can support **interpretable, uncertainty-aware analysis** in small and high-stakes healthcare datasets—prioritizing reliable insight over raw predictive performance.
