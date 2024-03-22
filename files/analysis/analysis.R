install.packages(c("ggplot2", "ggpubr", "tidyverse", "broom", "dplyr", "rstatix", "psych", "pgirmess", "pbkrtest", "afex", "Rtools", "nlme", "PMCMRplus", "lme4", "coin", "nparcomp"))
library(dplyr)
library(ggplot2)
library(ggpubr)
library(tidyverse)
library(broom)
library(rstatix)
library(psych)
library(pgirmess)
#library(pbkrtest) --> uses lm4 which has conflicts with nlme (used for bootstrapping)
library(lme4)
library(afex)
library(nlme)
library(PMCMRplus)
library(emmeans)
library(coin)
library(nparcomp)

source("neatData.R")
source("strapping_by_Nadine_Spychala.R")

limesurvey_data <- read.csv("results-master-thesis-limesurvey.csv")
first_fifty <- read.csv("final_data/first_50.csv")
new <- read.csv("final_data/new.csv")
first_hun <- read.csv("final_data/first_100.csv")
first_hunf <- read.csv("final_data/first_150.csv")
first_hunf_anti <- read.csv("final_data/first_150.csv")
final_data <- read.csv("final_data/final_data.csv")
first_hunf_anti <- data.frame(first_hunf_anti)
final_data <- data.frame(final_data)
analysis_data <- data.frame(final_data)

# analysis_data_wit <- analysis_data
# analysis_data_wit <- analysis_data %>% 
#   filter(Xbattery1.completed. != 0 
#          & Xbattery2.completed. != 0
#          & Xsolar1.completed. != 0
#          & Xsolar2.completed. != 0)

analysis_data_wit <- read.csv("final_data/analysis_data.csv")
analysis_ueq_scales_wit$navigation_size <- as.factor(analysis_ueq_scales_wit$navigation_size)
analysis_ueq_scales_wit$navigation_style <- as.factor(analysis_ueq_scales_wit$navigation_style)

data_by_task <- read.csv("final_data/analysis_by_task_data.csv")
raw_data <- read.csv("final_data/raw_data.csv")

analysis_data_wit_wol <- analysis_data %>% filter(Xbattery1.taskTime. <= 61000 
                                              & Xbattery2.taskTime. <= 61000
                                              & Xsolar1.taskTime. <= 61000
                                              & Xsolar2.taskTime. <= 61000)

nice_data_wit <- get_data_by_navigation_style(analysis_data_wit)
data_by_task_wit <- get_data_by_task(analysis_data_wit)
analysis_data_by_task <- get_ueq_analysis_with_tasks(data_by_task_wit)
analysis_ueq_scales_wit <- get_ueq_analysis(nice_data_wit)


# UEQ-S data for checking consistency
bottom_only_ueq_pragmatic_data <- analysis_data %>% filter() %>% select(solarUEQSusability.obstructive., solarUEQSusability.complicated., solarUEQSusability.inefficient., solarUEQSusability.confusing.)
ham_only_ueq_pragmatic_data <- analysis_data %>% filter() %>% select(solarUEQSusability.obstructive., solarUEQSusability.complicated., solarUEQSusability.inefficient., solarUEQSusability.confusing.)

bottom_only_ueq_hedonism_data <- analysis_data %>% filter() %>% select(solarUEQShedonism.boring., solarUEQShedonism.notInteresting., solarUEQShedonism.conventional., solarUEQShedonism.usual.)
ham_only_ueq_hedonism_data <- analysis_data %>% filter() %>% select(solarUEQShedonism.boring., solarUEQShedonism.notInteresting., solarUEQShedonism.conventional., solarUEQShedonism.usual.)
only_taskTime_data <- analysis_data %>% select(Xsolar1.taskTime., Xsolar2.taskTime., Xbattery1.taskTime., Xbattery2.taskTime.)

# cronbachs alpha for the ueq-s items
alpha(only_ueq_pragmatic_data %>% filter(only_ueq_pragmatic_data$navigation_size == "small"))
alpha(only_ueq_hedonism_data)

task_time_long <- only_taskTime_data %>% pivot_longer(cols=c('Xsolar1.taskTime.', 'Xsolar2.taskTime.', 'Xbattery1.taskTime.', 'Xbattery2.taskTime.'),
                                   names_to='task',
                                   values_to='time')
str(task_time_long)


bxp_times_per_task <- ggplot(task_time_long) + geom_boxplot(aes(x = task_time_long$task, y = task_time_long$time, group = task_time_long$task))
bxp_times_per_task

