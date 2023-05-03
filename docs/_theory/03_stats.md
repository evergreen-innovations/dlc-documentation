---
title: Statistics
permalink: /theory/stats
sidebar:
  nav: "theory"
toc: true
toc_label: "Sections"
toc_icon: "cog"
toc_sticky: true
---

The Statistics pages use the cleaned site data to determine the wave conditions required for design using {{site.doc-name}}. Table 7 in the IEC Standard specifies three design conditions corresponding to return periods of 1 and 50 years, and the designer-selected rated condition. These states are typically referred to in terms of the significant wave heights as {% raw %}$$H_{m1}$${% endraw %}, {% raw %}$${H_{m50}}$${% endraw %}, and {% raw %}$$H_{\mathrm{rated}}$${% endraw %} respectively.

See [Characterization of Extreme Wave Conditions for Wave Energy Converter Design and Project Risk Assessment](https://www.mdpi.com/2077-1312/8/4/289) for more information on why the statistics are calculated as well as guidance on univariate vs contour approaches.

# Approaches

{{ site.doc-name }} allows for spectral parameters of the stochastic sea states to be determined using Contour or Univariate approaches. See the recommended practice [DNV-RP-C205](https://www.dnv.com/oilgas/download/dnv-rp-c205-environmental-conditions-and-environmental-loads.html) and section 6.2.2.4 of {{ site.doc-name }} for more information on recommended practices.

# Joint Distribution and Contour Methods

Calculates the joint distribution of the sea states and forms contour lines from the distribution.  Samples across the contour lines quantify sea states that are used in generating surface elevation time series for tank testing or numerical modeling.

See [Development of a Comparison Framework for Evaluating Environmental Contours of Extreme Sea States](https://www.mdpi.com/2077-1312/9/1/16) for more information on environmental contours.

## Model Structures<!-- omit in toc -->

The tool currently offers three model structures that can be selected.  The selection can be done using either {% raw %} $$T_e$$ {% endraw %} or {% raw %} $$T_p$$ {% endraw %} for the period type, dependent on if the source has the given period value.

Depending on your device, site data, and what loads may be the most destructive, select a model structure for each return period (1 and 50 years) to best fit your individual needs.

### OMAE 2020<!-- omit in toc -->

The OMAE 2020 Model Structure uses the [virocon](https://github.com/virocon-organization/virocon) package. See their publication on their software for a concise description [here](https://github.com/ahaselsteiner/publications/blob/master/2018-10-25_SoftwareX_ViroCon_revised.pdf).

[Haselsteiner et al. (2020)](https://www.researchgate.net/publication/341453778_Global_hierarchical_models_for_wind_and_wave_contours_Physical_interpretations_of_the_dependence_functions) describes how the OMAE 2020 model was created.


For more information on the benchmarking and validation of the model, see [Haselsteiner et al. (2019)](https://www.sciencedirect.com/science/article/pii/S0029801821009033).

An example using the virocon package, constructing a 50 year contour from benchmark data from [Haselsteiner et al. (2019)](https://www.sciencedirect.com/science/article/pii/S0029801821009033), can be found [here](https://virocon.readthedocs.io/en/latest/example.html).

The OMAE 2020 model uses zero-up-crossing period ({% raw %}$$T_z$${% endraw %}) for the period value, and the data sets provided through the tool have {% raw %}$$T_e$${% endraw %} or {% raw %}$$T_p$${% endraw %} parameters. [Cahill and Lewis (2014)](https://vtechworks.lib.vt.edu/bitstream/handle/10919/49206/80-Cahill.pdf) have

$$ T_e = 1.206T_z$$

and

$$  T_e/T_p = 0.85 $$

for a Bretschneider spectrum that are used for converting {% raw %}$$T_p$${% endraw %} or {% raw %}$$T_e$${% endraw %} to {% raw %}$$T_z$${% endraw %}.

### PCA<!-- omit in toc -->

The Principal Component Analysis (PCA) model structure is implemented by [MHKiT](https://mhkit-software.github.io/MHKiT/index.html).  

MHKiT computes the contour using their [`mhkit.wave.contours.PCA_contour`](https://mhkit-software.github.io/MHKiT/mhkit-python/api.wave.html#mhkit.wave.contours.PCA_contour) function.  The contours are formed from a modified principal component analysis [Eckert-Gallup et. al. (2016)](https://www.sciencedirect.com/science/article/abs/pii/S0029801815006721).

See code implementation details of the modified principal component analysis [here](https://mhkit-software.github.io/MHKiT/_modules/mhkit/wave/contours.html#environmental_contours), scroll to the `_principal_component_analysis` function definition. 


### Gaussian<!-- omit in toc -->

The Gaussian Model structure is implemented by [MHKiT](https://mhkit-software.github.io/MHKiT/index.html).  

MHKiT computes the contour using their [`mhkit.wave.contours.environmental_contours`](https://mhkit-software.github.io/MHKiT/mhkit-python/api.wave.html#mhkit.wave.contours.environmental_contours) function.  

The contours are calculated from a Gaussian copula. See the code implementation details [here](https://mhkit-software.github.io/MHKiT/_modules/mhkit/wave/contours.html#environmental_contours), scroll to the `_gaussian_copula` definition.


## IFORM Contour<!-- omit in toc -->

All contours are calculated using the IFORM approach. IFORM is the Inverse First Order Reliability Method. More information on the IFORM contours can be found in [DNV-RP-C205](https://www.dnv.com/oilgas/download/dnv-rp-c205-environmental-conditions-and-environmental-loads.html) Section 3.7 Extreme Value Distribution.

[Winterstein et al. (1993)](https://www.researchgate.net/publication/288935223_Environmental_parameters_for_extreme_response_inverse_FORM_with_omission_factors) introduces the IFORM contour.

## Contour Sampling<!-- omit in toc -->

Once contours have been formed, use either number of samples or width of intervals between the samples to define what sea states will be available for generating surface elevation time series from.

The {% raw %}$$H_{m0}$${% endraw %} values are interpolated from the contour line from the provided at the selected period points using [`scipy.interpolate.interp1d`](https://docs.scipy.org/doc/scipy/reference/generated/scipy.interpolate.interp1d.html).

See [DNV-RP-C205](https://www.dnv.com/oilgas/download/dnv-rp-c205-environmental-conditions-and-environmental-loads.html) for more information on how the samples across the contour form the sea states.

# Univariate Methods

One-dimensional significant wave height distributions can be used to quantify the required sea states for WEC DLC's. 

For use in wave tank testing or dynamic simulations, the {% raw %}$$T_p$${% endraw %} range is calculated using ({{ site.doc-name }} Formula (3) Section 6.2.2.3):

$$ 11.1\sqrt{\frac{H_{m(n)}}{g}}\leq T_p \leq 14.3\sqrt{\frac{H_{m(n)}}{g}} $$

Where:
* {% raw %}$$H_{m(n)}$${% endraw %} is the calculated significant wave height with a return period of {% raw %}$$n$${% endraw %} years.
* {% raw %}$$g$${% endraw %}  is the gravitational constant of {% raw %}$$9.81 m/s^2$${% endraw %} 

Calculations for univariate distributions are implemented via [MHKiT](https://mhkit-software.github.io/MHKiT/index.html).

## Methods & Architecture<!-- omit in toc -->

The DLC Generator offers four different distributions to be calculated.  Depending on your specific device needs and modeling preferences, a method can be selected for each required return period.  

All univariate methods follow the following general architecture:
1. Approximate the distribution for the {% raw %}$$H_{m0}$${% endraw %} time series using the [MHKiT Loads Module](https://mhkit-software.github.io/MHKiT/mhkit-python/api.loads.html#extreme) for the selected method
2. Calculate the {% raw %}$$H_{m(n)}$${% endraw %} value from the given distribution corresponding to a particular return year using [MHKiT](https://mhkit-software.github.io/MHKiT/mhkit-python/api.loads.html#mhkit.loads.extreme.return_year_value)
3. Use {{ site.doc-name }} Formula (3) Section 6.2.2.3 to calculate the associated {% raw %}$$T_p$${% endraw %} range in seconds.

A Q-Q plot is generated to help analyze the quality of fit of the data to the given distribution.

### Annual Maxima<!-- omit in toc -->

The annual maxima method fits the **yearly maxima** across the {% raw %}$$H_{m0}$${% endraw %} time series. The MHKiT function used is [`mhkit.loads.extreme.ste_block_maxima_gev`](https://mhkit-software.github.io/MHKiT/mhkit-python/api.loads.html#mhkit.loads.extreme.ste_block_maxima_gev).

There are a couple limitations to the annual maxima method:

1. Cannot produce a valid 1-year return period extreme value ({% raw %}$$H_{m1}$${% endraw %})
2. Requires a minimum Period of Record (POR) of 20 years. [DNV-RP-C205](https://www.dnv.com/oilgas/download/dnv-rp-c205-environmental-conditions-and-environmental-loads.html). You can still select this method if this criteria isn't met, if it seems like it will be better for your use case.



### Peaks Over Threshold<!-- omit in toc -->

The peaks over threshold method fits the values found across the {% raw %}$$H_{m0}$${% endraw %} time series that are found to be above the threshold.  Currently, the threshold calculated using the 99th percentile of the data, resulting in fitting the top 1% of the {% raw %}$$H_{m0}$${% endraw %} time series.

**Come back for a future release where the threshold is automatically optimized using methods defined [here](https://www.mdpi.com/2077-1312/8/4/289).**

The MHKit function used is [`mhkit.loads.extreme.peaks_distribution_peaks_over_threshold`](https://mhkit-software.github.io/MHKiT/mhkit-python/api.loads.html#mhkit.loads.extreme.peaks_distribution_peaks_over_threshold) to estimate the short term extreme distribution.

Limitations of the POT method:

1. The ISO standard for estimating an n-year return period significant wave height from the POT method recommends periods of record (POR) at a quarter of the desired return period (12.5 years for a 50-year return event). [ISO 19901-1:2015](https://www.iso.org/standard/60183.html)

You can still select this method if the criteria isn't met, it it seems like it will be better for your use case.


### Weibull<!-- omit in toc -->

The Weibull method utilizes the MHKiT function [`mkhit.loads.extreme.peaks_distribution_weibull`](https://mhkit-software.github.io/MHKiT/mhkit-python/api.loads.html#mhkit.loads.extreme.peaks_distribution_weibull).

Unlike the Annual Maxima and Peaks Over Threshold methods, the Weibull method uses the entire {% raw %}$$H_{m0}$${% endraw %} time series to estimate the peaks distribution. 

### Weibull Tail<!-- omit in toc -->

The Weibull Tail method utilizes the MHKiT function [`mkhit.loads.extreme.peaks_distribution_weibull_tail`](https://mhkit-software.github.io/MHKiT/mhkit-python/api.loads.html#mhkit.loads.extreme.peaks_distribution_weibull_tail_fit).

Unlike the Annual Maxima and Peaks Over Threshold methods, the Weibull Tail method uses the entire {% raw %}$$H_{m0}$${% endraw %} time series to estimate the peaks distribution. 


