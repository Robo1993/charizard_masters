#_______________________________________________________________________________
# get neat data to work with
#_______________________________________________________________________________
analysis_solar <- data_by_task_wit %>% select(id, navigation_size, 
                                              task_solar_navigation_style, 
                                              task_solar_mean_time, 
                                              task_solar_ueq_pragmatic, 
                                              task_solar_ueq_hedonic)
analysis_solar <- analysis_solar %>% rename(navigation_style = task_solar_navigation_style,
                                            mean_time = task_solar_mean_time,
                                            ueq_pragmatic = task_solar_ueq_pragmatic,
                                            ueq_hedonic = task_solar_ueq_hedonic)
analysis_battery <- data_by_task_wit %>% select(id, navigation_size, 
                                                task_battery_navigation_style, 
                                                task_battery_mean_time, 
                                                task_battery_ueq_pragmatic, 
                                                task_battery_ueq_hedonic)
analysis_battery <- analysis_battery %>% rename(navigation_style = task_battery_navigation_style,
                                            mean_time = task_battery_mean_time,
                                            ueq_pragmatic = task_battery_ueq_pragmatic,
                                            ueq_hedonic = task_battery_ueq_hedonic)

analysis_solar$navigation_style <- factor(analysis_solar$navigation_style, levels = c("bottomBar", "hamTop"))
analysis_battery$navigation_style <- factor(analysis_battery$navigation_style, levels = c("bottomBar", "hamTop"))

analysis_solar$navigation_size <- as.factor(analysis_solar$navigation_size)
analysis_battery$navigation_size <- as.factor(analysis_battery$navigation_size)

#_______________________________________________________________________________
# do some plots to see if there are meaningful differences
#_______________________________________________________________________________

analysis_solar %>% group_by(navigation_size, navigation_style) %>%
  get_summary_stats(ueq_pragmatic, type = "full")

bxp_solar <- ggboxplot(
  analysis_solar, x = "navigation_style", y = "mean_time",
  color = "navigation_size", palette = "jco",
  xlab = c("Solar Task"),
  ylab = c("Mean mean_time"),
  bxp.errorbar = TRUE,
  ggtheme = theme_classic2()
) #+ scale_y_continuous(limits = c(-3, 3))

bxp_solar

bxp_battery <- ggboxplot(
  analysis_battery, x = "navigation_style", y = "mean_time",
  color = "navigation_size", palette = "jco",
  xlab = c("Battery Task"),
  ylab = c("Mean mean_time"),
  bxp.errorbar = TRUE,
  ggtheme = theme_classic2()
) #+ scale_y_continuous(limits = c(-3, 3))

bxp_battery

#_______________________________________________________________________________
# Anova with task as additional factor
#_______________________________________________________________________________
analysis_data_by_task$task <- as.factor(analysis_data_by_task$task)
analysis_data_by_task$navigation_style <- as.factor(analysis_data_by_task$navigation_style)

anova_pragmatic_complex <- anova_test(
  data = analysis_data_by_task, dv = ueq_pragmatic, wid = participant_id,
  between = c(navigation_size), within = c(task)
)
get_anova_table(anova_pragmatic_complex)

#_______________________________________________________________________________
# pragmatic only for solar task
# !!!!! DOES NOT WORK!!!!!!!! the within variable disappears when only looking at one task
#_______________________________________________________________________________
# transform factors into numbers
# navigation sizes: 2 = small, 1 = big
# navigation style: 1 = bottom bar, 2 = hamburger
analysis_solar$navigation_size <- as.numeric(analysis_solar$navigation_size)
analysis_solar$navigation_style <- as.numeric(analysis_solar$navigation_style)

analysis_solar$ueq_pragmatic <- analysis_solar$ueq_pragmatic + 4
analysis_solar$ueq_hedonic <- analysis_solar$ueq_hedonic + 4
bootstrap_anova_result_tasktime <- bootstrap_2way_rm_anova(analysis_solar$ueq_pragmatic, analysis_solar$navigation_size, analysis_solar$navigation_style, analysis_solar$id, seednumber = 199)
bootstrap_anova_result_tasktime

#_______________________________________________________________________________
# test if there is significant difference in tasks
#_______________________________________________________________________________

wilcox.test(data = analysis_data_by_task[analysis_data_by_task$navigation_size == "small",], ueq_pragmatic ~ task)
wilcox.test(data = analysis_data_by_task[analysis_data_by_task$navigation_size == "big",], ueq_pragmatic ~ task)

wilcox.test(data = analysis_data_by_task[analysis_data_by_task$navigation_size == "small",], ueq_hedonic ~ task)
wilcox.test(data = analysis_data_by_task[analysis_data_by_task$navigation_size == "big",], ueq_hedonic ~ task)

wilcox.test(data = analysis_data_by_task[analysis_data_by_task$navigation_size == "small",], mean_time ~ task)
wilcox.test(data = analysis_data_by_task[analysis_data_by_task$navigation_size == "big",], mean_time ~ task)

bxp_tasks_pragmatic <- ggboxplot(
  data_by_task, x = "task", y = "ueq_pragmatic",
  color = "navigation_size", palette = "jco",
  xlab = c("Tasks"),
  ylab = c("Mean mean_time"),
  bxp.errorbar = TRUE,
  ggtheme = theme_classic2()
) #+ scale_y_continuous(limits = c(-3, 3))

bxp_tasks_pragmatic

bxp_tasks_mean_time <- ggboxplot(
  data_by_task, x = "task", y = "mean_time",
  color = "navigation_size", palette = "jco",
  xlab = c("Tasks"),
  ylab = c("Mean mean_time"),
  bxp.errorbar = TRUE,
  ggtheme = theme_classic2()
) #+ scale_y_continuous(limits = c(-3, 3))

bxp_tasks_mean_time

#_______________________________________________________________________________
# ANOVA
#_______________________________________________________________________________
data_solar <- data_by_task[data_by_task$task == "battery",]
lm_pragmatic_solar <- lme(data = analysis_ueq_scales_wit, mean_time ~ navigation_size * navigation_style, random = ~1 | participant_id, method="ML", control = lmeControl(singular.ok = TRUE))

solar_pragmativ_anova <- anova(lm_pragmatic_solar)
solar_pragmativ_anova
eta_squared(lm_pragmatic_solar)

summary_model <- summary(lm_pragmatic_solar)

# Extract sums of squares
sum_sq <- summary_model$sigma^2 * 200

# Compute partial eta squared for each fixed effect
partial_eta_squared <- sum_sq / sum(sum_sq)

# Print partial eta squared values
partial_eta_squared


custom_eta(lm_pragmatic_solar)

m_pragmatic_solar <- emmeans(lm_pragmatic_solar, ~navigation_style|navigation_size)
m_pragmatic_solar
pairs(m_pragmatic_solar)

c_pragmatic <- eff_size(m_pragmatic_solar, sigma = sigma(lm_pragmatic_solar), edf = 200)
c_pragmatic