# check if the navigation style randomization is okay.
ham_solar <- nrow(final_data %>% filter(solarIntroGranny.navigationSolar. == "hamTop"))
ham_battery <- nrow(final_data %>% filter(batteryIntroGranny.navigationBattery. == "hamTop"))
bottom_solar <- nrow(final_data %>% filter(solarIntroGranny.navigationSolar. == "bottomBar"))
bottom_battery <- nrow(final_data %>% filter(batteryIntroGranny.navigationBattery. == "bottomBar"))
ham_solar
ham_battery
bottom_solar
bottom_battery

big <- nrow(final_data %>% filter(Start.naviConfig. == "big"))
small <- nrow(final_data %>% filter(Start.naviConfig. == "small"))
big
small

ls_women <- nrow(subset(final_data, final_data$Gender.gender. == "woman"))
ls_men <- nrow(subset(final_data, final_data$Gender.gender. == "man"))
ls_other <- nrow(subset(final_data, final_data$Gender.gender. != "man" & final_data$Gender.gender. != "woman"))

ls_other
ls_women
ls_men

final_data <- final_data %>% filter(lastpage == 21)

# clean dataset
# remove entries that did not finish the survey
analysis_data <- analysis_data %>% filter(lastpage == 21)
analysis_data <- analysis_data %>% filter(Start.prolificPID. != "{{%PROLIFIC_PID%}}")
#analysis_data <- analysis_data %>% filter(Start.prolificPID. != "none")

nice_data <- get_data_by_navigation_style(analysis_data)
data_by_task <- get_data_by_task(analysis_data)
analysis_ueq_scales <- get_ueq_analysis(nice_data)

col_names <- c(2:3,4)
analysis_ueq_scales[,col_names] <- lapply(analysis_ueq_scales[,col_names] , factor)
str(analysis_ueq_scales_wit)

# descriptive statistics
describe(analysis_ueq_scales_wit)

describe(analysis_ueq_scales_wit %>% filter(navigation_size == "small" & navigation_style == "hamburger"))
# t-test for H1
# UEQ-S pragmatic score
t_test1 <- t.test(analysis_data_wit$ueq_pragmatic[analysis_data_wit$navigation_size=="big"], analysis_data_wit$ueq_pragmatic[analysis_data_wit$navigation_size=="small"], var.equal = FALSE)
t_test1
# UEQ-S hedonic score
t_test2 <- t.test(analysis_data_wit$ueq_hedonic[analysis_data_wit$navigation_size=="big"], analysis_data_wit$ueq_hedonic[analysis_data_wit$navigation_size=="small"], var.equal = FALSE)
t_test2
# Task completion time
t_test3 <- t.test(analysis_data_wit$mean_time[analysis_data_wit$navigation_size=="big"], analysis_data_wit$mean_time[analysis_data_wit$navigation_size=="small"], var.equal = FALSE)
t_test3

t_test4 <- t.test(analysis_ueq_scales$ueq_pragmatic[analysis_ueq_scales$navigation_style=="bottom_bar"], analysis_ueq_scales$ueq_pragmatic[analysis_ueq_scales$navigation_style=="hamburger"])
t_test4

t_test5 <- t.test(analysis_ueq_scales$ueq_hedonic[analysis_ueq_scales$navigation_style=="bottom_bar"], analysis_ueq_scales$ueq_hedonic[analysis_ueq_scales$navigation_style=="hamburger"])
t_test5

t_test6 <- t.test(analysis_ueq_scales$mean_time[analysis_ueq_scales$navigation_style=="bottom_bar"], analysis_ueq_scales$mean_time[analysis_ueq_scales$navigation_style=="hamburger"])
t_test6

t_test991 <- t.test(analysis_ueq_scales$ueq_pragmatic[analysis_ueq_scales$navigation_size=="big" & analysis_ueq_scales$navigation_style=="bottom_bar"], analysis_ueq_scales$ueq_pragmatic[analysis_ueq_scales$navigation_size=="big" & analysis_ueq_scales$navigation_style=="hamburger"])
t_test991

w_test_999 <- wilcox_test(ueq_pragmatic ~ navigation_style, data = analysis_ueq_scales_wit[analysis_ueq_scales_wit$navigation_size=="small",])
w_test_999


#-------------------------------------------------------------------------------------------------------------------------------------------------------------
# anovas for H2-3
#-------------------------------------------------------------------------------------------------------------------------------------------------------------

# normality assumption
# if significant, the distribution is likely not normally distributet


# homogenity of variance

