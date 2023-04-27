---
title: DLC & Sea State Realization
permalink: /theory/surfaceElevation
sidebar:
  nav: "theory"
---

Once statistics have been calculated to quantify spectral parameters ({% raw %}$$ H_{mo} $${% endraw %} and {% raw %}$$ T_p $${% endraw %} or {% raw %}$$ T_e $${% endraw %}), the DLC generator tool provides functionality to realize sea states into surface elevation time series.  These time series can then be used in tank testing, or dynamic simulations of your WEC device.

The tool also allows the developer to input their {% raw %}$$ H_{rated} $${% endraw %} value, then use the [{{ site.doc-name }} Section 6.2.2.3 Formula (3)](/theory/stats#univariate-methods) to calculate the associate peak period range for the spectral parameters.

##### Sections <!-- omit in toc -->

1. [DLC's](#dlcs) 
2. [Sea State Realization](#sea-state-realization)
3. [Design Wave Generation](#design-wave-generation)


# DLC's <!-- omit in toc -->

DLC's are defined in [{{site.doc-name}}]({{site.doc-link}}), Table 7 - Design load cases for WECs. There are other environmental conditions beyond the wave conditions generated through the tool that must be considered when creating the full DLC for each design condition.  

# Sea State Realization <!-- omit in toc -->

The DLC Generator provides functionality to realize sea states via:
1. [Parameter selection](#wave-parameter-selections)
2. [Sea state selection](#sea-state-selections)

## Wave Parameter Selections <!-- omit in toc -->

When realizing sea states the tool groups the realizations into the three unique wave conditions that are required for the Design Load Cases ({% raw %}$$ H_{m1} $${% endraw %}, {% raw %}$$ H_{m50} $${% endraw %}, and {% raw %}$$ H_{rated} $${% endraw %}).  The parameters selected for the irregular waves apply to all sea states being used for the given wave condition.

##### Wave Type <!-- omit in toc -->

Irregular waves will be generated. [Young, Ian. (2017). Regular, Irregular Waves and the Wave Spectrum](https://www.researchgate.net/publication/316336871_Regular_Irregular_Waves_and_the_Wave_Spectrum).

##### Spectrum <!-- omit in toc -->

1. JONSWAP - Applicable to a developing sea state in a fetch limited situation. This spectrum is often used for extreme event analysis.
2. Bretschneider - Also called ISCC or Modified Pierson Moskowitz, this spectrum is a two parameter spectrum that has less constraints than Perios Moskowitz.

More information on the spectrums can be found in [{{site.doc-name}}]({{site.doc-link}}) Annex C.

Spectral density is calculated using MHKiT function [`mhkit.wave.resource.jonswap_spectrum`](https://mhkit-software.github.io/MHKiT/mhkit-python/api.wave.html#mhkit.wave.resource.jonswap_spectrum).

##### Gamma <!-- omit in toc -->

Gamma only applies to the JONSWAP spectrum, as the Bretschneider spectrum is equivalent to a JONSWAP spectrum with a gamma of 1.

##### Realization Length <!-- omit in toc -->

The default value of 3 hours is typical for storm sea state realization.  This is the total length of the time series being generated.

{{site.doc-name}} Section 7.3.6 specifies requirements around realization length for testing.

##### Sample Rate <!-- omit in toc -->

Sample rate, in {% raw %}$$ Hz $${% endraw %} is simply the temporal resolution of the surface elevation time series that will be generated.  

Use your best judgement, along with the capabilities of your dynamic modeling or tank testing to determine what sample rate is needed.  Typically, 20 {% raw %}$$ Hz $${% endraw %} should be sufficient.  Very long or very short period values ({% raw %}$$ T_e $${% endraw %} or {% raw %}$$ T_p $${% endraw %}) may benefit from adjusting the sample rate.

##### Random Seed <!-- omit in toc -->

The random seed seeds the random number generator used to calculate the phase of the wave.  
 
{{site.doc-name}} Section 7.3.6, has requirements around load case modeling and simulation.  Changing the random seed, then downloading the updated surface elevation time series may help satisfy these requirements.


## Sea State Selections  <!-- omit in toc -->

Any point on a contour line or from the spectral parameters returned from a Univariate analysis can be used to satisfy the {% raw %}$$ H_{m(n)} $${% endraw %} requirements for the DLC's.

{{site.doc-name}} Section 6.2.2.5 specifies that the sea states that would cause the most onerous loads to be considered in testing.  

# Design Wave Generation <!-- omit in toc -->

TODO - NEED HELP WITH WHAT TO WRITE HERE 








