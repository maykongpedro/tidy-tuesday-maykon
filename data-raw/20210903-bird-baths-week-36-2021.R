

# Carregar pacotes e pipe -------------------------------------------------
'%>%' <- magrittr::`%>%`
#library(tidytuesdayR)


# Obter dados -------------------------------------------------------------
# The data this week comes from Cleary et al, 2016 with the corresponding 
# article Avian Assemblages at Bird Baths: A Comparison of Urban and 
# Rural Bird Baths in Australia.

# tuesdata <- tidytuesdayR::tt_load(2021, week = 36)
# bird_baths <- tuesdata$bird_baths
# bird_baths


# Salvar dados ------------------------------------------------------------
# bird_baths %>% saveRDS("./data/2021-08-31-bird-baths.RDS")


# Abrir dados salvos ------------------------------------------------------
db_bird_baths <- readr::read_rds("data/2021-08-31-bird-baths.RDS")

# estrutura
db_bird_baths %>% dplyr::glimpse()


# Explorar os dados -------------------------------------------------------

# quantidade de passáros urbanas x rurais
db_bird_baths %>% 
    dplyr::group_by(urban_rural) %>% 
    dplyr::summarise(qtd = sum(bird_count))


# quantidade de espécies urbanas x rurais
db_bird_baths %>% 
    dplyr::group_by(urban_rural) %>% 
    dplyr::summarise(n = dplyr::n())


# visualizar no excel
# db_bird_baths %>%
#     dplyr::group_by(urban_rural) %>%
#     viewxl::view_in_xl()
        

# pensar em como juntar esses três itens em apenas uma base ou
# montar uma função

# Espécies mais comuns no meio urbano e rural
especies_por_local <- db_bird_baths %>% 
    #dplyr::filter(urban_rural == "Rural") %>% 
    dplyr::filter(!is.na(urban_rural)) %>% 
    dplyr::group_by(urban_rural, bird_type) %>% 
    dplyr::summarise(qtd_birds = sum(bird_count)) %>% 
    dplyr::arrange(dplyr::desc(qtd_birds))


# Espécies mais comuns no meio rural
# db_bird_baths %>% 
#     dplyr::filter(urban_rural == "Urban") %>% 
#     dplyr::group_by(bird_type) %>% 
#     dplyr::summarise(qtd_birds = sum(bird_count)) %>% 
#     dplyr::arrange(dplyr::desc(qtd_birds))


# Espécies mais comum na base
db_bird_baths %>% 
    #dplyr::filter(urban_rural) %>% 
    dplyr::group_by(bird_type) %>% 
    dplyr::summarise(qtd_birds = sum(bird_count)) %>% 
    dplyr::arrange(dplyr::desc(qtd_birds))


# Dataviz -----------------------------------------------------------------

# pensei em algo como o gráfico dos pinguins, com imagens dos passáros
# coladas no gráfico. Acho que gráficos simples de barras já servem

especies_por_local %>% 
    dplyr::filter(urban_rural == "Urban") %>% 
    dplyr::slice(1:15) %>% 
    dplyr::mutate(
        bird_type = forcats::fct_reorder(bird_type, qtd_birds)
    ) %>% 
    ggplot2::ggplot()+
    ggplot2::geom_col(
        ggplot2::aes(
            x = qtd_birds,
            y = bird_type
        )
    )+
    ggplot2::theme_minimal()
                      
