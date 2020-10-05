library(tidyverse)

cbPalette <- rev(c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7", "#336600", "#6600FF"))




plot_001 <- function(df_primary, y, date_min, date_max){
  df_primary <- filter(df_primary, date_min <= Year & Year <= date_max)
  if (y == "consumption"){
    return(ggplot(data = df_primary)+
      geom_area(mapping = aes(x = Year, y = consumption, fill = source), alpha = 0.75)+
      labs(y="TWh", x = "", fill ="")+
      theme_bw()+
      scale_y_continuous(breaks = c(0, 25000, 50000, 75000, 100000, 125000, 150000),
                         labels = c("0", "25,000", "50,000", "75,000", "100,000", "125,000", "150,000"))+
      scale_fill_manual(values=cbPalette))
  }
  if (y == "cons_relative"){
    return(ggplot(data = df_primary)+
      geom_area(mapping = aes(x = Year, y = relative_cons, fill = source), alpha = 0.65)+
      labs(y="", x = "", fill ="")+
      theme_bw()+
      scale_y_continuous(breaks = c(0, 20, 40, 60, 80, 100),
                         labels = c("0%", "20%", "40%", "60%", "80%", "100%"))+
      scale_fill_manual(values=cbPalette))
  }
  if (y == "cons_per_capita"){
    return(ggplot(data = df_primary)+
      geom_area(mapping = aes(x = Year, y = cons_per_capita, fill = source), alpha = 0.75)+
      labs(y="MWh", x = "", fill ="")+
      theme_bw()+
      #scale_y_continuous(breaks = c(0, 25000, 50000, 75000, 100000, 125000, 150000),
      #                   labels = c("0", "25,000", "50,000", "75,000", "100,000", "125,000", "150,000"))+
      scale_fill_manual(values=cbPalette))
  }
}


plot_002 <- function(df_primary, y){
  df_primary_19 <- filter(df_primary, Year == 2019)
  df_primary_19$source <- factor(unfactor(df_primary_19$source), levels =  rev(c("Oil", "Coal", "Gas", "Traditional biomass", "Hydropower", "Nuclear", "Biofuels", "Wind", "Other renewables", "Solar")))
  if (y == "consumption"){
    return(ggplot(data = df_primary_19)+
             geom_col(mapping = aes(x = source, y = consumption, fill = source), alpha = 0.75)+
             coord_flip()+
             labs(y="TWh", x = "", fill ="")+
             theme_bw()+
             scale_y_continuous(breaks = c(0, 10000, 20000, 30000, 40000, 50000),
                                labels = c("0", "10,000", "20,000", "30,000", "40,000", "50,000"))+
             scale_fill_manual(values=cbPalette))
  }
  if (y == "cons_relative"){
    return(ggplot(data = df_primary_19)+
             geom_col(mapping = aes(x = source, y = relative_cons, fill = source), alpha = 0.75)+
             coord_flip()+
             labs(y="", x = "", fill ="")+
             theme_bw()+
             scale_y_continuous(breaks = c(0, 20, 40, 60, 80, 100),
                                labels = c("0%", "20%", "40%", "60%", "80%", "100%"))+
             scale_fill_manual(values=cbPalette))
  }
  if (y == "cons_per_capita"){
    return(ggplot(data = df_primary_19)+
             geom_col(mapping = aes(x = source, y = cons_per_capita, fill = source), alpha = 0.75)+
             coord_flip()+
             labs(y="MWh", x = "", fill ="")+
             theme_bw()+
             scale_y_continuous(breaks = c(0, 1, 2, 3, 4, 5, 6, 7),
                                labels = c("1", "2", "3", "4", "5", "6", "7"))+
             scale_fill_manual(values=cbPalette))
  }
}


