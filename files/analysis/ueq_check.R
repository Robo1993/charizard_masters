plotting_data_ueq <- raw_data %>% filter(raw_data$Start.naviConfig. == "small" & raw_data$solarIntroGranny.navigationSolar. == "hamTop")
ueq_items_means_solar <- data.frame("item" = c("p_obstructive","p_inefficient","p_confusing","p_complicated","h_usual","h_notInteresting","h_conventional","h_boring"),
                              "mean" = c(mean(plotting_data_ueq$solarUEQSusability.obstructive.) - 4,
                                         mean(plotting_data_ueq$solarUEQSusability.inefficient.) - 4,
                                         mean(plotting_data_ueq$solarUEQSusability.confusing.) - 4,
                                         mean(plotting_data_ueq$solarUEQSusability.complicated.) - 4,
                                         mean(plotting_data_ueq$solarUEQShedonism.usual.) - 4,
                                         mean(plotting_data_ueq$solarUEQShedonism.notInteresting.) - 4,
                                         mean(plotting_data_ueq$solarUEQShedonism.conventional.) - 4,
                                         mean(plotting_data_ueq$solarUEQShedonism.boring.) - 4),
                              "sd" = c(sd(plotting_data_ueq$solarUEQSusability.obstructive.),
                                       sd(plotting_data_ueq$solarUEQSusability.inefficient.),
                                       sd(plotting_data_ueq$solarUEQSusability.confusing.),
                                       sd(plotting_data_ueq$solarUEQSusability.complicated.),
                                       sd(plotting_data_ueq$solarUEQShedonism.usual.),
                                       sd(plotting_data_ueq$solarUEQShedonism.notInteresting.),
                                       sd(plotting_data_ueq$solarUEQShedonism.conventional.),
                                       sd(plotting_data_ueq$solarUEQShedonism.boring.)))

ueq_items_means_battery <- data.frame("item" = c("p_obstructive","p_inefficient","p_confusing","p_complicated","h_usual","h_notInteresting","h_conventional","h_boring"),
                                    "mean" = c(mean(plotting_data_ueq$batteryUEQSusability.obstructive.) - 4,
                                               mean(plotting_data_ueq$batteryUEQSusability.inefficient.) - 4,
                                               mean(plotting_data_ueq$batteryUEQSusability.confusing.) - 4,
                                               mean(plotting_data_ueq$batteryUEQSusability.complicated.) - 4,
                                               mean(plotting_data_ueq$batteryUEQShedonism.usual.) - 4,
                                               mean(plotting_data_ueq$batteryUEQShedonism.notInteresting.) - 4,
                                               mean(plotting_data_ueq$batteryUEQShedonism.conventional.) - 4,
                                               mean(plotting_data_ueq$batteryUEQShedonism.boring.) - 4),
                                    "sd" = c(sd(plotting_data_ueq$batteryUEQSusability.obstructive.),
                                             sd(plotting_data_ueq$batteryUEQSusability.inefficient.),
                                             sd(plotting_data_ueq$batteryUEQSusability.confusing.),
                                             sd(plotting_data_ueq$batteryUEQSusability.complicated.),
                                             sd(plotting_data_ueq$batteryUEQShedonism.usual.),
                                             sd(plotting_data_ueq$batteryUEQShedonism.notInteresting.),
                                             sd(plotting_data_ueq$batteryUEQShedonism.conventional.),
                                             sd(plotting_data_ueq$batteryUEQShedonism.boring.)))

ueq_items_solar <- ggbarplot(
  ueq_items_means_solar, x = "item", y = "mean",
  color = "item", palette = "simpsons",
  xlab = NULL,
  ylab = c("Item means"),
  bxp.errorbar = TRUE,
  ggtheme = theme_classic2()
) + geom_errorbar(aes(ymin=mean-sd, ymax=mean+sd), width=.2,
                  position=position_dodge(.9)) 
ueq_items_solar

ueq_items_battery <- ggbarplot(
  ueq_items_means_battery, x = "item", y = "mean",
  color = "item", palette = "simpsons",
  xlab = NULL,
  ylab = c("Item means"),
  bxp.errorbar = TRUE,
  ggtheme = theme_classic2()
) + geom_errorbar(aes(ymin=mean-sd, ymax=mean+sd), width=.2,
                  position=position_dodge(.9)) 
ueq_items_battery

#_______________________________________________________________________________

# descriptive statistics by task
#_______________________________________________________________________________

# Pragmatic Scale
#_______________________________
# Solar Task
solar_data_small_ham <- raw_data %>% 
  filter(raw_data$Start.naviConfig. == "small" & raw_data$solarIntroGranny.navigationSolar. == "hamTop") %>% 
  dplyr::select(solarUEQSusability.obstructive., solarUEQSusability.complicated., solarUEQSusability.inefficient., solarUEQSusability.confusing.)

