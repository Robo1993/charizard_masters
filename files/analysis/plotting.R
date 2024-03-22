analysis_ueq_scales_wit %>% group_by(navigation_size, navigation_style) %>%
  get_summary_stats(ueq_pragmatic, type = "full")

analysis_ueq_scales_wit %>% group_by(navigation_size, navigation_style) %>%
  get_summary_stats(ueq_hedonic, type = "full")

analysis_ueq_scales_wit %>% group_by(navigation_size, navigation_style) %>%
  get_summary_stats(mean_time, type = "full")

bxp_pragmatic <- ggboxplot(
  analysis_data_wit, x = "navigation_style", y = "ueq_pragmatic",
  color = "navigation_size", palette = "jco",
  xlab = NULL,
  ylab = c("Mean UEQ-S pragmatic score"),
  bxp.errorbar = TRUE,
  ggtheme = theme_classic2()
) + scale_y_continuous(limits = c(-3, 3))+
  theme(text = element_text(size = 16,family = "serif"))

bxp_hedonic <- ggboxplot(
  analysis_data_by_task[analysis_data_by_task$task == "battery",], x = "navigation_style", y = "ueq_hedonic",
  color = "navigation_size", palette = "jco",
  xlab = NULL,
  ylab = c("Mean UEQ-S hedonic score"),
  bxp.errorbar = TRUE,
  ggtheme = theme_classic2()
)

bxp_mean_time <- ggboxplot(
  data_mean_time_cutoff, x = "navigation_style", y = "mean_time",
  color = "navigation_size", palette = "jco",
  xlab = NULL,
  ylab = c("Mean task completion time"),
  bxp.errorbar = TRUE,
  ggtheme = theme_classic2()
) +
  theme(text = element_text(size = 16,family = "serif"))

bxp_pragmatic
bxp_hedonic
bxp_mean_time

bxp_ueq_total <- ggboxplot(
  test_data, x = "navigation_style", y = "ueq_total",
  color = "navigation_size", palette = "jco",
  xlab = NULL,
  ylab = c("Mean UEQ-S total score"),
  bxp.errorbar = TRUE,
  ggtheme = theme_classic2()
) + scale_y_continuous(limits = c(-3, 3))
bxp_ueq_total

bxp_navigation_size_pragmatic <- ggboxplot(
  analysis_ueq_scales_wit, x = "navigation_size", y = "ueq_pragmatic",
  xlab = c("Navigation Size"),
  ylab = c("UEQ-S pragmatic score"),
  bxp.errorbar = TRUE,
  ggtheme = theme_classic2()
) + scale_y_continuous(limits = c(-3, 3))
bxp_navigation_size_pragmatic

bxp_navigation_size_time <- ggboxplot(
  analysis_ueq_scales_wit, x = "navigation_size", y = "mean_time",
  xlab = c("Navigation Size"),
  ylab = c("Task Completion Time (in ms)"),
  bxp.errorbar = TRUE,
  ggtheme = theme_classic2()
)
bxp_navigation_size_time

# ___________________________________________________________________________


bxp_hedonic_test <- ggboxplot(
  analysis_data_wit[analysis_data_wit$navigation_style == "bottom_bar",], x = "navigation_size", y = "ueq_hedonic",
  color = "navigation_size", palette = "jco",
  xlab = c("Bottom Bar Menu"),
  ylab = c("Mean UEQ-S hedonic score"),
  bxp.errorbar = TRUE,
  ggtheme = theme_classic2()
) +
  theme(text = element_text(size = 16,family = "serif"))
bxp_hedonic_test