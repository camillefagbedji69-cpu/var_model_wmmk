## Stability analysis 

compute_system_stability <- function(data_sb) {
  
  # Extraction and cleaning
  df_vars <- data_sb %>%
    dplyr::select(NPP, EI, LAI, Precip, 
                  LST, Prop_burn) %>%
    drop_na()
  
  # Normalization and conversion in TS
  data_scaled <- scale(as.matrix(df_vars))
  start_year <- min(data_sb$year, na.rm = TRUE)
  data_ts <- ts(data_scaled, 
                start = start_year, 
                frequency = 1)
  
  # Fit model VAR(1)
  var_model <- tryCatch({
    vars::VAR(data_ts, p = 1, type = "const")
  }, error = function(e) return(NULL))
  
  if (is.null(var_model)) {
    return(data.frame(lambda_max = NA_real_, tau_recovery = NA_real_, is_stable = NA))
  }
  
  # Compute eigen value 
  eigen_modules <- vars::roots(var_model)
  
  # Max eigen value 
  lambda_max <- max(eigen_modules)
  
  # Recovery time 
  tau_recovery <- if (lambda_max < 1) -1 / log(lambda_max) else Inf
  
  # Stability evaluation
  is_stable <- lambda_max < 1
  
  return(data.frame(
    lambda_max   = round(lambda_max, 4),
    tau_recovery = round(tau_recovery, 2),
    is_stable    = is_stable
  ))
}
