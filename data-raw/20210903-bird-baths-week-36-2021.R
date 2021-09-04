

# Carregar pacotes e pipe -------------------------------------------------
'%>%' <- magrittr::`%>%`
#library(tidytuesdayR)


# Obter dados -------------------------------------------------------------
# The data this week comes from Cleary et al, 2016 with the corresponding 
# article Avian Assemblages at Bird Baths: A Comparison of Urban and 
# Rural Bird Baths in Australia.

tuesdata <- tidytuesdayR::tt_load(2021, week = 36)
bird_baths <- tuesdata$bird_baths
bird_baths


# Salvar dados ------------------------------------------------------------
bird_baths %>% saveRDS("./data/2021-08-31-bird-baths.RDS")


# Abrir dados salvos ------------------------------------------------------
db_bird_baths <- readr::read_rds("data/2021-08-31-bird-baths.RDS")

# estrutura
db_bird_baths %>% dplyr::glimpse()


# Explorar os dados -------------------------------------------------------

# Quantidade de passáros urbanas x rurais
db_bird_baths %>% 
    dplyr::group_by(urban_rural) %>% 
    dplyr::summarise(qtd = sum(bird_count))

db_bird_baths %>% 
    dplyr::group_by(urban_rural) %>% 
    dplyr::summarise(n = dplyr::n())



db_bird_baths %>%
    dplyr::group_by(urban_rural) %>%
    viewxl::view_in_xl()
        


# Espécies mais comuns no meio urbano


# Espécies mais comuns no meio rural