analysis_ueq_scales_wit %>%
  group_by(navigation_size) %>%
  levene_test(ueq_pragmatic ~ navigation_style)

analysis_ueq_scales_wit %>%
  group_by(navigation_size) %>%
  levene_test(ueq_hedonic ~ navigation_style)

analysis_ueq_scales_wit %>%
  group_by(navigation_size) %>%
  levene_test(mean_time ~ navigation_style)

# homogenity of covariance
box_m(analysis_ueq_scales_wit[, "ueq_pragmatic", drop = FALSE], analysis_ueq_scales_wit$navigation_size)

box_m(analysis_ueq_scales_wit[, "ueq_hedonic", drop = FALSE], analysis_ueq_scales_wit$navigation_size)

box_m(analysis_ueq_scales_wit[, "mean_time", drop = FALSE], analysis_ueq_scales_wit$navigation_size)


# Two-way mixed ANOVA test UEQ-S pragmatic score
anova_pragmatic <- anova_test(
  data = analysis_ueq_scales_wit, dv = ueq_pragmatic, wid = participant_id,
  between = navigation_size, within = navigation_style
)
get_anova_table(anova_pragmatic)
eta_squared(anova_pragmatic)

# Two-way mixed ANOVA test UEQ-S hedonic score
anova_hedonic <- anova_test(
  data = analysis_ueq_scales_wit, dv = ueq_hedonic, wid = participant_id,
  between = navigation_size, within = navigation_style
)
get_anova_table(anova_hedonic)
eta_squared(anova_hedonic)

# Two-way mixed ANOVA test task completion time
anova_time <- anova_test(
  data = analysis_ueq_scales_wit, dv = mean_time, wid = participant_id,
  between = navigation_size, within = navigation_style
)
get_anova_table(anova_time)
eta_squared(anova_time)

anova_ueq_total <- anova_test(
  data = test_data, dv = ueq_total, wid = participant_id,
  between = navigation_size, within = navigation_style
)
get_anova_table(anova_ueq_total)

#_______________________________________________________________________________
# Bootstrapping
#_______________________________________________________________________________
analysis_ueq_scales_non_centered <- analysis_ueq_scales_wit
analysis_ueq_scales_non_centered$ueq_pragmatic <- analysis_ueq_scales_non_centered$ueq_pragmatic + 4
analysis_ueq_scales_non_centered$ueq_hedonic <- analysis_ueq_scales_non_centered$ueq_hedonic + 4

# transform factors into numbers
# navigation sizes: 2 = small, 1 = big
# navigation style: 1 = bottom bar, 2 = hamburger
analysis_ueq_scales_non_centered$navigation_size <- as.numeric(analysis_ueq_scales_non_centered$navigation_size)
analysis_ueq_scales_non_centered$navigation_style <- as.numeric(analysis_ueq_scales_non_centered$navigation_style)

# do the bootstrapping

# for pragmatic ueq score
bootstrap_anova_result_pragmatic <- bootstrap_2way_rm_anova(analysis_ueq_scales_non_centered$ueq_pragmatic, analysis_ueq_scales_non_centered$navigation_size, analysis_ueq_scales_non_centered$navigation_style, analysis_ueq_scales_non_centered$participant_id, seednumber = 99)
bootstrap_anova_result_pragmatic

# for hedonic ueq score
bootstrap_anova_result_hedonic <- bootstrap_2way_rm_anova(analysis_ueq_scales_non_centered$ueq_hedonic, analysis_ueq_scales_non_centered$navigation_size, analysis_ueq_scales_non_centered$navigation_style, analysis_ueq_scales_non_centered$participant_id, seednumber = 98)
bootstrap_anova_result_hedonic

#for task completion time
bootstrap_anova_result_tasktime <- bootstrap_2way_rm_anova(analysis_ueq_scales_non_centered$mean_time, analysis_ueq_scales_non_centered$navigation_size, analysis_ueq_scales_non_centered$navigation_style, analysis_ueq_scales_non_centered$participant_id, seednumber = 97)
bootstrap_anova_result_tasktime

#-----------------------------------------------------------------------------------------
# follow up tests for comparing groups
#-----------------------------------------------------------------------------------------

tamhane_test_pragmatic_small <- tamhaneT2Test(ueq_pragmatic ~ navigation_style, data = analysis_ueq_scales_wit[analysis_ueq_scales_wit$navigation_size=="small",])
tamhane_test_pragmatic_small

tamhane_test_pragmatic_big <- tamhaneT2Test(ueq_pragmatic ~ navigation_style, data = analysis_ueq_scales_wit[analysis_ueq_scales_wit$navigation_size=="big",])
tamhane_test_pragmatic_big

