shinyUI(navbarPage(
    "Mortality rates",
    
    tabPanel(
        "About",
        
        HTML(
            "<p>Mortality rates are important for managing pension plans, insurance
        companies, and social security payments. Mortality rates - the probability of a person dying in the next year
        - vary enormously by age. In developed countries they are typically
        less than 1-in-10,000 for a 5-year-old, but more than 1-in-10 for a 90-year-old.
        To a first approximation, they increase exponentially, as notes by Benjamin Gompertz in 1825.<p>

        <h4>This app</h4>

        <p>In this app we look at mortality rates in England & Wales, and how
        they vary by age for males and females, in different years.
        We fit various models, including a simple exponential fit and more complex variations.</p>

        <h4>Data</h4>

        <p>The data is taken from the
             <a href=https://www.ons.gov.uk/peoplepopulationandcommunity/birthsdeathsandmarriages/deaths/adhocs/10727populationestimatesanddeathsbysingleyearofageforenglandandwalesandtheuk1961to2018>Office for National Statistics</a>
             website.</p>

        <h4>Models</h4>

        <p>We model the logarithm of mortality as a polynomial, with a
        specified number of parameters. A higher number of parameters gives a better fit to the data.</p>

        <h4>Options</h4>
        <p>The app lets you specify
        <ul>
        <li>the age range, year, and gender of the data to model</li>
        <li>how many parameters to use</li>
        <li>whether to show mortality rates on a linear or logarithmic scale</li>
        </ul>

        <h4>Charts</h4>
        <p>The first chart shows mortality rates - the actual rates as circles, and the fitted rates as a line.</p>
        <p>The second chart plots residuals, to show the quality of the model fit. For a good model, these should almost all be between -3 and +3, with no obvious pattern to them.</p>"
        )
    )
    
    ,
    tabPanel("Analysis",
             sidebarLayout(
                 sidebarPanel(
                     sliderInput(
                         "ages",
                         "Age range:",
                         min = 0,
                         max = 100,
                         value = c(60, 95)
                     ),
                     sliderInput(
                         "year",
                         "Year:",
                         min = 1961,
                         max = 2018,
                         sep = "",
                         value = 2018
                     ),
                     radioButtons(
                         "gender",
                         "Gender:",
                         choices = list("Female" = 1,
                                        "Male" = 2),
                         selected = 1
                     ),
                     radioButtons(
                         "model",
                         "Number of parameters:",
                         choices = list(
                             "2" = "poly2",
                             "3" = "poly3",
                             "4" = "poly4",
                             "5" = "poly5",
                             "6" = "poly6"
                         )
                     ),
                     radioButtons(
                         "yaxis",
                         "Axis type:",
                         choices = list("Linear" = 1,
                                        "Logarithmic" = 2),
                         selected = 1
                     )
                     
                 ),
                 mainPanel(
                     textOutput("debug"),
                     plotOutput("plot1"),
                     plotOutput("plot2")
                 )
             ))
))