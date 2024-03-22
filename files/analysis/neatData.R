get_data_by_navigation_style <- function(data) {
  
  # calculate certain benchmarks
  # e.g. navigation size distribution
  navigation_style_big <- nrow(data[data$Start.naviConfig. == "big", ])
  navigation_style_small <- nrow(data[data$Start.naviConfig. == "small", ])
  rows <- nrow(data)
  
  paste("small: ", navigation_style_small, sep = "")
  paste("big: ", navigation_style_big, sep = "")
  
  cleaned_data <- data.frame("id" = numeric(),
                             "navigatio_size" = character(),
                             "screen_size" = character(),
                             "age" = numeric(),
                             "gender" = character(),
                             "bottom_bar_mean_time" = numeric(),
                             "bottom_bar_ueq_pragmatic" = numeric(),
                             "bottom_bar_ueq_hedonic" = numeric(),
                             "hamburger_mean_time" = numeric(),
                             "hamburger_ueq_pragmatic" = numeric(),
                             "hamburger_ueq_hedonic" = numeric(),
                             "data_quality" = character(),
                             "data_exclusion_reason" = character(),
                             "feedback" = character())
  
  # fill data frame with limesurvey data
  for(i in 1:nrow(data)) {
    task_1 <- list("navigation_style" = data[i, ]$solarIntroGranny.navigationSolar.,
                   "task_1_time" = data[i, ]$Xsolar1.taskTime.,
                   "task_1_moves" = data[i, ]$Xsolar1.moves.,
                   "task_1_completed" = data[i, ]$Xsolar1.completed.,
                   "task_1_errors" = data[i, ]$Xsolar1.errors.,
                   "task_2_time" = data[i, ]$Xsolar2.taskTime.,
                   "task_2_moves" = data[i, ]$Xsolar2.moves.,
                   "task_2_completed" = data[i, ]$Xsolar2.completed.,
                   "task_2_errors" = data[i, ]$Xsolar2.errors.,
                   "ueq_pragmatic" = mean(c(data[i, ]$solarUEQSusability.obstructive. - 4,
                                            data[i, ]$solarUEQSusability.complicated. - 4,
                                            data[i, ]$solarUEQSusability.inefficient. - 4,
                                            data[i, ]$solarUEQSusability.confusing. - 4)),
                   "ueq_hedonic" = mean(c(data[i, ]$solarUEQShedonism.boring. - 4,
                                          data[i, ]$solarUEQShedonism.notInteresting. - 4,
                                          data[i, ]$solarUEQShedonism.conventional. - 4,
                                          data[i, ]$solarUEQShedonism.usual. - 4)))
    
    task_2 <- list("navigation_style" = data[i, ]$batteryIntroGranny.navigationBattery.,
                   "task_1_time" = data[i, ]$Xbattery1.taskTime.,
                   "task_1_moves" = data[i, ]$Xbattery1.moves.,
                   "task_1_completed" = data[i, ]$Xbattery1.completed.,
                   "task_1_errors" = data[i, ]$Xbattery1.errors.,
                   "task_2_time" = data[i, ]$Xbattery2.taskTime.,
                   "task_2_moves" = data[i, ]$Xbattery2.moves.,
                   "task_2_completed" = data[i, ]$Xbattery2.completed.,
                   "task_2_errors" = data[i, ]$Xbattery2.errors.,
                   "ueq_pragmatic" = mean(c(data[i, ]$batteryUEQSusability.obstructive. - 4,
                                            data[i, ]$batteryUEQSusability.complicated. - 4,
                                            data[i, ]$batteryUEQSusability.inefficient. - 4,
                                            data[i, ]$batteryUEQSusability.confusing. - 4)),
                   "ueq_hedonic" = mean(c(data[i, ]$batteryUEQShedonism.boring. - 4,
                                          data[i, ]$batteryUEQShedonism.notInteresting. - 4,
                                          data[i, ]$batteryUEQShedonism.conventional. - 4,
                                          data[i, ]$batteryUEQShedonism.usual. - 4)))
    
    if(task_1[["navigation_style"]] == "bottomBar") {
      bottom_bar <- task_1
      hamburger <- task_2
    }else {
      bottom_bar <- task_2
      hamburger <- task_1
    }
    
    # to calculate the UEQ-S scores I just need to calculate the mean of all four items for all participants for a factor
    
    cleaned_data[nrow(cleaned_data) + 1,] <- list("id" = data[i, ]$id,
                                                  "navigatio_size" = data[i, ]$Start.naviConfig.,
                                                  "screen_size" = data[i, ]$Start.screenSize.,
                                                  "age" = data[i, ]$Age,
                                                  "gender" = data[i, ]$Gender,
                                                  "bottom_bar_mean_time" = mean(c(bottom_bar$task_1_time,
                                                                                  bottom_bar$task_2_time)),
                                                  "bottom_bar_ueq_pragmatic" = bottom_bar$ueq_pragmatic,
                                                  "bottom_bar_ueq_hedonic" = bottom_bar$ueq_hedonic,
                                                  "hamburger_mean_time" = mean(c(hamburger$task_1_time,
                                                                                 hamburger$task_2_time)),
                                                  "hamburger_ueq_pragmatic" = hamburger$ueq_pragmatic,
                                                  "hamburger_ueq_hedonic" = hamburger$ueq_hedonic,
                                                  "data_quality" = data[i, ]$DataQuality,
                                                  "data_exclusion_reason" = data[i, ]$DataQualityFollowUp,
                                                  "feedback" = data[i, ]$Feedback)
  }
  
  return(cleaned_data)
}