solar_data_small_bot <- raw_data %>% 
  filter(raw_data$Start.naviConfig. == "small" & raw_data$solarIntroGranny.navigationSolar. == "bottomBar") %>% 
  dplyr::select(solarUEQSusability.obstructive., solarUEQSusability.complicated., solarUEQSusability.inefficient., solarUEQSusability.confusing.)

solar_data_big_ham <- raw_data %>% 
  filter(raw_data$Start.naviConfig. == "big" & raw_data$solarIntroGranny.navigationSolar. == "hamTop") %>% 
  dplyr::select(solarUEQSusability.obstructive., solarUEQSusability.complicated., solarUEQSusability.inefficient., solarUEQSusability.confusing.)

solar_data_big_bot <- raw_data %>% 
  filter(raw_data$Start.naviConfig. == "big" & raw_data$solarIntroGranny.navigationSolar. == "bottomBar") %>% 
  dplyr::select(solarUEQSusability.obstructive., solarUEQSusability.complicated., solarUEQSusability.inefficient., solarUEQSusability.confusing.)

# Battery Task
battery_data_small_ham <- raw_data %>% 
  filter(raw_data$Start.naviConfig. == "small" & raw_data$solarIntroGranny.navigationSolar. == "hamTop") %>% 
  dplyr::select(batteryUEQSusability.obstructive., batteryUEQSusability.complicated., batteryUEQSusability.inefficient., batteryUEQSusability.confusing.)

battery_data_small_bot <- raw_data %>% 
  filter(raw_data$Start.naviConfig. == "small" & raw_data$solarIntroGranny.navigationSolar. == "bottomBar") %>% 
  dplyr::select(batteryUEQSusability.obstructive., batteryUEQSusability.complicated., batteryUEQSusability.inefficient., batteryUEQSusability.confusing.)

battery_data_big_ham <- raw_data %>% 
  filter(raw_data$Start.naviConfig. == "big" & raw_data$solarIntroGranny.navigationSolar. == "hamTop") %>% 
  dplyr::select(batteryUEQSusability.obstructive., batteryUEQSusability.complicated., batteryUEQSusability.inefficient., batteryUEQSusability.confusing.)

battery_data_big_bot <- raw_data %>% 
  filter(raw_data$Start.naviConfig. == "big" & raw_data$solarIntroGranny.navigationSolar. == "bottomBar") %>% 
  dplyr::select(batteryUEQSusability.obstructive., batteryUEQSusability.complicated., batteryUEQSusability.inefficient., batteryUEQSusability.confusing.)

# Pragmatic Scale
#_______________________________
# Solar Task
hedon_solar_data_small_ham <- raw_data %>% 
  filter(raw_data$Start.naviConfig. == "small" & raw_data$solarIntroGranny.navigationSolar. == "hamTop") %>% 
  dplyr::select(solarUEQShedonism.boring., solarUEQShedonism.notInteresting., solarUEQShedonism.conventional., solarUEQShedonism.usual.)

hedon_solar_data_small_bot <- raw_data %>% 
  filter(raw_data$Start.naviConfig. == "small" & raw_data$solarIntroGranny.navigationSolar. == "bottomBar") %>% 
  dplyr::select(solarUEQShedonism.boring., solarUEQShedonism.notInteresting., solarUEQShedonism.conventional., solarUEQShedonism.usual.)

hedon_solar_data_big_ham <- raw_data %>% 
  filter(raw_data$Start.naviConfig. == "big" & raw_data$solarIntroGranny.navigationSolar. == "hamTop") %>% 
  dplyr::select(solarUEQShedonism.boring., solarUEQShedonism.notInteresting., solarUEQShedonism.conventional., solarUEQShedonism.usual.)

hedon_solar_data_big_bot <- raw_data %>% 
  filter(raw_data$Start.naviConfig. == "big" & raw_data$solarIntroGranny.navigationSolar. == "bottomBar") %>% 
  dplyr::select(solarUEQShedonism.boring., solarUEQShedonism.notInteresting., solarUEQShedonism.conventional., solarUEQShedonism.usual.)

# Battery Task
hedon_battery_data_small_ham <- raw_data %>% 
  filter(raw_data$Start.naviConfig. == "small" & raw_data$solarIntroGranny.navigationSolar. == "hamTop") %>% 
  dplyr::select(batteryUEQShedonism.boring., batteryUEQShedonism.notInteresting., batteryUEQShedonism.conventional., batteryUEQShedonism.usual.)

hedon_battery_data_small_bot <- raw_data %>% 
  filter(raw_data$Start.naviConfig. == "small" & raw_data$solarIntroGranny.navigationSolar. == "bottomBar") %>% 
  dplyr::select(batteryUEQShedonism.boring., batteryUEQShedonism.notInteresting., batteryUEQShedonism.conventional., batteryUEQShedonism.usual.)

