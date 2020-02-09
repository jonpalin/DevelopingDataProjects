Modelling mortality rates
========================================================
author: Jon Palin
date: 9 February 2020
autosize: true

Features of mortality rates
========================================================

Mortality rates:
- are financially important for pension schemes, insurers and social security plans
- measure the probability of death over one year
- vary greatly with age
- also vary by gender, and over time


Mortality rates by age
========================================================

Mortality rates vary approximately exponentially by age, but the fit is not exact.

![plot of chunk unnamed-chunk-1](Presentation-figure/unnamed-chunk-1-1.png)

The mortality rate app
========================================================

The [app](https://jon336.shinyapps.io/MortalityRates/) lets you:
* select data by age range, calendar year, and gender
* fit a model to the data, with a specified number of parameters
* compare the fitted model to the actual mortality rates

Better results
========================================================

The app helps you find a better fit for the data, by using more parameters.

![plot of chunk unnamed-chunk-2](Presentation-figure/unnamed-chunk-2-1.png)
