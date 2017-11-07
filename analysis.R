#links to data: https://earthquaketrack.com/r/utah/recent (recent quakes chart) and http://quake.utah.edu/publications/reports/a-uniform-moment-magnitude-earthquake-catalog-and-background-seismicity-rates-for-the-wasatch-front-and-surrounding-utah-region-appendix-e-in-working-group-on-utah-earthquake-probabilities-wguep (historical quakes map)

# recent quakes chart code and dataset

library(tidyverse)
library(scales)

df <- read.csv('data/latest_quakes.csv')
df$date <- as.Date(with(df, paste(year, month, day, sep="-")), "%Y-%m-%d")
b <- ggplot(df, (aes)(date))
b + geom_bar() + 
  ggtitle("Recent Utah Quakes")


# historical quakes map code and dataset

install.packages("devtools")
devtools::install_github("dgrtwo/gganimate")
install.packages("magick")
library(magick)
library(tidyverse)
library(gganimate)
library(ggmap)

df <- read_csv("data/quakes.csv")
utah_map <- get_map(location = "Utah", 
                    zoom = 6, 
                    maptype = "toner-lite")
p <- ggmap(utah_map) +
  geom_point(data = df, 
             aes(x = Long, y = Lat, frame = Year, size = BEM, cumulative = TRUE), 
             alpha = .3) +
  geom_point(data = df, 
             aes(x = Long, y = Lat, frame = Year, size = BEM), 
             col = "red") +
  theme_void() +
  theme(legend.position = "bottom") +
  labs(size = "Magnitude")
gganimate(p, filename = "/Downloads/quakes.gif")


