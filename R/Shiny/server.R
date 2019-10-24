library(shiny)
library(dplyr)
library(ggplot2)
library(gridExtra)
library(cowplot)
library(elasticsearchr)

draw_donut <- function(variable) {
  tab_table <- data.frame(prop.table(table(res[,variable])))
  colnames(tab_table) <- c("category", "fraction")
  tab_table$ymax <-  cumsum(tab_table$fraction)
  tab_table$ymin = c(0, head(tab_table$ymax, n=-1))
  donut <- ggplot(tab_table, aes(ymax=ymax, ymin=ymin, xmax=4, xmin=3, fill=category)) +
                  geom_rect() +
                  coord_polar(theta="y") +
                  xlim(c(2, 4)) +
                  theme_void()
  
  return(donut)
}

draw_pie <- function(variable) {
  tab_table <- data.frame(prop.table(table(res[,variable])))
  colnames(tab_table) <- c("category", "fraction")
  tab_table$ymax <-  cumsum(tab_table$fraction)
  tab_table$ymin = c(0, head(tab_table$ymax, n=-1))
  donut <- ggplot(tab_table, aes(ymax=ymax, ymin=ymin, xmax=4, xmin=3, fill=category)) +
    geom_rect() +
    coord_polar(theta="y") +
    theme_void()
  
  return(donut)
}

for_everything <- query('{
  "match_all": {}
}')

shinyServer(function(input, output) {
  rafraichirBase <- isolate({
      elastic("http://localhost:9200", "enquete", "test") %search% for_everything %>% unique(.)
  })
  output$out <- renderDataTable({
    input$actiondata
    rafraichirBase
  })


  
  
  rafraichirGraph <- isolate({
    result <- elastic("http://localhost:9200", "enquete", "test") %search% for_everything
    res <- unique(result)
    par(mfrow = c(1, 2))
    a <- ggplot(res, aes(x = qualite_site_internet, fill = qualite_site_internet)) +
                geom_bar() +
                facet_wrap(~qualite_site_internet) +
                theme_light()
    
    b <- ggplot(res, aes(x = qualite_site_internet, fill = qualite_site_internet)) +
                geom_bar() +
                theme_light()
    
    donut1 <- draw_donut("amabilite_ecoute")
    donut2 <- draw_donut("relation_com")
    pie1 <- draw_donut("amabilite_ecoute")
    pie2 <- draw_donut("relation_com")
    plot_grid(a, b, pie1, donut1, donut2, pie2, ncol = 3, nrow = 2)
  })
  output$dash <- renderPlot({
    input$actiongraph
    rafraichirGraph
  })
})