hedon_battery_data_big_ham <- raw_data %>% 
  filter(raw_data$Start.naviConfig. == "big" & raw_data$solarIntroGranny.navigationSolar. == "hamTop") %>% 
  dplyr::select(batteryUEQShedonism.boring., batteryUEQShedonism.notInteresting., batteryUEQShedonism.conventional., batteryUEQShedonism.usual.)

hedon_battery_data_big_bot <- raw_data %>% 
  filter(raw_data$Start.naviConfig. == "big" & raw_data$solarIntroGranny.navigationSolar. == "bottomBar") %>% 
  dplyr::select(batteryUEQShedonism.boring., batteryUEQShedonism.notInteresting., batteryUEQShedonism.conventional., batteryUEQShedonism.usual.)

# results
describe(solar_data_small_ham)
describe(solar_data_small_bot)
describe(solar_data_big_ham)
describe(solar_data_big_bot)

describe(battery_data_small_ham)
describe(battery_data_small_bot)
describe(battery_data_big_ham)
describe(battery_data_big_bot)

# for pragmatic scale
alpha(rbind(solar_data_small_ham, solar_data_small_bot))
alpha(rbind(solar_data_big_ham, solar_data_big_bot))
alpha(rbind(battery_data_small_ham, battery_data_small_bot))
alpha(rbind(battery_data_big_ham, battery_data_big_bot))

# for hedonic scale
alpha(rbind(hedon_solar_data_small_ham, hedon_solar_data_small_bot))
alpha(rbind(hedon_solar_data_big_ham, hedon_solar_data_big_bot))
alpha(rbind(hedon_battery_data_small_ham, hedon_battery_data_small_bot))
alpha(rbind(hedon_battery_data_big_ham, hedon_battery_data_big_bot))

#_____________________________________________________________________________________________
# Switcherooo, calculate the alpha grouped by navigation style and not by task (doesn't matter since both task order and navigation style order were randomized)
#_____________________________________________________________________________________________

# for pragmatic scale
alpha(solar_data_small_ham)
alpha(solar_data_small_bot)
alpha(solar_data_big_ham)
alpha(solar_data_big_bot)
alpha(battery_data_small_ham)
alpha(battery_data_small_bot)
alpha(battery_data_big_ham)
alpha(battery_data_big_bot)


# for hedonic scale
alpha(hedon_solar_data_small_ham)
alpha(hedon_solar_data_small_bot)
alpha(hedon_solar_data_big_ham)
alpha(hedon_solar_data_big_bot)
alpha(hedon_battery_data_small_ham)
alpha(hedon_battery_data_small_bot)
alpha(hedon_battery_data_big_ham)
alpha(hedon_battery_data_big_bot)

#_______________________________________________________________________________
# Omega
#
install.packages("MBESS", dependencies = TRUE)
library(MBESS)
# for pragmatic scale
ci.reliability(data=solar_data_small_ham, type="omega", conf.level = 0.95,interval.type="bca", B=1000)
ci.reliability(data=solar_data_small_bot, type="omega", conf.level = 0.95,interval.type="bca", B=1000)
ci.reliability(data=solar_data_big_ham, type="omega", conf.level = 0.95,interval.type="bca", B=1000)
ci.reliability(data=solar_data_big_bot, type="omega", conf.level = 0.95,interval.type="bca", B=1000)
ci.reliability(data=battery_data_small_ham, type="omega", conf.level = 0.95,interval.type="bca", B=1000)
ci.reliability(data=battery_data_small_bot, type="omega", conf.level = 0.95,interval.type="bca", B=1000)
ci.reliability(data=battery_data_big_ham, type="omega", conf.level = 0.95,interval.type="bca", B=1000)
ci.reliability(data=battery_data_big_bot, type="omega", conf.level = 0.95,interval.type="bca", B=1000)


# for hedonic scale
ci.reliability(data=hedon_solar_data_small_ham, type="omega", conf.level = 0.95,interval.type="bca", B=1000)
ci.reliability(data=hedon_solar_data_small_bot, type="omega", conf.level = 0.95,interval.type="bca", B=1000)
ci.reliability(data=hedon_solar_data_big_ham, type="omega", conf.level = 0.95,interval.type="bca", B=1000)
ci.reliability(data=hedon_solar_data_big_bot, type="omega", conf.level = 0.95,interval.type="bca", B=1000)
ci.reliability(data=hedon_battery_data_small_ham, type="omega", conf.level = 0.95,interval.type="bca", B=1000)
ci.reliability(data=hedon_battery_data_small_bot, type="omega", conf.level = 0.95,interval.type="bca", B=1000)
ci.reliability(data=hedon_battery_data_big_ham, type="omega", conf.level = 0.95,interval.type="bca", B=1000)
ci.reliability(data=hedon_battery_data_big_bot, type="omega", conf.level = 0.95,interval.type="bca", B=1000)

