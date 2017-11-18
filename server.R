library(RSQLite)
library(dplyr)

function(input, output, session) {
  
  abc <- reactive({
    
    setwd("C:/Users/ChingPau/Desktop/mental_health_in_tech/")
    db <- dbConnect(SQLite(), dbname="mental_health.sqlite")
    mental_health <- dbReadTable(db,"mental_health")
    dbDisconnect(db)
    
    minAge <- input$age[1]
    maxAge <- input$age[2]
    gender <- input$gender
    Self_employed <- input$Self_employed
    Family_history <- input$Family_history
    Work_interfere <- input$Work_interfere
    No_employees <- input$No_employees
    Remote_work <- input$Remote_work
    Tech_company <- input$Tech_company
    Benefits <- input$Benefits #care_options, wellness_program, seek help,anonymity
    Leave <- input$Leave
    Mental_phys_health_consequence <- input$Mental_phys_health_consequence #phys_health_consequence, mental_health_consequence
    Coworker <- input$Coworker #supervisor
    Mental_phys_interview <- input$Mental_phys_interview #mental_health_interview, phys_health_interview
    Mental_vs_physical <- input$Mental_vs_physical
  
    df <- mental_health %>% filter(
      Age >= minAge,
      Age <= maxAge
    )
    #optional
    if(gender != "All"){
      df <- df %>% filter(Gender == tolower(gender))
    }
    if(Self_employed != "All"){
      df <- df %>% filter(self_employed == Self_employed)
    }
    if(Family_history != "All"){
      df <- df %>% filter(family_history == Family_history)
    }
    if(Work_interfere != "All"){
      df <- df %>% filter(work_interfere == Work_interfere)
    }
    if(No_employees != "All"){
      df <- df %>% filter(no_employees == No_employees)
    }
    if(Remote_work != "All"){
      df <- df %>% filter(remote_work == Remote_work)
    }
    if(Tech_company != "All"){
      df <- df %>% filter(tech_company == Tech_company)
    }
    if(Leave != "All"){
      df <- df %>% filter(leave == Leave)
    }
    if(Coworker != "All"){
      df <- df %>% filter(coworkers == Coworker,
                          supervisor == Coworker)
    }
    if(Benefits != "All"){
      if(Benefits != "Don't know")
      {
        df <- df %>% filter(
          benefits == Benefits,
          care_options == Benefits,
          wellness_program == Benefits,
          seek_help == Benefits,
          anonymity == Benefits
        )
      }else{
        df <- df %>% filter(
          benefits == Benefits,
          care_options == "Not sure",
          wellness_program == Benefits,
          seek_help == Benefits,
          anonymity == Benefits
        )
      }
    }
    if(Mental_phys_health_consequence != "All")
    {
      df <- df %>% filter(
        mental_health_consequence == Mental_phys_health_consequence,
        phys_health_consequence == Mental_phys_health_consequence
      )
    }
    if(Mental_phys_interview != "All")
    {
      df <- df %>% filter(
        mental_health_interview == Mental_phys_interview,
        phys_health_interview == Mental_phys_interview
      )
    }
    if(Mental_vs_physical != "All")
    {
      df <- df %>% filter(mental_vs_physical == Mental_vs_physical)
    }
    
    df <- as.data.frame(df)
  })
  
  output$proba <- renderPlotly({
  
    ## Pie Chart with Percentages
    # mental_filtered <- as.data.frame(abc())
    # count <- mental_filtered %>% group_by(treatment) %>% summarise(n = n())
    # count <- as.data.frame(count)
    # slices <- count[,2]
    # lbls <- unique(mental_health$treatment)
    # pct <- round(slices/sum(slices)*100.00, 2)
    # lbls <- paste(lbls, pct) # add percents to labels 
    # lbls <- paste(lbls,"%",sep="") # ad % to labels 
    # pie(slices,labels = lbls, col=rainbow(length(lbls)),
    # main="Pie Chart of soughting treatment for a mental health condition")
    mental_filtered <- as.data.frame(abc())
    count <- mental_filtered %>% group_by(treatment) %>% summarise(n = n())
    
    plot_ly(count, labels = ~treatment, values = ~n, type = 'pie', textposition = 'inside',
            textinfo = 'label+percent', insidetextfont = list(color = '#FFFFFF'),
            hoverinfo = 'text', text = ~paste('Count = ', n, ' votes') )%>% 
      layout(title = 'Probability of soughting for treatment given a mental health condition',
             xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
             yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
  })
  
    # output$text <- renderPrint({
    #   mental_filtered <- as.data.frame(abc())
    #   count <- mental_filtered %>% group_by(treatment) %>% summarise(n = n())
    #   count})
  
    output$text <- renderText({
      paste("<h3><b>Dataset Information<br><h3>", "</b>", "<h5>This dataset is from a 2014 survey that measures attitudes towards mental health and frequency of mental health disorders in the tech workplace. <h5>", "<br>",  "<br>", 
            "<h4><b>Content<br><h4>", "</b>",
            "<h5><ul>", 
            "<li>Age</li>",
            "<li>Gender</li>",
            "<li>self_employed: Are you self-employed?</li>",
            "<li>family_history: Do you have a family history of mental illness?</li>",
            "<li>treatment: Have you sought treatment for a mental health condition?</li>",
            "<li>work_interfere: If you have a mental health condition, do you feel that it interferes with your work?</li>",
            "<li>no_employees: How many employees does your company or organization have?</li>",
            "<li>remote_work: Do you work remotely (outside of an office) at least 50% of the time?</li>",
            "<li>tech_company: Is your employer primarily a tech company/organization?</li>",
            "<li>benefits: Does your employer provide mental health benefits?</li>",
            "<li>care_options: Do you know the options for mental health care your employer provides?</li>",
            "<li>wellness_program: Has your employer ever discussed mental health as part of an employee wellness program?</li>",
            "<li>seek_help: Does your employer provide resources to learn more about mental health issues and how to seek help?</li>",
            "<li>anonymity: Is your anonymity protected if you choose to take advantage of mental health or substance abuse treatment resources?</li>",
            "<li>leave: How easy is it for you to take medical leave for a mental health condition?</li>",
            "<li>mental_health_consequence: Do you think that discussing a mental health issue with your employer would have negative consequences?</li>",
            "<li>phys_health_consequence: Do you think that discussing a physical health issue with your employer would have negative consequences?</li>",
            "<li>coworkers: Would you be willing to discuss a mental health issue with your coworkers?</li>",
            "<li>supervisor: Would you be willing to discuss a mental health issue with your direct supervisor(s)?</li>",
            "<li>mental_health_interview: Would you bring up a mental health issue with a potential employer in an interview?</li>",
            "<li>phys_health_interview: Would you bring up a physical health issue with a potential employer in an interview?</li>",
            "<li>mental_vs_physical: Do you feel that your employer takes mental health as seriously as physical health?</li>",
            "<li>obs_consequence: Have you heard of or observed negative consequences for coworkers with mental health conditions in your workplace?</li>",
            "</ul></h5>")
    })
  
    output$values <- renderTable({
      temp <- as.data.frame(abc())
      head(temp,16)
    })
}
