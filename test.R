library(dplyr)
library(ggplot2)
devtools::load_all()
steam_id = "76561198024069852"
rating_history(steam_id = steam_id) %>% purrr::map_int('rating') %>% rev %>% data.frame(rating = ., game = 1:length(.)) %>% 
    ggplot(aes(x = game, y = rating)) +
    geom_line(linetype = 'dashed') + 
    geom_point() + 
    cowplot::theme_cowplot()


last_match(steam_id = steam_id) -> hede

history = match_history(steam_id = steam_id)
