#'Backwards Selection
#'
#'Performs Backwards Variable Selection and returns created linear model
#'
#'@param data data frame
#'@param y_var string of target variable column name
#'@param x_vars vector of predictor column names
#'
#'@return final model created through backwards variable selection
#'
#'@examples
#'backward_selection(mtcars, "mpg", colnames(mtcars)[2:11])
#'
#'@export
backward_selection <- function(data, y_var, x_vars, significance_level = 0.05) {
  # Formula for the full model
  formula <- as.formula(paste(y_var, "~", paste(x_vars, collapse = " + ")))

  #full model
  model <- lm(formula, data = data)

  #Summary of model
  summary_model <- summary(model)

  # While there's a variable with p-value greater than significance_level
  removed_vars <- character()
  while (TRUE) {
    p_values <- summary_model$coefficients[, 4]
    max_p_value <- max(p_values)

    # Break loop if all p-values below 0.05
    if (max_p_value <= significance_level) {
      break
    }

    #Get variable with max p-value
    var_to_remove <- names(p_values)[which.max(p_values)]

    #So intercept isn't removed
    if (var_to_remove == "(Intercept)") {
      break
    }

    #Remove insignificant variables from model
    x_vars <- x_vars[x_vars != var_to_remove]

    #Refit model with significant variables
    formula <- as.formula(paste(y_var, "~", paste(x_vars, collapse = " + ")))
    model <- lm(formula, data = data)

    #new model summary
    summary_model <- summary(model)

    #removed variables
    removed_vars <- c(removed_vars, var_to_remove)
  }

  #final model summary
  print("Final model:")
  print(summary(model))
  print("Removed variables:")
  print(removed_vars)

  # Return the final model
  return(model)
}

