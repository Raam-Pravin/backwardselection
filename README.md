# backward_selection
## Overview:
backward_selection is a package for backwards selection, providing a function which performs backwards selection 

given:
(data frame, outcome variable, vector of predictor variables)
 
backwards_selection(): Intializes a full model with all predicitor variables and using the base lm() function 
one-by-one drops predictors whose t-test's p-value is not less than 0.05, making sure to never drop the intercept. 
Backwards selection ends when all remaining variables in the linear model are all statistically significant with 
p-values less than 0.05. A summary of the final model using the base summary() function is returned by the function 
along with a list of the variables which were removed since they were found to be statistically in-significant at a 
p-value of 0.05.      

## Installation
```{r, eval = FALSE}
devtools::install_github("Raam-Pravin/backward_selection", build_vignettes = T)
```

## Example Usage:
### Input:
```{r, eval = FALSE}

data("mtcars")
library(backward_selection)

#example:
data("mtcars")
y_var <- "mpg"

#All columns except target mpg
x_vars <- colnames(mtcars)[2:11]  
final_model <- backward_selection(mtcars, y_var, x_vars)
final_model
```

### Output:
```{r, eval = FALSE}
[1] "Final model:"

Call:
lm(formula = formula, data = data)

Residuals:
    Min      1Q  Median      3Q     Max 
-3.4811 -1.5555 -0.7257  1.4110  4.6610 

Coefficients:
            Estimate Std. Error t value Pr(>|t|)    
(Intercept)   9.6178     6.9596   1.382 0.177915    
wt           -3.9165     0.7112  -5.507 6.95e-06 ***
qsec          1.2259     0.2887   4.247 0.000216 ***
am            2.9358     1.4109   2.081 0.046716 *  
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 2.459 on 28 degrees of freedom
Multiple R-squared:  0.8497,	Adjusted R-squared:  0.8336 
F-statistic: 52.75 on 3 and 28 DF,  p-value: 1.21e-11

[1] "Removed variables:"
[1] "cyl"  "vs"   "carb" "gear" "drat" "disp" "hp"  
```
