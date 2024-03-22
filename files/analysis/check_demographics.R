install.packages(c("ggplot2", "ggpubr", "tidyverse", "broom", "dplyr", "rstatix"))
library(dplyr)
library(ggplot2)
library(ggpubr)
library(tidyverse)
library(broom)
library(rstatix)

latest_ls_data <- read.csv("final_data/final_data.csv")
latest_ls_data <- data.frame(latest_ls_data)
latest_ls_data <- latest_ls_data %>% filter(lastpage == 21)

latest_ls_data2 <- latest_ls_data
latest_ls_data2 <- latest_ls_data2 %>% filter(Start.prolificPID. == "none")
match_data <- data.frame("ls_id_E" = character(),
                         "ls_id_F" = character(),
                         "p_id" = character(),
                         "age" = character(),
                         "gender" = character(),
                         "screensize" = character())
duplicates <- match_data %>% group_by(match_data$p_id) %>% filter(n() > 1)

the_one <- latest_prolific_data %>% filter(latest_prolific_data$Participant.id == "5ee85ec585a33015e839df78")
the_other_one <- latest_ls_data %>% filter(latest_ls_data$Start.prolificPID. == "5ee85ec585a33015e839df78")

#_______________________________________________________________________________
# check if task difficulty distorts analysis
#_______________________________________________________________________________
data_by_task_wit$task_solar_navigation_style <- as.factor(data_by_task_wit$task_solar_navigation_style)
data_by_task_wit$navigatio_size <- as.factor(data_by_task_wit$navigatio_size)

anova_pragmatic_solar <- aov(task_solar_ueq_pragmatic ~ task_solar_navigation_style * navigatio_size, data = data_by_task_wit)
summary(anova_pragmatic_solar)

anova_pragmatic_battery <- aov(task_battery_ueq_pragmatic ~ task_battery_navigation_style * navigatio_size, data = data_by_task_wit)
summary(anova_pragmatic_battery)

density_pragmatic_small_solar <- ggdensity(data_by_task_wit[data_by_task_wit$navigatio_size == "small", ],
                                        x = "task_solar_ueq_pragmatic",
                                        color = "task_solar_navigation_style",
                                        fill = "task_solar_navigation_style",
                                        palette = c("#00AFBB", "#E7B800"),
                                        add = "mean",
                                        main = "Density Pragmatic Small Menu Solar Task",
                                        xlab = "UEQ Score") +
  scale_x_continuous(limits = c(-3, 3)) +
  stat_overlay_normal_density(aes(color = task_solar_navigation_style, linetype = "dashed"))
density_pragmatic_small_solar

density_pragmatic_small_battery <- ggdensity(data_by_task_wit[data_by_task_wit$navigatio_size == "small", ],
                                           x = "task_battery_ueq_pragmatic",
                                           color = "task_battery_navigation_style",
                                           fill = "task_battery_navigation_style",
                                           palette = c("#00AFBB", "#E7B800"),
                                           add = "mean",
                                           main = "Density Pragmatic Small Menu Battery Task",
                                           xlab = "UEQ Score") +
  scale_x_continuous(limits = c(-3, 3)) +
  stat_overlay_normal_density(aes(color = task_battery_navigation_style, linetype = "dashed"))
density_pragmatic_small_battery

#_______________________________________________________________________________
# check age, gender and other stuff for the between subjects condition
#_______________________________________________________________________________
participant_count_small_navi <- sum(analysis_ueq_scales_wit$navigation_size == "small") / 2
participant_count_big_navi <- sum(analysis_ueq_scales_wit$navigation_size == "big") / 2

# make density graph for age distribution of navigation size groups
nice_data_wit$navigatio_size <- as.factor(nice_data_wit$navigatio_size)
nice_data_wit$age <- as.integer(nice_data_wit$age)
age_navigation_size <- ggdensity(nice_data_wit,
                                        x = "age",
                                        color = "navigatio_size",
                                        fill = "navigatio_size",
                                        palette = c("#00AFBB", "#E7B800"),
                                        add = "mean",
                                        main = "Density Age for Navigation sizes",
                                        xlab = "Age") +
  scale_x_continuous(limits = c(0, 85)) +
  stat_overlay_normal_density(aes(color = navigatio_size, linetype = "dashed"))
age_navigation_size

age_navi_size_wilcox <- wilcox.test(nice_data_wit$age ~ nice_data_wit$navigatio_size, nice_data_wit)
age_navi_size_wilcox

age_navi_size_ttest <- t.test(nice_data_wit$age[nice_data_wit$navigatio_size=="small"], nice_data_wit$age[nice_data_wit$navigatio_size=="big"], var.equal = FALSE)
age_navi_size_ttest

age_navi_size_ttest_d <- cohens_d(age ~ navigatio_size, data = nice_data_wit)
age_navi_size_ttest_d

age_navi_size_ftest <- var.test(nice_data_wit$age[nice_data_wit$navigatio_size=="small"], nice_data_wit$age[nice_data_wit$navigatio_size=="big"])
age_navi_size_ftest

age_navi_size_wtest <- wilcox.test(age ~ navigatio_size, data = nice_data_wit)
age_navi_size_wtest
age_navi_size_wtest_r <- wilcox_effsize(age ~ navigatio_size, data = nice_data_wit)
age_navi_size_wtest_r

# check normal distribution
nice_data_wit %>%
  group_by(navigatio_size) %>%
  shapiro_test(age)

# check homogenity of variance
nice_data_wit %>%
  group_by(navigatio_size) %>%
  levene_test(nice_data_wit$age ~ nice_data_wit$navigatio_size)

# check if there is a difference in gender between navigation size groups
contigency_table_gender <- matrix(nrow = 4, ncol = 2, dimnames = list(c("male", "female", "non-binary", "other"), c("small","big")))

contigency_table_gender[1,1] <- nrow(nice_data_wit %>% filter(navigatio_size=="small" & gender == "man"))
contigency_table_gender[2,1] <- nrow(nice_data_wit %>% filter(navigatio_size=="small" & gender == "woman"))
contigency_table_gender[3,1] <- nrow(nice_data_wit %>% filter(navigatio_size=="small" & gender == "non-binary"))
contigency_table_gender[4,1] <- nrow(nice_data_wit %>% filter(navigatio_size=="small" & gender == "not-disclosed"))
contigency_table_gender[1,2] <- nrow(nice_data_wit %>% filter(navigatio_size=="big" & gender == "man"))
contigency_table_gender[2,2] <- nrow(nice_data_wit %>% filter(navigatio_size=="big" & gender == "woman"))
contigency_table_gender[3,2] <- nrow(nice_data_wit %>% filter(navigatio_size=="big" & gender == "non-binary"))
contigency_table_gender[4,2] <- nrow(nice_data_wit %>% filter(navigatio_size=="big" & gender == "not-disclosed"))

gender_navi_size_chi <- chisq.test(contigency_table_gender)
gender_navi_size_chi
gender_navi_size_V <- cramers_v <- sqrt(gender_navi_size_chi$statistic / sum(contigency_table_gender) * (min(nrow(contigency_table_gender), ncol(contigency_table_gender)) - 1))
gender_navi_size_V
