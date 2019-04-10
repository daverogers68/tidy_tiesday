library(tidyverse)

#the data
grand_slams <- read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-04-09/grand_slams.csv")

#looking into the data
head(grand_slams)
summary(grand_slams)
unique(grand_slams$name)
max(grand_slams$rolling_win_count)

#Figuring stuff out
aus_open <- grand_slams %>% 
  filter(grand_slam == "australian_open") %>%
  group_by(name) %>%
  summarize(wins = n())

#reduced data set
g_slam_multi <- grand_slams %>%
  group_by(grand_slam, gender, name) %>%
  filter(n() > 1) %>%
  summarize(wins = n())

#my first tirdy tuesday
g_slam_multi %>% 
  ggplot() +
  geom_bar(aes(x = grand_slam, fill = gender), position = "dodge", alpha = 0.5) +
  scale_fill_manual(values = c("red", "blue")) +
  labs(title = "Grand Slam Multiple Winners",
       subtitle = "Open Era",
       y = "# of Players with Multiple Wins",
       x = "Grand Slam") +
  theme_classic(12) +
  scale_x_discrete(labels = c("Australian Open", "French Open", "US Open", "Wimbledon")) +
  ggsave("week15.png")
