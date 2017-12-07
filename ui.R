library(shiny)
library(plotly)

fluidPage(
  
  # App title ----
  titlePanel("Mental Illness Explorer"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      # Input: Slider for the age ----
      sliderInput(inputId = "age",
                  label = "Age:",
                  min = 15,
                  max = 65,
                  value = c(20, 30)),
      # Input: dropdown for gender ----
      selectInput(inputId = "gender", 
                  label = "Gender",
                  choices = c("All", 
                              "Male",
                              "Female", 
                              "Trans"),
                  selected = "All"),
      # Input: dropdown for self-employed----
      selectInput(inputId = "Self_employed", 
                  label = "Self-employed?",
                  choices = c("All", 
                              "Yes",
                              "No"),
                  selected = "All"),
      ## Input: dropdown for family history ----
      selectInput(inputId = "Family_history", 
                  label = "Family History of Mental Illness?",
                  choices = c("All", 
                              "Yes",
                              "No"),
                  selected = "All"),
      # Input: dropdown for work interfere ----
      selectInput(inputId = "Work_interfere", 
                  label = "Mental illness will affect the work?",
                  choices = c("All", 
                              "Never",
                              "Rarely",
                              "Sometimes",
                              "Often"),
                  selected = "All"),
      #drop down for no_employee
      selectInput(inputId = "No_employees", 
                  label = "Number of Employees in company?",
                  choices = c("All", 
                              "1-5",
                              "6-25",
                              "26-100",
                              "100-500",
                              "500-1000",
                              "More than 1000"),
                  selected = "All"),
      # Input: dropdown for remote work ----
      selectInput(inputId = "Remote_work", 
                  label = "Do you work remotely for more than 50% of working time?",
                  choices = c("All", 
                              "Yes",
                              "No"),
                  selected = "All"),
      # Input: dropdown for tech_company ----
      selectInput(inputId = "Tech_company", 
                  label = "Tech company?",
                  choices = c("All", 
                              "Yes",
                              "No"),
                  selected = "All"),
      # Input: dropdown for benefits ----
      selectInput(inputId = "Benefits", 
                  label = "Does your employer provide mental Health Care and Benefits?",
                  choices = c("All", 
                              "Yes",
                              "No",
                              "Don't know"),
                  selected = "All"),
      # Input: dropdown for leave ----
      selectInput(inputId = "Leave", 
                  label = "Would it be difficult to take leave for mental health condition?",
                  choices = c("All", 
                              "Very difficult",
                              "Somewhat difficult",
                              "Somewhat easy",
                              "Very easy",
                              "Don't know"),
                  selected = "All"),
      # Input: dropdown for mental phys health consequence ----
      selectInput(inputId = "Mental_phys_health_consequence", 
                  label = "Would it have negative consequences if discuss mental/physical health issue with employer?",
                  choices = c("All", 
                              "Yes",
                              "No",
                              "Maybe"),
                  selected = "All"),
      # Input: dropdown for coworker ----
      selectInput(inputId = "Coworker", 
                  label = "Would you discuss a mental health issue with coworkers/supervisor?",
                  choices = c("All", 
                              "Yes",
                              "No",
                              "Some of them"),
                  selected = "All"),
      # Input: dropdown for mental_phys_interview ----
      selectInput(inputId = "Mental_phys_interview", 
                  label = "Would you bring up mental or physical health issue during interview?",
                  choices = c("All", 
                              "Yes",
                              "No",
                              "Maybe"),
                  selected = "All"),
      # Input: dropdown for mental vs physical ----
      selectInput(inputId = "Mental_vs_physical", 
                  label = "Will your employer takes mental health as serious as physical health?",
                  choices = c("All", 
                              "Yes",
                              "No",
                              "Don't know"),
                  selected = "All")
    ),
    
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      tabsetPanel(
        tabPanel("Plot", plotlyOutput(outputId = "proba"), "Table", tableOutput('values')),
        tabPanel("Summary", htmlOutput('text')), #show the summary of the assignment
        tabPanel("ui.r", htmlOutput('ui')), #show the code for ui.R
        tabPanel("server.r", htmlOutput('server')) #show the code for server.R
      )
      # Output: piechart ----
      # plotlyOutput(outputId = "proba"),
      # verbatimTextOutput('text'),
      # tableOutput('values')
    )
  )
)