get_data_by_task <- function(data) {
  
  # calculate certain benchmarks
  # e.g. navigation size distribution
  navigation_style_big <- nrow(data[data$Start.naviConfig. == "big", ])
  navigation_style_small <- nrow(data[data$Start.naviConfig. == "small", ])
  rows <- nrow(data)
  
  paste("small: ", navigation_style_small, sep = "")
  paste("big: ", navigation_style_big, sep = "")
  
  cleaned_data <- data.frame("id" = numeric(),
                             "navigation_size" = character(),
                             "screen_size" = character(),
                             "age" = numeric(),
                             "gender" = character(),
                             "task_solar_navigation_style" = character(),
                             "task_solar_mean_time" = numeric(),
                             "task_solar_ueq_pragmatic" = numeric(),
                             "task_solar_ueq_hedonic" = numeric(),
                             "task_battery_navigation_style" = character(),
                             "task_battery_mean_time" = numeric(),
                             "task_battery_ueq_pragmatic" = numeric(),
                             "task_battery_ueq_hedonic" = numeric(),
                             "data_quality" = character(),
                             "data_exclusion_reason" = character(),
                             "feedback" = character())
  
  # fill data frame with limesurvey data
  for(i in 1:nrow(data)) {
    task_1 <- list("navigation_style" = data[i, ]$solarIntroGranny.navigationSolar.,
                   "task_1_time" = data[i, ]$Xsolar1.taskTime.,
                   "task_1_moves" = data[i, ]$Xsolar1.moves.,
                   "task_1_completed" = data[i, ]$Xsolar1.completed.,
                   "task_1_errors" = data[i, ]$Xsolar1.errors.,
                   "task_2_time" = data[i, ]$Xsolar2.taskTime.,
                   "task_2_moves" = data[i, ]$Xsolar2.moves.,
                   "task_2_completed" = data[i, ]$Xsolar2.completed.,
                   "task_2_errors" = data[i, ]$Xsolar2.errors.,
                   "ueq_pragmatic" = mean(c(data[i, ]$solarUEQSusability.obstructive. - 4,
                                            data[i, ]$solarUEQSusability.complicated. - 4,
                                            data[i, ]$solarUEQSusability.inefficient. - 4,
                                            data[i, ]$solarUEQSusability.confusing. - 4)),
                   "ueq_hedonic" = mean(c(data[i, ]$solarUEQShedonism.boring. - 4,
                                          data[i, ]$solarUEQShedonism.notInteresting. - 4,
                                          data[i, ]$solarUEQShedonism.conventional. - 4,
                                          data[i, ]$solarUEQShedonism.usual. - 4)))
    
    task_2 <- list("navigation_style" = data[i, ]$batteryIntroGranny.navigationBattery.,
                   "task_1_time" = data[i, ]$Xbattery1.taskTime.,
                   "task_1_moves" = data[i, ]$Xbattery1.moves.,
                   "task_1_completed" = data[i, ]$Xbattery1.completed.,
                   "task_1_errors" = data[i, ]$Xbattery1.errors.,
                   "task_2_time" = data[i, ]$Xbattery2.taskTime.,
                   "task_2_moves" = data[i, ]$Xbattery2.moves.,
                   "task_2_completed" = data[i, ]$Xbattery2.completed.,
                   "task_2_errors" = data[i, ]$Xbattery2.errors.,
                   "ueq_pragmatic" = mean(c(data[i, ]$batteryUEQSusability.obstructive. - 4,
                                            data[i, ]$batteryUEQSusability.complicated. - 4,
                                            data[i, ]$batteryUEQSusability.inefficient. - 4,
                                            data[i, ]$batteryUEQSusability.confusing. - 4)),
                   "ueq_hedonic" = mean(c(data[i, ]$batteryUEQShedonism.boring. - 4,
                                          data[i, ]$batteryUEQShedonism.notInteresting. - 4,
                                          data[i, ]$batteryUEQShedonism.conventional. - 4,
                                          data[i, ]$batteryUEQShedonism.usual. - 4)))
    
    
    # to calculate the UEQ-S scores I just need to calculate the mean of all four items for all participants for a factor
    
    cleaned_data[nrow(cleaned_data) + 1,] <- list("id" = data[i, ]$id,
                                                  "navigation_size" = data[i, ]$Start.naviConfig.,
                                                  "screen_size" = data[i, ]$Start.screenSize.,
                                                  "age" = data[i, ]$Age,
                                                  "gender" = data[i, ]$Gender,
                                                  "task_solar_navigation_style" = data[i, ]$solarIntroGranny.navigationSolar.,
                                                  "task_solar_mean_time" = mean(c(task_1$task_1_time,
                                                                                  task_1$task_2_time)),
                                                  "task_solar_ueq_pragmatic" = task_1$ueq_pragmatic,
                                                  "task_solar_ueq_hedonic" = task_1$ueq_hedonic,
                                                  "task_battery_navigation_style" = data[i, ]$batteryIntroGranny.navigationBattery.,
                                                  "task_battery_mean_time" = mean(c(task_2$task_1_time,
                                                                                    task_2$task_2_time)),
                                                  "task_battery_ueq_pragmatic" = task_2$ueq_pragmatic,
                                                  "task_battery_ueq_hedonic" = task_2$ueq_hedonic,
                                                  "data_quality" = data[i, ]$DataQuality,
                                                  "data_exclusion_reason" = data[i, ]$DataQualityFollowUp,
                                                  "feedback" = data[i, ]$Feedback)
  }
  
  return(cleaned_data)
}