tamhane_test_pragmatic <- tamhaneT2Test(ueq_pragmatic ~ navigation_style, data = analysis_ueq_scales_wit)
tamhane_test_pragmatic

#---------------------------------------
# pragmatic score follow up
#---------------------------------------
a_pragmatic <- aov_ez("participant_id", "ueq_pragmatic", analysis_ueq_scales_wit, between = "navigation_size", within = "navigation_style")
lm_pragmatic <- lme(data = data_mean_time_cutoff, ueq_pragmatic ~ navigation_size * navigation_style, random = ~1 | participant_id, method="ML", control = lmeControl(singular.ok = TRUE))
lmer_pragmatic <- afex::lmer(ueq_pragmatic ~ navigation_size * navigation_style + (1 | participant_id), 
                       data = analysis_ueq_scales_wit)
anova_check <- anova(lm_pragmatic)
anova_check
a_pragmatic
eta_squared(lm_pragmatic)

data_solar <- data_by_task[data_by_task$task == "solar",]

summary_model <- summary(lm_pragmatic)

# Extract sums of squares
sum_sq <- summary_model$sigma^2 * 200

# Compute partial eta squared for each fixed effect
partial_eta_squared <- sum_sq / sum(sum_sq)

# Print partial eta squared values
partial_eta_squared


custom_eta(lm_pragmatic)

m_pragmatic_check <- emmeans(lm_pragmatic, ~navigation_style|navigation_size)
m_pragmatic <- emmeans(a_pragmatic, ~ navigation_style|navigation_size)
m_pragmatic
pairs(m_pragmatic)
pairs(m_pragmatic_check)

c_pragmatic <- eff_size(m_pragmatic_check, sigma = sigma(lm_pragmatic), edf = 200)
c_pragmatic

pairwise_within <- pairwise.wilcox.test(ueq_pragmatic ~ navigation_style | navigation_size, data = data_mean_time_cutoff, p.adjust.method = "bonferroni")
pairwise_between <- pairwise.wilcox.test(ueq_pragmatic ~ navigation_size, data = data_mean_time_cutoff, p.adjust.method = "bonferroni")

# Print the results
print(pairwise_within)
print(pairwise_between)

install.packages("dunn.test")
library(dunn.test)
library(conover.test)
library(coin)
library(FSA)
library(effectsize)
source("eta_squared.R")

# Dunn's test
dunn_result <- dunn.test(ueq_pragmatic ~ navigation_size * navigation_style, data = data_mean_time_cutoff, method = "bonferroni")

# Print the results
print(dunn_result)

# Conover-Iman test
conover_result <- conover.test(ueq_pragmatic ~ navigation_size * navigation_style, data = data_mean_time_cutoff)

# Print the results
print(conover_result)

d_pragmatic_small <- dunnTest(ueq_pragmatic ~ navigation_style,
                            data=data_mean_time_cutoff[data_mean_time_cutoff$navigation_size == "small",],
                            method="bonferroni")

data_solar <- data_by_task[data_by_task$task == "solar",]


d_pragmatic_big <- dunnTest(ueq_pragmatic ~ navigation_style,
                            data=data_mean_time_cutoff[data_mean_time_cutoff$navigation_size == "big",],
                            method="bonferroni")


d_pragmatic_big
d_pragmatic_small

conover_test_small <- conover.test(analysis_ueq_scales_wit$ueq_pragmatic[analysis_ueq_scales_wit$navigation_size == "big"], analysis_ueq_scales_wit$navigation_style[analysis_ueq_scales_wit$navigation_size == "big"], method="hs", list=TRUE)
conover_test_small

#---------------------------------------
# hedonic score follow up
#---------------------------------------
a_hedonic_old <- aov_ez("participant_id", "ueq_hedonic", analysis_ueq_scales_wit, between = "navigation_size", within = "navigation_style")
lm_hedonic <- lme(data = data_mean_time_cutoff, ueq_hedonic ~ navigation_size * navigation_style, random = ~1 | participant_id, method="ML", control = lmeControl(singular.ok = TRUE))
a_hedonic <- anova(lm_hedonic)
a_hedonic
eta_squared(lm_hedonic)

m_hedonic <- emmeans(lm_hedonic, ~ navigation_style|navigation_size)
m_hedonic
m_hedonic2 <- emmeans(lm_hedonic, ~ navigation_size|navigation_style)
m_hedonic2
pairs(m_hedonic)
pairs(m_hedonic2)

