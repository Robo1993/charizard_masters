install.packages(c("moments"))
library(moments)

#------------------------------------------------------------------------------
# dealing with skewness
#------------------------------------------------------------------------------

normality_test_data <- analysis_ueq_scales %>% filter(navigation_size == "big" & navigation_style == "hamburger")

exp_ueq_pragmatic <- normality_test_data$ueq_pragmatic
ueq_pragmatic_skew <- skewness(exp_ueq_pragmatic, na.rm = TRUE)
ueq_pragmatic_kurt <- kurtosis(exp_ueq_pragmatic)

exp_ueq_hedonic <- normality_test_data$ueq_hedonic
ueq_hedonic_skew <- skewness(exp_ueq_hedonic, na.rm = TRUE)
ueq_hedonic_kurt <- kurtosis(exp_ueq_hedonic)

exp_mean_time <- normality_test_data$mean_time
mean_time_skew <- skewness(exp_mean_time, na.rm = TRUE)
mean_time_kurt <- kurtosis(exp_mean_time)

pragmatic_h1 <- "Kurtosis and Skewness - Pragmatic"
hedonic_h1 <- "Kurtosis and Skewness - Hedonic"
mean_time_h1 <- "Kurtosis and Skewness - Mean Time"



writeLines(c(pragmatic_h1, paste(ueq_pragmatic_kurt, ueq_pragmatic_skew, sep = " : "), 
           hedonic_h1, paste(ueq_hedonic_kurt, ueq_hedonic_skew, sep = " : "),
           mean_time_h1, paste(mean_time_kurt, mean_time_skew, sep = " : ")), sep = "\n")

#------------------------------------------------------------------------------
# Normality 
#------------------------------------------------------------------------------
ueq_pragmatic_check <- analysis_ueq_scales

# Density for pragmatic
test_graph_pragmatic_small <- ggdensity(analysis_ueq_scales_wit[analysis_ueq_scales_wit$navigation_size == "small", ],
                                      x = "ueq_pragmatic",
                                      color = "navigation_style",
                                      fill = "navigation_style",
                                      palette = c("#00AFBB", "#E7B800"),
                                      add = "mean",
                                      main = "Density Pragmatic Small Menu",
                                      xlab = "UEQ Score") +
                              scale_x_continuous(limits = c(-3, 3)) +
                              stat_overlay_normal_density(aes(color = navigation_style, linetype = "dashed"))
test_graph_pragmatic_small

test_graph_pragmatic_big <- ggdensity(analysis_ueq_scales_wit[analysis_ueq_scales_wit$navigation_size == "big", ],
                                      x = "ueq_pragmatic",
                                      color = "navigation_style",
                                      fill = "navigation_style",
                                      palette = c("#00AFBB", "#E7B800"),
                                      add = "mean",
                                      main = "Density Pragmatic Big Menu",
                                      xlab = "UEQ Score") +
                              scale_x_continuous(limits = c(-3, 3)) +
                              stat_overlay_normal_density(aes(color = navigation_style, linetype = "dashed"))
test_graph_pragmatic_big

# Density for hedonic
test_graph_hedonic_small <- ggdensity(analysis_ueq_scales_wit[analysis_ueq_scales_wit$navigation_size == "small", ],
                                      x = "ueq_hedonic",
                                      color = "navigation_style",
                                      fill = "navigation_style",
                                      palette = c("#00AFBB", "#E7B800"),
                                      add = "mean",
                                      main = "Density Hedonic Small Menu",
                                      xlab = "UEQ Score") +
                              scale_x_continuous(limits = c(-3, 3)) +
                              stat_overlay_normal_density(aes(color = navigation_style, linetype = "dashed"))
test_graph_hedonic_small

test_graph_hedonic_big <- ggdensity(analysis_ueq_scales_wit[analysis_ueq_scales_wit$navigation_size == "big", ],
                                      x = "ueq_hedonic",
                                      color = "navigation_style",
                                      fill = "navigation_style",
                                      palette = c("#00AFBB", "#E7B800"),
                                      add = "mean",
                                      main = "Density Hedonic Big Menu",
                                      xlab = "UEQ Score") +
                              scale_x_continuous(limits = c(-3, 3)) +
                              stat_overlay_normal_density(aes(color = navigation_style, linetype = "dashed"))
test_graph_hedonic_big

# Density for meantime
test_graph_meantime_small <- ggdensity(analysis_ueq_scales_wit[analysis_ueq_scales_wit$navigation_size == "small", ],
                                      x = "mean_time",
                                      color = "navigation_style",
                                      fill = "navigation_style",
                                      palette = c("#00AFBB", "#E7B800"),
                                      add = "mean",
                                      main = "Density Mean Time Small Menu",
                                      xlab = "UEQ Score") +
                              scale_x_continuous(limits = c(0, 100000)) +
                              stat_overlay_normal_density(aes(color = navigation_style, linetype = "dashed"))
test_graph_meantime_small

test_graph_meantime_big <- ggdensity(data_over_40[data_over_40$navigation_size == "big", ],
                                      x = "mean_time",
                                      color = "navigation_style",
                                      fill = "navigation_style",
                                      palette = c("#00AFBB", "#E7B800"),
                                      add = "mean",
                                      main = "Density Mean Time Big Menu",
                                      xlab = "UEQ Score") +
                              scale_x_continuous(limits = c(0, 100000)) +
                              stat_overlay_normal_density(aes(color = navigation_style, linetype = "dashed"))
test_graph_meantime_big

# Skewness and Kurtosis of pragmatic ueq score

