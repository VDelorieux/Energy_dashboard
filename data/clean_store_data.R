library(tidyverse)
library(varhandle)

# ------------- 001 global primary energy consumption -------------------

#Source : https://ourworldindata.org/energy
# In TWH !! 
# Do in absolute and in relative !! 
#Do not add title 
load_df <- read.csv2("data/001_global_primary_energy.csv", sep = ",") %>% rename("Other renewables" = Other.renewables,
                                                                            "Traditional biomass" = Traditional.biomass)
N <- length(load_df$Year)
df <- do.call(rbind,
              lapply(2:(ncol(load_df)),
                     function(i){
                       return(tibble(Year = load_df$Year, 
                                     source = rep(colnames(load_df)[i], N),
                                     consumption = as.vector(load_df[,i])))
                     })
)
df$source <- factor(df$source, levels = rev(c("Traditional biomass", "Coal", "Oil", "Gas", "Nuclear", "Hydropower", "Wind", "Solar", "Other renewables", "Biofuels")))
df <- df %>%
  group_by(Year)%>%
  mutate(cons_relative = 100 * consumption/sum(consumption))

# Per capita/ Source : ourworld in data 

df_pop <- read.csv2("data/World_population.csv", sep =",") %>% filter(year >= 1800) 
df_pop <- rename(df_pop, pop = colnames(df_pop)[2], Year = year)
df_pop$pop <- as.numeric(unfactor(df_pop$pop))
df_pop <-  add_row(df_pop, Year = 2016:2019, pop = c(7464022000, 7547859000, 7631091000, 7713468000))

  

df <- left_join(df, df_pop, by = "Year")
df <- mutate(df, cons_per_capita = 1e+6 * consumption/pop)


saveRDS(df, "data/001_global_primary_energy.RDS")

cbPalette <- rev(c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7", "#336600", "#6600FF"))










  
