---
title: Statistics
permalink: /theory/stats
sidebar:
  nav: "theory"
---

Statistics take the cleaned site data and quantify sea states as significant wave height and period ({% raw %}$$ T_e $$ {% endraw %} or {% raw %} $$ T_p $${% endraw %}) pairs.  These create the extreme stochastic sea state.


###### Return Periods

The stats are set up to be calculated for 1 and 50 year return periods to align with the IEC technical specifications.

The return period is the average period between occurrences of a particular value being exceeded.  A 1-year return period's extreme stochastic sea state would indicate the returned value is only exceeded once every year, on average.


### Approaches

- [Joint Distribution and Contour Methods](#joint-distribution-and-contour-methods)
- [Univariate Methods](#univariate-methods)


## Joint Distribution and Contour Methods

Calculates the joint distribution of the sea states and draws contour lines from the distribution.  Samples across the contour lines quantify seas states that are used in generating surface elevation time series.

{{ site.doc-name }} indicates that contour statistical analysis is preferred when possible. 

### Model Structure <!-- omit in toc -->

The tool currently offers three model structures that can be selected.  The selection can be done using either {% raw %} $$T_e$$ {% endraw %} or {% raw %} $$T_p$$ {% endraw %} for the period type, dependent on if the source has the given period value.

#### OMAE 2020 <!-- omit in toc -->

[Haselsteiner et al. (2020)](https://www.sciencedirect.com/science/article/pii/S0029801821009033) found that the OMAE 2020 model generally provides the best fit. 

Significant Wave height:

$$ F(h_{mo}) = \left(1-exp\left[-\left(\frac{h_{mo}}{\alpha}\right)^\beta\right]\right)^\delta$$

Peak Period: 

$$ F(t_p | h_{mo}) = \frac{1}{2} + \frac{1}{2}\mbox{erf} \left(\frac{\ln t_p - \mu_{t_p}}{\sqrt{2}\sigma_{t_p}{^2}} \right)$$

Where:

$$ \mu_{t_p} = \ln\left(c_1 + c_2 \sqrt{\frac{h_{mo}}{g}}\right) $$

And:

$$ \sigma_{t_p} = c_3 + \frac{c_4}{1 + c_5 h_{mo}}$$





### IFORM <!-- omit in toc -->

All contours are calculated using the I-FORM approach. I-FORM stands for inverse first order reliability method.  This is used to draw the contour line once the joint distribution is calculated.





## Univariate Methods