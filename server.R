library(shiny)
library(tidyverse)
library(ggplot2)

shinyServer(function(input, output) {
    v <- reactiveValues()
    
    observe({
        v$year <- input$year
        
        if (input$gender == 1) {
            v$gender = "Female"
        }
        else{
            v$gender = "Male"
        }
        
        if (input$yaxis == 1) {
            v$yaxis = "identity"
        }
        else{
            v$yaxis = "log10"
        }
        
        alldata <- read.csv("UKdata.csv", header = TRUE) %>%
            filter(sex == v$gender,
                   year == v$year)
        
        deaths <- alldata %>% filter(type == "deaths",
                                     age >= input$ages[1],
                                     age <= input$ages[2])
        
        pops <- alldata %>% filter(type == "pop",
                                   age >= input$ages[1],
                                   age <= input$ages[2])
        
        v$D <- deaths$value
        v$E <- pops$value
        v$x <- deaths$age
        
        data <- data.frame(x = v$x,
                           D = v$D,
                           E = v$E)
        
        formulatext <- case_when(
            input$model == "poly2" ~ "D~1+x",
            input$model == "poly3" ~ "D~1+x+I(x^2)",
            input$model == "poly4" ~ "D~1+x+I(x^2)+I(x^3)",
            input$model == "poly5" ~ "D~1+x+I(x^2)+I(x^3)+I(x^4)",
            input$model == "poly6" ~ "D~1+x+I(x^2)+I(x^3)+I(x^4)+I(x^5)"
        )
        
        formula <- as.formula(formulatext)
        
        v$fit <-
            glm(formula,
                data,
                offset = log(E),
                family = "poisson")
        
        v$results <-
            data.frame(
                x = v$x,
                D = v$D,
                E = v$E,
                m = v$D / v$E,
                pred = predict(v$fit, type = "response") / v$E,
                residuals = residuals(v$fit)
            )
    })
    
    
    output$debug <- renderText({
        # c(input$model)
    })
    
    output$plot1 <- renderPlot({
        ggplot() +
            geom_point(data = v$results,
                       aes(x = x, y = m),
                       color = "blue") +
            geom_line(data = v$results,
                      aes(x = x, y = pred),
                      color = "red") +
            scale_y_continuous(name = "Mortality rate",
                               trans = v$yaxis,
                               limits = c()) + # identity or log10
            
            scale_x_continuous(name = "Age", )
    })
    output$plot2 <- renderPlot({
        ggplot() +
            geom_point(data = v$results,
                       aes(x = x, y = residuals),
                       color = "blue") +
            scale_y_continuous(name = "Residuals") +
            scale_x_continuous(name = "Age", )
    })
    
})
