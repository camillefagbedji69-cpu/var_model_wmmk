# Ecohydrological Resilience in the Wari-Maro -- Monts Kouffé Landscape

## Overview

This repository contains the data-processing workflows, statistical analyses, and modelling scripts used to assess the temporal dynamics, stability, and environmental controls of coupled ecosystem–hydrological functions across the **Wari-Maro–Monts Kouffé landscape in central Benin**.

The analysis covers **40 sub-watersheds over the 2004–2025 period**, combining remotely sensed, climatic, and hydrological indicators to investigate how ecosystem functioning and hydrological regulation evolve through time and how environmental characteristics influence system stability. The project therefore moves beyond a simple assessment of ecosystem degradation by explicitly investigating **dynamic stability and recovery capacity** at the sub-watershed scale.

---

## Research objectives

The project addresses three main questions:

1. **How have ecosystem productivity and hydrological regulation changed between 2004 and 2025?**
2. **How does the dynamic stability of the coupled ecosystem–hydrological system vary among sub-watersheds?**
3. **Which static environmental characteristics explain spatial differences in system stability?**

The analysis combines non-parametric trend analysis, change-point detection, vector autoregressive modelling, and nonlinear statistical modelling.

---

## Study area

The study focuses on the **Wari-Maro–Monts Kouffé landscape**, located in central Benin within the Guineo–Sudanian transition zone.

The analysis is conducted at the level of **40 sub-watersheds**, allowing the temporal dynamics of ecosystem and hydrological indicators to be examined while retaining spatial heterogeneity across the landscape.

---

## Dataset

The core database contains annual observations for 40 sub-watersheds from **2004 to 2025**.

This corresponds to:

* **40 sub-watersheds**
* **22 years**
* **880 sub-watershed-year observations**

### Dynamic variables

| Variable    | Description                             | Role                                 |
| ----------- | --------------------------------------- | ------------------------------------ |
| `LAI`       | Leaf Area Index                         | Vegetation structure and functioning |
| `Precip`    | Annual precipitation                    | Climatic forcing                     |
| `Prop_burn` | Proportion of burned area               | Disturbance pressure                 |
| `LST`       | Land Surface Temperature                | Thermal environment                  |
| `NPP`       | Net Primary Productivity                | Ecosystem productivity               |
| `EI`        | Evaporation Index (AET / precipitation) | Hydrological regulation              |

The six variables constitute the dynamic system used for the temporal and VAR-based analyses.

### Static environmental predictors

Spatially invariant or slowly varying environmental characteristics are subsequently used to explain differences in stability among sub-watersheds, including:

* Soil organic matter (`SOM`)
* Saturated hydraulic conductivity (`Ksat`)
* Mean elevation (`Alt_moy`)

Additional static predictors can be incorporated depending on the analysis stage.

---

## Temporal analysis

Temporal changes in NPP and EI are assessed using the **Mann–Kendall trend test** and **Sen's slope estimator**.

Potential abrupt changes are investigated using **Pettitt's change-point test**.

### NPP

NPP shows a strong and statistically significant decreasing trend over 2004–2025:

* Kendall's τ = **−0.697**
* Mann–Kendall p-value = **6.43 × 10⁻⁶**
* Sen's slope = **−0.0159 yr⁻¹**
* Pettitt change point: **year 11**, corresponding approximately to **2014**
* Pettitt p-value = **0.0053**

These results indicate a substantial deterioration in ecosystem productivity during the study period.

### Evaporation Index

EI also exhibits a decreasing trend, although considerably weaker than NPP:

* Kendall's τ = **−0.377**
* Mann–Kendall p-value = **0.0153**
* Sen's slope = **−0.00939 yr⁻¹**
* Pettitt change point: **year 17**, corresponding approximately to **2020**
* Pettitt p-value = **0.0582**

Thus, the temporal signal suggests a decline in hydrological regulation, but the Pettitt test does not provide strong evidence for a discrete change point at the 5% significance level.

---

## VAR-based stability analysis

To characterize the dynamic stability of the coupled ecosystem–hydrological system, a **Vector Autoregressive (VAR)** framework is applied to the annual time series.

For each sub-watershed, the VAR model represents the temporal dependence among the system variables and provides a transition structure from which the dominant eigenvalue is extracted.

The maximum modulus of the eigenvalues, 
[
\lambda_{\max},
] 
is used as an indicator of system stability.

Values of λmax closer to one indicate slower return dynamics, while values below one correspond to a locally stable dynamic system. Values equal to or above one indicate a loss of asymptotic recovery under the corresponding linearized dynamics.

The observed distribution of λmax across the dataset is:

| Statistic    |  λmax |
| ------------ | ----: |
| Minimum      | 0.697 |
| 1st quartile | 0.817 |
| Median       | 0.884 |
| Mean         | 0.918 |
| 3rd quartile | 0.998 |
| Maximum      | 1.317 |

The resulting stability metric is subsequently converted into a **recovery-time indicator**, providing an interpretable measure of how rapidly the system is expected to return towards its equilibrium following a perturbation.

---

## Environmental controls of stability

The spatial variation in λmax is investigated using statistical models relating dynamic stability to static environmental characteristics.

A multiple linear regression is first fitted:

[
\lambda_{\max}
\sim SOM + Ksat + Alt_{moy}
]

The linear model explains approximately **18.2% of the variance** in λmax:

* Adjusted R² = **0.180**
* F-statistic = **65.08**
* p < **2.2 × 10⁻¹⁶**

A Generalized Additive Model (GAM) is then used to account for potentially nonlinear relationships:

[
\lambda_{\max}
\sim s(SOM) + s(Ksat) + s(Alt_{moy})
]

The GAM substantially improves model performance:

* Adjusted R² = **0.788**
* Deviance explained = **79.5%**
* AIC = **−2227.75**

compared with:

* Linear model AIC = **−1058.86**

This comparison indicates that the relationship between environmental characteristics and dynamic stability is strongly **nonlinear**, and that linear assumptions provide a substantially poorer representation of the observed spatial variation in λmax.

---

## Scientific interpretation

The central premise of this project is that ecosystem degradation should not be evaluated solely through changes in the mean state of individual indicators.

A system can experience declining productivity, altered hydrological regulation, increasing disturbance, or climatic stress while also changing in its **dynamic capacity to recover from perturbations**.

By combining long-term environmental observations with VAR-based stability metrics, this framework provides a way to examine both:

**state change**

and

**dynamic stability**.

The subsequent modelling of λmax against environmental gradients provides an additional step toward identifying the physical and ecological characteristics associated with differences in resilience across the landscape.

---

## Scope and limitations

Several limitations should be considered when interpreting the results.

First, the annual time series are relatively short (**22 years**), which constrains the complexity of temporal models that can be robustly fitted at the individual sub-watershed level.

Second, the VAR framework provides a linear approximation of the local dynamics of the multivariate system. Consequently, λmax should be interpreted as a **local dynamic-stability indicator**, rather than as a complete representation of ecological resilience.

Third, the environmental-control analysis identifies statistical associations between static environmental characteristics and stability. These relationships should not automatically be interpreted as causal effects.

Finally, remotely sensed and model-derived indicators inherit the uncertainties associated with their respective products and processing workflows.


The repository is being progressively organized to improve reproducibility, documentation, and reuse of the analytical workflow.
