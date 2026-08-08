# Compute lambda and recovery time by watershed

stab_wm <- dataset |>
  group_by(HYBAS_ID) |>
  nest() |>
  mutate(stability = map(data, compute_system_stability))|>
  unnest(cols = c(stability)) |>
  data.frame()

stab_wm <- stab_wm |> 
  select(-data, is_stable) ## Delete useless variables 

## Join with dataset 

stab_wm <- dataset |> 
  dplyr:: select(HYBAS_ID, SOM, Ksat, 
                 Alt_moy) |> 
  left_join(stab_wm, by = "HYBAS_ID")

## Models specifications 

m1 <- lm(lambda_max ~ SOM +Ksat + Alt_moy, 
         data = stab_wm) ## Linear model 

summary(m1) ## Print result 

library(mgcv)

m2 <- gam(lambda_max ~ s(SOM) + s(Ksat)+
            s(Alt_moy), data = stab_wm, 
          method = "REML") ## GAM models 

summary(m2) # Print result 

## Models comparisons 

AIC(m1, m2)

## Graphics 

library(gratia)

draw(m2)&
  theme_minimal(base_size = 12) &
  labs(y = "Partial effect on stability")
