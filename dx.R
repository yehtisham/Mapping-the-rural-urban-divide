library(tidycensus)
library(tidyverse)
library(plotly)
library(tigris)
options(tigris_use_cache = TRUE)

#population

#Total Population 2022
totalpop2022 = get_acs(geography = "county",variables = "B01003_001",year = 2022, geometry = TRUE)
totalpop2022 = totalpop2022 |> rename(totalpop22 = "estimate")

#Total Population 2020
totalpop2020 = get_acs(geography = "county",variables = "B01003_001",year = 2020)
totalpop2020 = totalpop2020 |> rename(totalpop20 = "estimate")

#Total Population 2017
totalpop2017 = get_acs(geography = "county",variables = "B01003_001",year = 2017)
totalpop2017 = totalpop2017 |> rename(totalpop17 = "estimate")

#merge
popchange = full_join(totalpop2017,totalpop2022,by = "GEOID")
popchange = popchange |> mutate(popchangerate2017_2022 = ((totalpop22-totalpop17)/totalpop17)*100)
popchange = popchange |> select(GEOID,NAME.x,totalpop17,totalpop22,popchangerate2017_2022,geometry)
popchange = popchange |> rename(NAME = "NAME.x")

#---------------------------------

#employment

#total employment rate 2017
totalemp2017 = get_acs(geography = "county",variables = "B23025_001" ,year = 2017)
totalemp2017 = totalemp2017 |> rename(totalemp17 = "estimate")
view(totalemp2017)

#total employment rate 2020
totalemp2020 = get_acs(geography = "county",variables = "B23025_001" ,year = 2020)
totalemp2020 = totalemp2020 |> rename(totalemp20 = "estimate")
view(totalemp2020)

#Total Employment Rate 2022
totalemp2022 = get_acs(geography = "county",variables = "B23025_001",year = 2022)
totalemp2022 = totalemp2022 |> rename(totalemp22 = "estimate")
view(totalemp2022)

#merge emp
empchange = full_join(totalemp2017,totalemp2022,by = "GEOID")
empchange= empchange |> mutate(empchangerate2017_2022 = ((totalemp22-totalemp17)/totalemp17)*100)
empchange = empchange |> select(GEOID,NAME.x,totalemp17,totalemp22,empchangerate2017_2022)
empchange = empchange |> rename(NAME = "NAME.x")
view(empchange)

#-------------------------

#house price


#Total house price 2022
totalhp2022 = get_acs(geography = "county",variables = "B25077_001",year = 2022)
totalhp2022 = totalhp2022 |> rename(totalhp22 = "estimate")

#Total house price 2020
totalhp2020 = get_acs(geography = "county",variables = "B25077_001",year = 2020)
totalhp2020 = totalhp2020 |> rename(totalhp20 = "estimate")

#Total house price 2017
totalhp2017 = get_acs(geography = "county",variables = "B25077_001",year = 2017)
totalhp2017 = totalhp2017 |> rename(totalhp17 = "estimate")

#merge house price
houseprice = full_join(totalhp2017,totalhp2022,by = "GEOID")
houseprice= houseprice |> mutate(housepricerate2017_2022 = ((totalhp22-totalhp17)/totalhp17)*100)
houseprice = houseprice |> select(GEOID,NAME.x,totalhp17,totalhp22,housepricerate2017_2022)
houseprice = houseprice |> rename(NAME = "NAME.x")
view(houseprice)

#----------

#Whole join

dt = read.csv("classification.csv")
dt = dt |> select(GEOID,Metropolitan.Micropolitan.Statistical.Area)
data = full_join(popchange,empchange,by="GEOID")
data = full_join(data,houseprice,by= "GEOID")

data$GEOID = as.numeric(data$GEOID)
data = full_join(data,dt,by = "GEOID")
data = data |> select(!(NAME.y))
data = data |> select(!(NAME))
data = data |> rename(NAME = "NAME.x")
data$Metropolitan.Micropolitan.Statistical.Area = data$Metropolitan.Micropolitan.Statistical.Area |> replace_na("Rural")

#More preparation

#filter to contain only valid states counties
finaldata1 = data |> filter(GEOID <72001 | GEOID > 72153)
finaldata1 = finaldata1 |> filter(GEOID <15001 | GEOID > 15009)
finaldata1 = finaldata1 |> filter(GEOID <2013 | GEOID > 2290)

#----------------------------------

#boxplot

# pop 17 20
ggplot(data = finaldata1,aes(x= totalpop17,y=Metropolitan.Micropolitan.Statistical.Area))+
  geom_boxplot(coef = 1.5)+xlim(0,.05e+06)

ggplot(data = finaldata1,aes(x= totalpop22,y=Metropolitan.Micropolitan.Statistical.Area))+
  geom_boxplot(coef = 1.5)+xlim(0,.05e+06)

#----------------------------------

#scatter plot

# popchange and empchange
ggplot(data = finaldata1,aes(x=empchangerate2017_2022,y= popchangerate2017_2022,color=Metropolitan.Micropolitan.Statistical.Area))+
  geom_point()

#-----------------------------------
#Maps

df = na.omit(finaldata1)
#rural urban map

ggplot(data = df, aes(fill = Metropolitan.Micropolitan.Statistical.Area)) +
  geom_sf(aes(geometry = geometry), color = "white") +theme(legend.position = "bottom")

#pop change map
ggplot(data = df, aes(fill = popchangerate2017_2022)) +
  geom_sf(aes(geometry = geometry), color = "white") +theme(legend.position = "bottom")

#------------------------

#linear models

summary(lm(finaldata1$popchangerate2017_2022~finaldata1$Metropolitan.Micropolitan.Statistical.Area))