c_hedonic <- eff_size(m_hedonic, sigma = sigma(lm_hedonic), edf = 200)
c_hedonic

d_hedonic_small <- dunnTest(ueq_hedonic ~ navigation_style,
                              data=data_mean_time_cutoff[data_mean_time_cutoff$navigation_size == "small",],
                              method="bonferroni")



d_hedonic_big <- dunnTest(ueq_hedonic ~ navigation_style,
                            data=data_mean_time_cutoff[data_mean_time_cutoff$navigation_size == "big",],
                            method="bonferroni")


d_hedonic_big
d_hedonic_small

#---------------------------------------
# task completion time follow up
#---------------------------------------
data_mean_time_cutoff <- analysis_data_wit %>% filter(mean_time < 50000)
a_mean_time_old <- aov_ez("participant_id", "mean_time", analysis_ueq_scales_wit, between = "navigation_size", within = "navigation_style")
lm_mean_time <- lme(data = analysis_ueq_scales_wit, mean_time ~ navigation_size * navigation_style, random = ~1 | participant_id, method="ML", control = lmeControl(singular.ok = TRUE))
a_mean_time <- anova(lm_mean_time)
a_mean_time
eta_squared(lm_mean_time, partial = TRUE)

m_mean_time_interaction <- emmeans(lm_mean_time, ~ navigation_style|navigation_size)
m_mean_time_interaction
pairs(m_mean_time_interaction)

c_mean_time <- eff_size(m_mean_time_interaction, sigma = sigma(lm_mean_time), edf = 200)
c_mean_time

d_time_small <- dunnTest(mean_time ~ navigation_style,
                            data=analysis_ueq_scales_wit[analysis_ueq_scales_wit$navigation_size == "small",],
                            method="bonferroni")



d_time_big <- dunnTest(mean_time ~ navigation_style,
                          data=analysis_ueq_scales_wit[analysis_ueq_scales_wit$navigation_size == "big",],
                          method="bonferroni")


d_time_big
d_time_small
  
  
  
lm_mt_dropouts <- lme(data = data_mean_time_cutoff, mean_time ~ navigation_size * navigation_style, random = ~1 | participant_id, method="ML", control = lmeControl(singular.ok = TRUE))
a_mean_time_dropouts <- anova(lm_mt_dropouts)
m_mt_dropouts <- emmeans(lm_mt_dropouts, ~ navigation_style|navigation_size)
pairs(m_mt_dropouts)
eff_size(m_mt_dropouts, sigma = sigma(lm_mt_dropouts), edf = 149)

d_time_big_dropouts <- dunnTest(mean_time ~ navigation_style,
                       data=data_mean_time_cutoff[data_mean_time_cutoff$navigation_size == "big",],
                       method="bonferroni")
d_time_big_dropouts

#---------------------------------------
# testing by task
#---------------------------------------
data_solar <- analysis_data_by_task %>% filter(task == "solar")
data_battery <- analysis_data_by_task %>% filter(task == "battery")
analysis_data_by_task$task <- as.factor(analysis_data_by_task$task)

lm_pragmatic_solar <- lme(data = data_battery, ueq_hedonic ~ navigation_size * navigation_style, random = ~1 | participant_id, method="ML", control = lmeControl(singular.ok = TRUE))
a_pragmatic_solar <- anova(lm_pragmatic_solar)
a_pragmatic_solar
eta_squared(lm_pragmatic_solar)

m_hedonic <- emmeans(lm_hedonic, ~ navigation_style|navigation_size)
m_hedonic
m_hedonic2 <- emmeans(lm_hedonic, ~ navigation_size|navigation_style)
m_hedonic2
pairs(m_hedonic)
pairs(m_hedonic2)

c_hedonic <- eff_size(m_hedonic, sigma = sigma(lm_hedonic), edf = 200)
c_hedonic

d_hedonic_small <- dunnTest(ueq_hedonic ~ navigation_style,
                            data=analysis_ueq_scales_wit[analysis_ueq_scales_wit$navigation_size == "small",],
                            method="bonferroni")



d_hedonic_big <- dunnTest(ueq_hedonic ~ navigation_style,
                          data=analysis_ueq_scales_wit[analysis_ueq_scales_wit$navigation_size == "big",],
                          method="bonferroni")


d_hedonic_big
d_hedonic_small

#-------------------------------------------------------------------------------
# only test remaining: equivalence testing for the mean time differences between
# hamburger and bottom bar for the big navigation size
#-------------------------------------------------------------------------------
# TBD!!!!!!!!! --> not neeeded?