pragmatic_density_small_ham
print(get_normality_params(analysis_ueq_scales$ueq_pragmatic[analysis_ueq_scales$navigation_size == "small" & analysis_ueq_scales$navigation_style == "hamburger"]))
pragmatic_density_small_bott
print(get_normality_params(analysis_ueq_scales$ueq_pragmatic[analysis_ueq_scales$navigation_size == "small" & analysis_ueq_scales$navigation_style == "bottom_bar"]))
pragmatic_density_big_ham
print(get_normality_params(analysis_ueq_scales$ueq_pragmatic[analysis_ueq_scales$navigation_size == "big" & analysis_ueq_scales$navigation_style == "hamburger"]))
pragmatic_density_big_bott
print(get_normality_params(analysis_ueq_scales$ueq_pragmatic[analysis_ueq_scales$navigation_size == "big" & analysis_ueq_scales$navigation_style == "bottom_bar"]))

hedonic_density <- ggdensity(analysis_ueq_scales$ueq_hedonic, 
                             main = "Density plot of Hedonic Score",
                             xlab = "UEQ Score")
time_density <- ggdensity(analysis_ueq_scales$mean_time, 
                          main = "Density plot of Time",
                          xlab = "Time")

hedonic_density
time_density

pragmatic_density_task_1 <- ggdensity(data_by_task$task_solar_ueq_pragmatic, 
                          main = "Density plot of Time",
                          xlab = "UEQ Score")
pragmatic_density_task_1

pragmatic_density_task_2 <- ggdensity(data_by_task$task_battery_ueq_pragmatic, 
                                      main = "Density plot of Time",
                                      xlab = "UEQ Score")
pragmatic_density_task_2

analysis_without_outliers <- analysis_ueq_scales %>% filter(mean_time <= 50000)

time_density <- ggdensity(analysis_without_outliers$mean_time, 
                          main = "Density plot of Time",
                          xlab = "UEQ Score")
#------------------------------------------------------------------------------
# Data transformation for normality
#------------------------------------------------------------------------------
qqnorm(analysis_ueq_scales_wit$ueq_pragmatic[analysis_ueq_scales_wit$navigation_size == "small" & analysis_ueq_scales_wit$navigation_style == "hamburger"], pch = 1, frame = FALSE)
qqline(analysis_ueq_scales_wit$ueq_pragmatic[analysis_ueq_scales_wit$navigation_size == "small" & analysis_ueq_scales_wit$navigation_style == "hamburger"], col = "steelblue", lwd = 2)

qqnorm(analysis_ueq_scales_wit$ueq_pragmatic[analysis_ueq_scales_wit$navigation_size == "small" & analysis_ueq_scales_wit$navigation_style == "bottom_bar"], pch = 1, frame = FALSE)
qqline(analysis_ueq_scales_wit$ueq_pragmatic[analysis_ueq_scales_wit$navigation_size == "small" & analysis_ueq_scales_wit$navigation_style == "bottom_bar"], col = "steelblue", lwd = 2)

qqnorm(analysis_ueq_scales_wit$ueq_pragmatic[analysis_ueq_scales_wit$navigation_size == "big" & analysis_ueq_scales_wit$navigation_style == "hamburger"], pch = 1, frame = FALSE)
qqline(analysis_ueq_scales_wit$ueq_pragmatic[analysis_ueq_scales_wit$navigation_size == "big" & analysis_ueq_scales_wit$navigation_style == "hamburger"], col = "steelblue", lwd = 2)

qqnorm(analysis_ueq_scales_wit$ueq_pragmatic[analysis_ueq_scales_wit$navigation_size == "big" & analysis_ueq_scales_wit$navigation_style == "bottom_bar"], pch = 1, frame = FALSE)
qqline(analysis_ueq_scales_wit$ueq_pragmatic[analysis_ueq_scales_wit$navigation_size == "big" & analysis_ueq_scales_wit$navigation_style == "bottom_bar"], col = "steelblue", lwd = 2)

#------------------------------------------------------------------------------
# Shapiro tests
#------------------------------------------------------------------------------

analysis_ueq_scales_wit %>%
  group_by(navigation_size) %>%
  shapiro_test(ueq_pragmatic)

analysis_ueq_scales_wit %>%
  group_by(navigation_size, navigation_style) %>%
  shapiro_test(ueq_pragmatic)

analysis_ueq_scales_wit %>%
  group_by(navigation_size, navigation_style) %>%
  shapiro_test(ueq_hedonic)

analysis_ueq_scales_wit %>%
  group_by(navigation_size, navigation_style) %>%
  shapiro_test(mean_time)

#------------------------------------------------------------------------------
# residuals
#------------------------------------------------------------------------------
install.packages("extrafont")
library(extrafont)
font_import()
loadfonts(device="win")
windowsFonts(A = windowsFont("Times"))
# Pragmatic
res_pragmatic <- resid(lm_pragmatic)
plot(fitted(lm_pragmatic), res_pragmatic)
abline(0,0)

qqnorm(res_pragmatic)
qqline(res_pragmatic)

plot(density(res_pragmatic), family = "A")
shapiro.test(res_pragmatic)

# Mean Time
res_meantime <- resid(lm_mean_time)
plot(fitted(lm_mean_time), res_meantime)
abline(0,0)

qqnorm(res_meantime)
qqline(res_meantime)

plot(density(res_meantime))
shapiro.test(res_meantime)

#------------------------------------------------------------------------------
# functions
#------------------------------------------------------------------------------
get_normality_params <- function(data) {
  return(c(skewness(data, na.rm = TRUE), ueq_pragmatic_kurt <- kurtosis(data)))
}