get_ueq_analysis <- function(data) {
  ueq_analysis <- data.frame("id" = numeric(),
                             "participant_id" = numeric(),
                             "navigation_size" = character(),
                             "navigation_style" = character(),
                             "ueq_pragmatic" = numeric(),
                             "ueq_hedonic" = numeric(),
                             "mean_time" = numeric())
  
  for(i in 1:nrow(data)) {
    ueq_analysis[nrow(ueq_analysis) + 1,] <- list("id" = i*10,
                                                  "participant_id" = data[i, ]$id,
                                                  "navigation_size" = data[i, ]$navigatio_size,
                                                  "navigation_style" = "bottom_bar",
                                                  "ueq_pragmatic" = data[i, ]$bottom_bar_ueq_pragmatic,
                                                  "ueq_hedonic" = data[i, ]$bottom_bar_ueq_hedonic,
                                                  "mean_time" = data[i, ]$bottom_bar_mean_time)
    
    ueq_analysis[nrow(ueq_analysis) + 1,] <- list("id" = i*10 + 1,
                                                  "participant_id" = data[i, ]$id,
                                                  "navigation_size" = data[i, ]$navigatio_size,
                                                  "navigation_style" = "hamburger",
                                                  "ueq_pragmatic" = data[i, ]$hamburger_ueq_pragmatic,
                                                  "ueq_hedonic" = data[i, ]$hamburger_ueq_hedonic,
                                                  "mean_time" = data[i, ]$hamburger_mean_time)
  }
  return(ueq_analysis)
}

get_ueq_analysis_with_tasks <- function(data) {
  ueq_analysis <- data.frame("id" = numeric(),
                             "participant_id" = numeric(),
                             "navigation_size" = character(),
                             "navigation_style" = character(),
                             "task" = character(),
                             "ueq_pragmatic" = numeric(),
                             "ueq_hedonic" = numeric(),
                             "mean_time" = numeric())
  
  for(i in 1:nrow(data)) {
    ueq_analysis[nrow(ueq_analysis) + 1,] <- list("id" = i*10,
                                                  "participant_id" = data[i, ]$id,
                                                  "navigation_size" = data[i, ]$navigation_size,
                                                  "navigation_style" = data[i, ]$task_solar_navigation_style,
                                                  "task" = "solar",
                                                  "ueq_pragmatic" = data[i, ]$task_solar_ueq_pragmatic,
                                                  "ueq_hedonic" = data[i, ]$task_solar_ueq_hedonic,
                                                  "mean_time" = data[i, ]$task_solar_mean_time)
    
    ueq_analysis[nrow(ueq_analysis) + 1,] <- list("id" = i*10 + 1,
                                                  "participant_id" = data[i, ]$id,
                                                  "navigation_size" = data[i, ]$navigation_size,
                                                  "navigation_style" = data[i, ]$task_battery_navigation_style,
                                                  "task" = "battery",
                                                  "ueq_pragmatic" = data[i, ]$task_battery_ueq_pragmatic,
                                                  "ueq_hedonic" = data[i, ]$task_battery_ueq_hedonic,
                                                  "mean_time" = data[i, ]$task_battery_mean_time)
  }
  return(ueq_analysis)
}