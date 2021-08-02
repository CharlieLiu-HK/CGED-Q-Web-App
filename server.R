server <- function(input, output){
  page_router$server(input, output)
  
  dataTable1 <- eventReactive(input$Trigger1, {
    new_data[sample(nrow(new_data), 1000), ]
  })
  
  output$RawData <- DT::renderDataTable(
    datatable(
      {
        dataTable1()
      },
      options = list(lengthMenu = list(c(15,25,35), c('15','25','35')),
                     pageLength = 25,
                     initComplete = JS(
                       "function(settings, json) {",
                       "$(this.api().table().header()).css({'background-color': 'moccasin', 'color': '1c1b1b'});",
                       "}"),
                     columnDefs=list(list(className='dt-center',targets="_all"))
      ),
      filter = "top",
      selection = 'multiple',
      style = 'bootstrap',
      class = 'cell-border stripe',
      rownames = FALSE
    )
  )
  
  sampleOne <- reactive({
    sample(nrow(new_data), 1)
  })
  
  output$Example1 <- renderTable({
    new_data[sampleOne(), 1:13]
  })
  
  TypeWriter1 <- reactive({
    if(input$Picks0 == "陽歷年份") {return("可能的取值：1900-1912。顯示這條記錄出自哪一年的縉紳錄刻本。")}
    if(input$Picks0 == "季節號") {return("可能的取值:1，2，3,4。顯示這條記錄出自哪一季節的縉紳錄刻本。")}
    if(input$Picks0 == "姓氏") {return("官員的姓氏，大部分滿族官員由於避諱沒有姓氏的記記錄。")}
    if(input$Picks0 == "名字") {return("官員的名字。")}
    if(input$Picks0 == "身份二") {return("可能的取值：滿族，蒙古，漢軍，漢族，其他，無記錄. 顯示該名官員的民族。")}
    if(input$Picks0 == "旗分一") {return("可能的取值：鑲黃，正黃，正白，正紅，鑲白，鑲紅，正白，鑲藍，其他，無旗分。顯示該名官員的旗分。")}
    if(input$Picks0 == "旗分二") {return("可能的取值：旗人，非旗人。顯示該名官員是否為旗人。")}
    if(input$Picks0 == "出身一") {return("可能的取值：進士，舉人，貢生，監生，畢業生，生員，蔭生，吏員，其他，無記錄。顯示該名官員的出身。")}
    if(input$Picks0 == "地區") {return("可能的取值：地方，中央。顯示該名官員的供職地。")}
    if(input$Picks0 == "機構一") {return("顯示該名官員供職的機構。")}
    if(input$Picks0 == "機構二") {return("顯示該名官員供職的機構。補充“機構一”。")}
    if(input$Picks0 == "官職") {return("顯示該名關於的官職。")}
    if(input$Picks0 == "銓選方式") {return("可能的取值：選，補，調，升，授，其他，無記錄。記錄該名官員的銓選方式。")}
  })
  
  output$Discriptions <- renderText({
    TypeWriter1()
  })
  
  DistributionSum <- reactive({
    if(is.factor(new_data[[input$Picks0]])) {
      t1 <- new_data %>% count(.data[[input$Picks0]])
    } else {t1 <- NULL}
    t1
  })
  
  output$Summaries <- renderTable({
    DistributionSum()
  })
  
  output$DataDownload1 <- downloadHandler(
    filename = "數據樣本.xlsx",
    content = function(file) {
      write.xlsx(dataTable1(), file, row.names = F)
    }
  )
  
  output$DataDownload2 <- downloadHandler(
    filename = "分佈表.xlsx",
    content = function(file) {
      write.xlsx(DistributionSum(), file, row.names = F)
    }
  )
  
  output$UI2 <- renderUI({
    tabsetPanel(
      id = "Tab1",
      tabPanel(
        title = p(strong(em("饼状图")), HTML('&nbsp;'), HTML('&nbsp;'), style="font-size:22px"),
        value = "Pie",
        br(),
        fluidRow(
          column(
            plotOutput("PieChart", height = "650px", width = "100%") %>% withSpinner(size = 1.5, color="#0dc5c1"),
            style="background-color:Lightyellow;border: 1px solid black;",
            width = 12
          )
        )
      ),
      tabPanel(
        title = p(strong(em("柱状图")), HTML('&nbsp;'), HTML('&nbsp;'), style="font-size:22px"),
        value = "Bar",
        br(),
        fluidRow(
          column(
            plotOutput("BarGraph", height = "650px", width = "100%") %>% withSpinner(size = 1.5, color="#0dc5c1"),
            style="background-color:Lightyellow;border: 1px solid black;",
            width = 12
          )
        )
      ),
      tabPanel(
        title = p(strong(em("热力图")), HTML('&nbsp;'), HTML('&nbsp;'), style="font-size:22px"),
        value = "Heat",
        br(),
        fluidRow(
          column(
            plotOutput("HeatMap", height = "650px", width = "100%") %>% withSpinner(size = 1.5, color="#0dc5c1"),
            style="background-color:Lightyellow;border: 1px solid black;",
            width = 12
          )
        )
      ),
      tabPanel(
        title = p(strong(em("球形图")), style="font-size:22px"),
        value = "Balloon",
        br(),
        fluidRow(
          column(
            plotOutput("BalloonPlot", height = "650px", width = "100%") %>% withSpinner(size = 1.5, color="#0dc5c1"),
            style="background-color:Lightyellow;border: 1px solid black;",
            width = 12
          )
        )
      )
    )
  })
  
  YearPicks1 <- reactive({
    年份范围 <- 1900:1912
    年份范围[年份范围 >= input$YearPicks1[1] & 年份范围 <= input$YearPicks1[2]]
  })
  
  PieBaker1 <- eventReactive(input$Trigger2, {
    t1 <- new_data %>%
      dplyr::filter(陽歷年份 %in% YearPicks1()) %>%
      dplyr::select(input$Picks1) %>%
      table() %>%
      as.data.frame() %>%
      mutate(Percentage = Freq/sum(Freq))
    
    ggplot(t1, aes(x = "", y = Percentage, fill = .)) +
      geom_col() +
      scale_y_continuous(breaks = seq(0, 0.8, by = 0.2)) +
      scale_fill_viridis_d() +
      coord_polar("y") +
      labs(x = NULL, y = NULL, fill = input$Picks1, title = paste(input$Picks1, "的分佈圖")) +
      guides(fill = guide_legend(reverse = T), color = guide_legend(reverse = T)) +
      theme_minimal() +
      theme(plot.title = element_text(color = "steelblue", size = 26),
            legend.text = element_text(size = 20),
            legend.title = element_text(size = 22),
            axis.title = element_text(size = 22),
            axis.text = element_text(size = 20),
            plot.background = element_rect(fill = "lightyellow"))
  })
  
  PieBaker2 <- eventReactive(input$Trigger2, {
    t1 <- new_data %>%
      dplyr::filter(陽歷年份 %in% YearPicks1()) %>%
      dplyr::select(input$Picks1, input$Picks2) %>%
      table() %>%
      prop.table(margin = 1) %>%
      as.data.frame()
    
    ggplot(t1, aes(x = .data[[input$Picks1]], y = Freq, fill = .data[[input$Picks2]], color = .data[[input$Picks1]])) +
      geom_col() +
      scale_x_discrete(limits = rev(levels(new_data[[input$Picks1]]))) +
      scale_y_continuous(breaks = seq(0, 0.8, by = 0.2)) +
      scale_fill_viridis_d() +
      scale_color_few() +
      coord_polar("y") +
      labs(x = NULL, y = NULL, fill = input$Picks2, title = paste(input$Picks1, "&", input$Picks2, "的分佈圖")) +
      guides(fill = guide_legend(reverse = T), color = guide_legend(reverse = T)) +
      theme_minimal() +
      theme(plot.title = element_text(color = "steelblue", size = 26),
            legend.text = element_text(size = 20),
            legend.title = element_text(size = 20),
            axis.title = element_text(size = 22),
            axis.text = element_text(size = 20),
            plot.background = element_rect(fill = "lightyellow"))
  })
  
  PieBaker3 <- eventReactive(input$Trigger2, {
    t1 <- new_data %>%
      dplyr::filter(陽歷年份 %in% YearPicks1()) %>%
      dplyr::select(input$Picks1, input$Picks2, input$Picks3) %>%
      table() %>%
      prop.table(margin = c(1, 3)) %>%
      as.data.frame()
    
    ggplot(t1, aes(x = .data[[input$Picks1]], y = Freq, fill = .data[[input$Picks2]], color = .data[[input$Picks1]])) +
      geom_col() +
      scale_x_discrete(limits = rev(levels(new_data[[input$Picks1]]))) +
      scale_y_continuous(breaks = seq(0, 0.8, by = 0.2)) +
      scale_fill_viridis_d() +
      scale_color_few() +
      coord_polar("y") +
      labs(x = NULL, y = NULL, fill = input$Picks2, title = paste(input$Picks1, "&", input$Picks2, "&", input$Picks3, "的分佈圖")) +
      guides(fill = guide_legend(reverse = T), color = guide_legend(reverse = T)) +
      facet_wrap(~ .data[[input$Picks3]]) +
      theme_minimal() +
      theme(plot.title = element_text(color = "steelblue", size = 26),
            legend.text = element_text(size = 20),
            legend.title = element_text(size = 20),
            axis.title = element_text(size = 22),
            axis.text = element_text(size = 20),
            strip.text = element_text(size = 22),
            plot.background = element_rect(fill = "lightyellow"))
  })
  
  BarStacker1 <- eventReactive(input$Trigger2, {
    data <- new_data %>%
      dplyr::filter(陽歷年份 %in% YearPicks1()) %>%
      dplyr::select(input$Picks1)
    ggplot(data, aes(x = .data[[input$Picks1]])) +
      geom_bar(aes(fill = .data[[input$Picks1]]), position = position_dodge2(reverse = T), color = "lightgrey") +
      geom_text(stat = "count", aes(label = ..count.., group = .data[[input$Picks1]]), position = position_dodge2(width = 0.88, reverse = T), vjust = -0.25) +
      labs(y = "Count", title = paste(input$Picks1, "&", input$Picks2, "&", input$Picks3, "的分佈圖")) +
      scale_y_continuous(trans = "sqrt") +
      scale_fill_hue() +
      guides(fill = guide_legend(reverse = T)) +
      theme_minimal() +
      theme(plot.title = element_text(color = "steelblue", size = 26),
            legend.text = element_text(size = 20),
            legend.title = element_text(size = 20),
            axis.title = element_text(size = 22),
            axis.text.x = element_text(size = 17, angle = 30, hjust = 1),
            axis.text.y = element_text(size = 20),
            plot.background = element_rect(fill = "lightyellow"))
  })
  
  BarStacker2 <- eventReactive(input$Trigger2, {
    data <- new_data %>%
      dplyr::filter(陽歷年份 %in% YearPicks1()) %>%
      dplyr::select(input$Picks1, input$Picks2)
    ggplot(data, aes(x = .data[[input$Picks1]])) +
      geom_bar(aes(fill = .data[[input$Picks2]]), position = position_dodge2(reverse = T), color = "lightgrey") +
      geom_text(stat = "count", aes(label = ..count.., group = .data[[input$Picks2]]), position = position_dodge2(width = 0.88, reverse = T), vjust = -0.25) +
      labs(y = "Count", title = paste(input$Picks1, "&", input$Picks2, "的分佈圖")) +
      scale_y_continuous(trans = "sqrt") +
      scale_fill_hue() +
      guides(fill = guide_legend(reverse = T)) +
      theme_minimal() +
      theme(plot.title = element_text(color = "steelblue", size = 26),
            legend.text = element_text(size = 20),
            legend.title = element_text(size = 20),
            axis.title = element_text(size = 22),
            axis.text.x = element_text(size = 17, angle = 30, hjust = 1),
            axis.text.y = element_text(size = 20),
            plot.background = element_rect(fill = "lightyellow"))
  })
  
  BarStacker3 <- eventReactive(input$Trigger2, {
    data <- new_data %>%
      dplyr::filter(陽歷年份 %in% YearPicks1()) %>%
      dplyr::select(input$Picks1, input$Picks2, input$Picks3)
    ggplot(data, aes(x = .data[[input$Picks1]])) +
      geom_bar(aes(fill = .data[[input$Picks2]]),  position = position_dodge2(reverse = T), color = "lightgrey") +
      geom_text(stat = "count", aes(label = ..count.., group = .data[[input$Picks2]]), position = position_dodge2(width = 0.88, reverse = T), vjust = -0.25) +
      labs(y = "Count", title = paste(input$Picks1, "&", input$Picks2, "&", input$Picks3, "的分佈圖")) +
      scale_y_continuous(trans = "sqrt") +
      scale_fill_hue() +
      guides(fill = guide_legend(reverse = T)) +
      facet_wrap(~ .data[[input$Picks3]]) +
      theme_minimal() +
      theme(plot.title = element_text(color = "steelblue", size = 26),
            legend.text = element_text(size = 20),
            legend.title = element_text(size = 20),
            axis.title = element_text(size = 22),
            axis.text.x = element_text(size = 17, angle = 30, hjust = 1),
            axis.text.y = element_text(size = 20),
            strip.text = element_text(size = 22),
            plot.background = element_rect(fill = "lightyellow"))
  })
  
  Heater1 <- eventReactive(input$Trigger2, {
    t1 <- new_data %>%
      dplyr::filter(陽歷年份 %in% YearPicks1()) %>%
      dplyr::select(input$Picks1) %>%
      table() %>%
      prop.table() %>%
      as.data.frame()
    
    ggplot(t1, aes(x = ., y = "")) +
      geom_tile(aes(fill = Freq), color = "black") +
      scale_fill_gradient2(low = "yellow", mid = "lightblue", high = "red",
                           guide = guide_colorbar(ticks = F, barheight = 10)) +
      labs(fill = "Presentage", title = paste(input$Picks1, "的分佈圖")) +
      theme_minimal() +
      theme(plot.title = element_text(color = "steelblue", size = 26),
            legend.text = element_text(size = 20),
            legend.title = element_text(size = 20),
            axis.title = element_text(size = 24),
            axis.text.x = element_text(size = 17, angle = 30, hjust = 1),
            axis.text.y = element_text(size = 20),
            plot.background = element_rect(fill = "lightyellow"))
  })
  
  Heater2 <- eventReactive(input$Trigger2, {
    t1 <- new_data %>%
      dplyr::filter(陽歷年份 %in% YearPicks1()) %>%
      dplyr::select(input$Picks1, input$Picks2) %>%
      table() %>%
      prop.table(margin = 1) %>%
      as.data.frame()
    
    ggplot(t1, aes(x = .data[[input$Picks2]], y = .data[[input$Picks1]])) +
      geom_tile(aes(fill = Freq), color = "black") +
      scale_fill_gradient2(low = "yellow", mid = "lightblue", high = "red",
                           guide = guide_colorbar(ticks = F, barheight = 10)) +
      labs(fill = "Presentage", title = paste(input$Picks1, "&", input$Picks2, "的分佈圖")) +
      theme_minimal() +
      theme(plot.title = element_text(color = "steelblue", size = 26),
            legend.text = element_text(size = 20),
            legend.title = element_text(size = 20),
            axis.title = element_text(size = 24),
            axis.text.x = element_text(size = 17, angle = 30, hjust = 1),
            axis.text.y = element_text(size = 20),
            plot.background = element_rect(fill = "lightyellow"))
  })
  
  Heater3 <- eventReactive(input$Trigger2, {
    t1 <- new_data %>%
      dplyr::filter(陽歷年份 %in% YearPicks1()) %>%
      dplyr::select(input$Picks1, input$Picks2, input$Picks3) %>%
      table() %>%
      prop.table(margin = c(1, 3)) %>%
      as.data.frame()
    
    ggplot(t1, aes(x = .data[[input$Picks2]], y = .data[[input$Picks1]])) +
      geom_tile(aes(fill = Freq), color = "black") +
      scale_fill_gradient2(low = "yellow", mid = "lightblue", high = "red",
                           guide = guide_colorbar(ticks = F, barheight = 10)) +
      facet_wrap(~ .data[[input$Picks3]]) +
      labs(fill = "Presentage", title = paste(input$Picks1, "&", input$Picks2, "&", input$Picks3, "的分佈圖")) +
      theme_minimal() +
      theme(plot.title = element_text(color = "steelblue", size = 26),
            legend.text = element_text(size = 20),
            legend.title = element_text(size = 20),
            axis.title = element_text(size = 24),
            axis.text.x = element_text(size = 17, angle = 30, hjust = 1),
            axis.text.y = element_text(size = 20),
            strip.text = element_text(size = 22),
            plot.background = element_rect(fill = "lightyellow"))
  })
  
  BalloonPumper1 <- eventReactive(input$Trigger2, {
    t1 <- new_data %>%
      dplyr::filter(陽歷年份 %in% YearPicks1()) %>%
      dplyr::select(input$Picks1) %>%
      table() %>%
      as.data.frame()
    
    ggplot(t1, aes(x = ., y = "")) +
      geom_point(aes(size = Freq, color = .)) +
      scale_size_area(max_size = 50) +
      labs(color = "Count", size = "Count", title = paste(input$Picks1, "的分佈圖")) +
      theme_minimal() +
      theme(plot.title = element_text(color = "steelblue", size = 26),
            legend.text = element_text(size = 20),
            legend.title = element_text(size = 20),
            axis.title = element_text(size = 24),
            axis.text.x = element_text(size = 17, angle = 30, hjust = 1),
            axis.text.y = element_text(size = 20),
            plot.background = element_rect(fill = "lightyellow"))
  })
  
  BalloonPumper2 <- eventReactive(input$Trigger2, {
    t1 <- new_data %>%
      dplyr::filter(陽歷年份 %in% YearPicks1()) %>%
      dplyr::select(input$Picks1, input$Picks2) %>%
      table() %>%
      as.data.frame()
    
    ggplot(t1, aes(x = .data[[input$Picks2]], y = .data[[input$Picks1]])) +
      geom_point(aes(size = Freq, color = Freq)) +
      scale_size_area(max_size = 40) +
      scale_color_gradient2(low = "yellow", mid = "lightblue", high = "red",
                            guide = guide_colorbar(ticks = F, barheight = 10)) +
      labs(color = "Count", size = "Count", title = paste(input$Picks1, "&", input$Picks2, "的分佈圖")) +
      theme_minimal() +
      theme(plot.title = element_text(color = "steelblue", size = 26),
            legend.text = element_text(size = 20),
            legend.title = element_text(size = 20),
            axis.title = element_text(size = 24),
            axis.text.x = element_text(size = 17, angle = 30, hjust = 1),
            axis.text.y = element_text(size = 20),
            plot.background = element_rect(fill = "lightyellow"))
  })
  
  BalloonPumper3 <- eventReactive(input$Trigger2, {
    t1 <- new_data %>%
      dplyr::filter(陽歷年份 %in% YearPicks1()) %>%
      dplyr::select(input$Picks1, input$Picks2, input$Picks3) %>%
      table() %>%
      as.data.frame()
    
    ggplot(t1, aes(x = .data[[input$Picks2]], y = .data[[input$Picks1]])) +
      geom_point(aes(size = Freq, color = Freq)) +
      scale_size_area(max_size = 30) +
      scale_color_gradient2(low = "yellow", mid = "lightblue", high = "red",
                            guide = guide_colorbar(ticks = F, barheight = 10)) +
      facet_wrap(~ .data[[input$Picks3]]) +
      labs(color = "Count", size = "Count", title = paste(input$Picks1, "&", input$Picks2, "&", input$Picks3, "的分佈圖")) +
      theme_minimal() + 
      theme(plot.title = element_text(color = "steelblue", size = 26),
            legend.text = element_text(size = 20),
            legend.title = element_text(size = 20),
            axis.title = element_text(size = 24),
            axis.text.x = element_text(size = 17, angle = 30, hjust = 1),
            axis.text.y = element_text(size = 20),
            strip.text = element_text(size = 24),
            plot.background = element_rect(fill = "lightyellow"))
  })
  
  output$PieChart <- renderPlot({
    if(input$Picks3 == "不选择"){
      if(input$Picks2 == "不选择"){
        PieBaker1()
      } else PieBaker2()
    } else PieBaker3()
  })
  
  output$BarGraph <- renderPlot({
    if(input$Picks3 == "不选择"){
      if(input$Picks2 == "不选择"){
        BarStacker1()
      } else BarStacker2()
    } else BarStacker3()
  })
  
  output$HeatMap <- renderPlot({
    if(input$Picks3 == "不选择"){
      if(input$Picks2 == "不选择"){
        Heater1()
      } else Heater2()
    } else Heater3()
  })
  
  output$BalloonPlot <- renderPlot({
    if(input$Picks3 == "不选择"){
      if(input$Picks2 == "不选择"){
        BalloonPumper1()
      } else BalloonPumper2()
    } else BalloonPumper3()
  })
  
  output$DataDownload3 <- downloadHandler(
    filename = "分布图.png",
    content = function(file) {
      if(input$Tab1 == "Pie") {
        if(input$Picks3 == "不选择"){
          if(input$Picks2 == "不选择"){
            ggsave(plot = PieBaker1(), filename = file, device = "png")
          } else ggsave(plot = PieBaker2(), filename = file, device = "png")
        } else ggsave(plot = PieBaker3(), filename = file, device = "png")
      }
      if(input$Tab1 == "Bar") {
        if(input$Picks3 == "不选择"){
          if(input$Picks2 == "不选择"){
            ggsave(plot =  BarStacker1(), filename = file, device = "png")
          } else ggsave(plot = BarStacker2(), filename = file, device = "png")
        } else ggsave(plot = BarStacker3(), filename = file, device = "png")
      }
      if(input$Tab1 == "Heat") {
        if(input$Picks3 == "不选择"){
          if(input$Picks2 == "不选择"){
            ggsave(plot = Heater1(), filename = file, device = "png")
          } else ggsave(plot = Heater2(), filename = file, device = "png")
        } else ggsave(plot = Heater3(), filename = file, device = "png")
      }
      if(input$Tab1 == "Balloon") {
        if(input$Picks3 == "不选择"){
          if(input$Picks2 == "不选择"){
            ggsave(plot = BalloonPumper1(), filename = file, device = "png")
          } else ggsave(plot = BalloonPumper2(), filename = file, device = "png")
        } else ggsave(plot = BalloonPumper3(), filename = file, device = "png")
      }
    }
  )
  
  UI3 <- eventReactive(input$Trigger3, {
    width = "100%"
    width
  })
  
  output$UI3 <- renderUI({
    dataTableOutput("DiscriptiveTable", width = UI3()) %>% withSpinner(size = 1.5, color="#0dc5c1")
  })
  
  YearPicks2 <- reactive({
    年份範圍 <- 1900:1912
    年份範圍[年份範圍 >= input$YearPicks2[1] & 年份範圍 <= input$YearPicks2[2]]
  })
  
  tableGenerator1 <- eventReactive(input$Trigger3, {
    dummiesDatas <- new_data %>%
      dplyr::filter(陽歷年份 %in% YearPicks2()) %>%
      mutate(
        "旗人" = case_when(旗分二 == "旗人" ~ 1, 旗分二 != "旗人" ~ 0),
        "非旗人" = case_when(旗分二 == "非旗人" ~ 1, 旗分二 != "非旗人" ~ 0),
        "進士" = case_when(出身一 == "進士" ~ 1, 出身一 != "進士" ~ 0),
        "舉人" = case_when(出身一 == "舉人" ~ 1, 出身一 != "舉人" ~ 0),
        "貢生" = case_when(出身一 == "貢生" ~ 1, 出身一 != "貢生" ~ 0),
        "監生" = case_when(出身一 == "監生" ~ 1, 出身一 != "監生" ~ 0),
        "生員" = case_when(出身一 == "生員" ~ 1, 出身一 != "生員" ~ 0),
        "蔭生" = case_when(出身一 == "蔭生" ~1, 出身一 != "蔭生" ~ 0),
        "吏員" = case_when(出身一 == "吏員" ~ 1, 出身一 != "吏員" ~ 0),
        "翻譯" = case_when(出身一 == "翻譯" ~ 1, 出身一 != "翻譯" ~ 0),
        "畢業生" = case_when(出身一 == "畢業生" ~ 1, 出身一 != "畢業生" ~ 0),
        "其他出身" = case_when(出身一 == "其他" ~ 1, 出身一 != "其他" ~ 0),
        "無記錄出身" = case_when(出身一 == "無記錄" ~ 1, 出身一 != "無記錄" ~ 0),
        "京師" = case_when(地區 == "京師" ~ 1, 地區 != "京師" ~ 0),
        "地方" = case_when(地區 == "地方" ~ 1, 地區 != "地方" ~ 0))
    
    full_summarise <- function(df, ..., roundn = 2, range = FALSE) {
      output.m <- df %>% summarise_at(vars(...), funs(mean = mean(., na.rm = TRUE))) %>% t()
      colnames(output.m) <- "Mean"
      output.sd <- df %>% summarise_at(vars(...), funs(sd = sd(., na.rm = TRUE))) %>% t()
      colnames(output.sd) <- "SD"
      des <- cbind(output.m, output.sd) %>% 
        data.frame() %>%
        mutate(Variable = str_extract(rownames(.), "^.+(?=_)"),
               Mean = format(round(Mean, roundn), nsmall=roundn),
               SD = format(round(SD, roundn), nsmall=roundn),
               `Proportion (SD)` = paste0(Mean, " (", SD, ")"),
               Mean = NULL,
               SD = NULL) %>%
        tibble()
      if (range == TRUE) {
        output.min <- df %>% summarise_at(vars(...), funs(min = min(., na.rm = TRUE))) %>% t() %>% tibble()
        des$Min <- output.min$.[,1]
        output.max <- df %>% summarise_at(vars(...), funs(max = max(., na.rm = TRUE))) %>% t() %>% tibble()
        des$Max <- output.max$.[,1]
      }
      des$Variable[is.na(des$Variable)] <- deparse(substitute(...))
      return(des)
    } 
    group_summarise <- function(df, group, ..., roundn = 2, na.rm = TRUE) {
      output.m <- df %>% group_by(.data[[group]]) %>% summarise_at(vars(...), funs(mean = mean(., na.rm = TRUE))) %>% t()
      colnames(output.m) <- paste0("X", 1:ncol(output.m))
      output.sd <- df %>% group_by(.data[[group]]) %>% summarise_at(vars(...), funs(sd = sd(., na.rm = TRUE))) %>% t()
      colnames(output.sd) <- paste0("Y", 1:ncol(output.m))
      des <- cbind(output.m, output.sd) %>% 
        data.frame() %>%
        slice(-1) %>%
        mutate(Variable = str_extract(rownames(.), "^.+(?=_)")) %>%
        tibble()
      names <- output.m[1,] %>% as.character() %>% paste(rownames(output.m)[1], .)
      for (i in 1:ncol(output.m)) {
        des[[paste0("X", i)]] <- format(round(as.double(des[[paste0("X", i)]]), roundn), nsmall=roundn)
        des[[paste0("Y", i)]] <- format(round(as.double(des[[paste0("Y", i)]]), roundn), nsmall=roundn)
        des[[names[i]]] <- paste0(des[[paste0("X", i)]], " (", des[[paste0("Y", i)]], ")")
      }
      des <- des %>% dplyr::select(-starts_with("X"))
      des <- des %>% dplyr::select(-starts_with("Y"))
      des$Variable[is.na(des$Variable)] <- deparse(substitute(...))
      print(as.character(output.m[1,]))
      if (na.rm == TRUE & (NA %in% as.character(output.m[1,]))) {
        des <- select(des, -ends_with("NA"))
      }
      return(des)
    }
    tab1 <- cbind(full_summarise(dummiesDatas, "旗人":"地方"),
                  group_summarise(dummiesDatas, input$Picks4, "旗人":"地方")) %>%
      '['(-3)
  })
  
  output$DiscriptiveTable <- DT::renderDataTable(
    datatable({
      tableGenerator1()
    },
    options = list(lengthMenu = list(c(15, 25, 35),c('15','35','35')),
                   pageLength = 25,
                   initComplete = JS(
                     "function(settings, json) {",
                     "$(this.api().table().header()).css({'background-color': 'moccasin', 'color': '1c1b1b'});",
                     "}"),columnDefs=list(list(className='dt-center',targets="_all"))
    ),
    style = 'bootstrap',
    class = 'cell-border stripe',
    rownames = FALSE
    )
  )
  
  output$DataDownload4 <- downloadHandler(
    filename = "統計表.xlsx",
    content = function(file) {
      write.xlsx(tableGenerator1(), file, row.names = F)
    }
  )
  
  UI4 <- eventReactive(input$Trigger4, {
    height = "650px"
    height
  })
  
  output$UI4 <- renderUI({
    fluidRow(
      column(
        plotOutput("MCA_Plot1", height = UI4()) %>% withSpinner(size = 1.5, color="#0dc5c1"),
        style="background-color:Lightgrey;border: 1px solid black;",
        width = 9
      ),
      column(
        plotOutput("MCA_Plot2", height = UI4()) %>% withSpinner(size = 1.5, color="#0dc5c1"),
        style="background-color:Lightgrey;border: 1px solid black;",
        width = 3
      )
    )
  })
  
  YearPicks3 <- reactive({
    年份範圍 <- 1900:1912
    年份範圍[年份範圍 >= input$YearPicks3[1] & 年份範圍 <= input$YearPicks3[2]]
  })
  
  datasMCA <- eventReactive(input$Trigger4, {
    dataMCA <- new_data %>%
      dplyr::filter(陽歷年份 %in% YearPicks3())
    dataMCA <- dataMCA[sample(nrow(new_data), 300), input$Picks7]
    dataMCA
  })
  
  MCA_Test1 <- eventReactive(input$Trigger4, {
    res.mca <- MCA(datasMCA(), graph = FALSE)
    fviz_screeplot(res.mca, addlabels = TRUE, ylim = c(0, 20), ggtheme = theme_solarized()) +
      geom_hline(yintercept=10, linetype=2, color="red") +
      theme(plot.title = element_text(color = "steelblue", size = 22),
            legend.text = element_text(size = 16),
            legend.title = element_text(size = 16),
            axis.title = element_text(size = 20),
            axis.text = element_text(size = 16),
            plot.background = element_rect(fill = "lightgrey"))
  })
  
  MCA_Test2 <- eventReactive(input$Trigger4, {
    res.mca <- MCA(datasMCA(), graph = FALSE)
    var <- get_mca_var(res.mca)
    corrplot(var$cos2, is.corr=FALSE)
  })
  
  MCA_Test3 <- eventReactive(input$Trigger4, {
    res.mca <- MCA(datasMCA(), graph = FALSE)
    fviz_contrib(res.mca,
                 choice = "var",
                 axes = 1,
                 top = 10,
                 ggtheme = theme_solarized()) +
      theme(plot.title = element_text(color = "steelblue", size = 22),
            legend.text = element_text(size = 16),
            legend.title = element_text(size = 16),
            axis.title = element_text(size = 20),
            axis.text = element_text(size = 16),
            plot.background = element_rect(fill = "lightgrey"))
  })
  
  MCA_Test4 <- eventReactive(input$Trigger4, {
    res.mca <- MCA(datasMCA(), graph = FALSE)
    fviz_contrib(res.mca,
                 choice = "var",
                 axes = 2,
                 top = 10,
                 ggtheme = theme_solarized()) +
      theme(plot.title = element_text(color = "steelblue", size = 22),
            legend.text = element_text(size = 16),
            legend.title = element_text(size = 16),
            axis.title = element_text(size = 20),
            axis.text = element_text(size = 16),
            plot.background = element_rect(fill = "lightgrey"))
  })
  
  MCA_Test5 <- eventReactive(input$Trigger4, {
    res.mca <- MCA(datasMCA(), graph = FALSE)
    fviz_mca_var(res.mca,
                 repel = T,
                 col.var = "cos2",
                 gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
                 ggtheme = theme_solarized()) +
      guides(color = guide_colorbar(barheight = 15)) +
      theme(plot.title = element_text(color = "steelblue", size = 24),
            legend.text = element_text(size = 16),
            legend.title = element_text(size = 16),
            axis.title = element_text(size = 20),
            axis.text = element_text(size = 16),
            plot.background = element_rect(fill = "lightgrey"))
  })
  
  output$MCA_Plot1 <- renderPlot({
    MCA_Test5()
  })
  
  output$MCA_Plot2 <- renderPlot({
    if(input$Picks8 == 1){MCA_Test1()}
    else if(input$Picks8 == 2){MCA_Test2()}
    else if(input$Picks8 == 3){MCA_Test3()}
    else if(input$Picks8 == 4){MCA_Test4()}
  })
  
  output$DataDownload5 <- downloadHandler(
    filename = "多重共變分析報告.pdf",
    content = function(file) {
      params <- list(
        Data = datasMCA()
      )
      showNotification(
        p(
          em("報告生成中..."),
          style="text-align:center;color:black;font-size:35px"
        ), 
        id = "Notice1",
        duration = 10, 
        closeButton = T,
        type = "warning"
      )
      rmarkdown::render(
        report_path, 
        output_file = file,
        params = params,
        envir = new.env(parent = globalenv())
      )
    }
  )
  
  UI5 <- eventReactive(input$Trigger5, {
    width = "100%"
    width
  })
  
  output$UI5 <- renderUI({
    tableGenerator2()
    includeHTML("www/Tab2.html")
  })
  
  YearPicks4 <- reactive({
    年份範圍 <- 1900:1912
    年份範圍[年份範圍 >= input$YearPicks4[1] & 年份範圍 <= input$YearPicks4[2]]
  })
  
  tableGenerator2 <- eventReactive(input$Trigger5, {
    new_data %>%
      dplyr::filter(陽歷年份 %in% YearPicks4()) %>%
      dplyr::select(input$Picks5) %>%
      table() %>%
      ftable() %>%
      write_html(
        file = "www/Tab2.html",
        toprule = 2,
        midrule = 2,
        bottomrule = 2
      )
  })
  
  output$DataDownload6 <- downloadHandler(
    filename = "列聯表.xlsx",
    content = function(file) {
      table(new_data[input$Picks5]) %>%
        ftable() %>%
        as.data.frame() %>%
        write.xlsx(file, row.names = F)
    }
  )
  
  UI6 <- eventReactive(input$Trigger6, {
    height = "650px"
    height
  })
  
  output$UI6 <- renderUI({
    fluidRow(
      column(
        plotOutput("MosaicPlot", height = UI6()) %>% withSpinner(size = 1.5, color="#0dc5c1"),
        style="background-color:lightyellow;border: 1px solid black;",
        width = 12
      )
    )
  })
  
  YearPicks5 <- reactive({
    年份範圍 <- 1900:1912
    年份範圍[年份範圍 >= input$YearPicks5[1] & 年份範圍 <= input$YearPicks5[2]]
  })
  
  mosaicGenerator1 <- eventReactive(input$Trigger6, {
    new_data %>%
      dplyr::filter(陽歷年份 %in% YearPicks5()) %>%
      dplyr::rename(Region = 地區, BannerTwo = 旗分二, Ethnicity = 身份二, Qualification = 出身一, BannerOne = 旗分一, Manner = 銓選方式) %>%
      ggplot() +
      geom_mosaic(aes(x = product(UQ(sym(input$PicksM1))), fill = UQ(sym(input$PicksM1)))) +
      labs(x = input$PicksM1, title = paste("Mosaic plot of", input$PicksM1)) +
      guides(fill = guide_legend(reverse = T)) +
      theme_solarized() +
      theme(plot.title = element_text(color = "steelblue", size = 22),
            legend.text = element_text(size = 16),
            legend.title = element_text(size = 16),
            axis.title = element_text(size = 20),
            axis.text.x = element_text(size = 16, angle = 60, hjust = 1),
            axis.text.y = element_text(size = 16),
            plot.background = element_rect(fill = "lightyellow"))
  })
  
  mosaicGenerator2 <- eventReactive(input$Trigger6, {
    new_data %>%
      dplyr::filter(陽歷年份 %in% YearPicks5()) %>%
      dplyr::rename(Region = 地區, BannerTwo = 旗分二, Ethnicity = 身份二, Qualification = 出身一, BannerOne = 旗分一, Manner = 銓選方式) %>%
      ggplot() +
      geom_mosaic(aes(x = product(UQ(sym(input$PicksM1)), UQ(sym(input$PicksM2))), fill = UQ(sym(input$PicksM1))), show.legend = T) +
      labs(x = input$PicksM2, y = input$PicksM1, title = paste("Mosaic plot of", input$PicksM1, "&", input$PicksM2)) +
      guides(fill = guide_legend(reverse = T)) +
      theme_solarized() +
      theme(plot.title = element_text(color = "steelblue", size = 22),
            legend.text = element_text(size = 16),
            legend.title = element_text(size = 16),
            axis.title = element_text(size = 20),
            axis.text.x = element_text(size = 16, angle = 60, hjust = 1),
            axis.text.y = element_text(size = 16),
            plot.background = element_rect(fill = "lightyellow"))
  })
  
  mosaicGenerator3 <- eventReactive(input$Trigger6, {
    new_data %>%
      dplyr::filter(陽歷年份 %in% YearPicks5()) %>%
      dplyr::rename(Region = 地區, BannerTwo = 旗分二, Ethnicity = 身份二, Qualification = 出身一, BannerOne = 旗分一, Manner = 銓選方式) %>%
      ggplot() +
      geom_mosaic(aes(x = product(UQ(sym(input$PicksM1)), UQ(sym(input$PicksM2))), fill = UQ(sym(input$PicksM1)))) +
      labs(x = input$PicksM2, y = input$PicksM1, title = paste("Mosaic plot of", input$PicksM1, "&", input$PicksM2, "&", input$PicksM3)) +
      facet_wrap(sym(input$PicksM3)) +
      guides(fill = guide_legend(reverse = T)) +
      theme_solarized() +
      theme(plot.title = element_text(color = "steelblue", size = 22),
            legend.text = element_text(size = 16),
            legend.title = element_text(size = 16),
            axis.title = element_text(size = 20),
            axis.text.x = element_text(size = 16, angle = 60, hjust = 1),
            axis.text.y = element_text(size = 16),
            strip.text = element_text(size = 22),
            plot.background = element_rect(fill = "lightyellow"))
  })
  
  output$MosaicPlot <- renderPlot({
    if(input$PicksM3 == "未選擇"){
      if(input$PicksM2 == "未選擇"){
        mosaicGenerator1()
      } else mosaicGenerator2()
    } else mosaicGenerator3()
  })
  
  output$DataDownload7 <- downloadHandler(
    filename = "馬賽克圖.png",
    content = function(file) {
      if(input$PicksM3 == "未選擇"){
        if(input$PicksM2 == "未選擇"){
          ggsave(filename = file, plot = mosaicGenerator1(), device = "png")
        } else ggsave(filename = file, plot = mosaicGenerator2(), device = "png")
      } else ggsave(filename = file, plot = mosaicGenerator3(), device = "png")
    }
  )
  
  UI7 <- eventReactive(input$Trigger7, {
    Var = TRUE
    Var
  })
  
  output$UI7 <- renderUI({
    fluidRow(
      tags$head(tags$style("#ChiTest{
          color: black;
          font-size: 22px;
          font-style: italic;
        }")),
      column(
        width = 2
      ),
      column(
        verbatimTextOutput("ChiTest", placeholder = UI7()) %>% withSpinner(size = 1.5, color="#0dc5c1"),
        tabsetPanel(
          tabPanel(
            p(strong(em("原始數據分佈圖")), HTML('&nbsp;'), HTML('&nbsp;'), HTML('&nbsp;')),
            plotOutput("OriPlot", height = "800px", width = "600px") %>% withSpinner(size = 1, color="#0dc5c1")
          ),
          tabPanel(
            p(strong(em("觀測值表格")), HTML('&nbsp;'), HTML('&nbsp;'), HTML('&nbsp;')),
            verbatimTextOutput("ChiTab1") %>% withSpinner(size = 1, color="#0dc5c1")
          ),
          tabPanel(
            p(strong(em("預期值表格")), HTML('&nbsp;'), HTML('&nbsp;'), HTML('&nbsp;')),
            verbatimTextOutput("ChiTab2") %>% withSpinner(size = 1, color="#0dc5c1")
          ),
          tabPanel(
            p(strong(em("殘差（表格）")), HTML('&nbsp;'), HTML('&nbsp;'), HTML('&nbsp;')),
            verbatimTextOutput("ResiTab") %>% withSpinner(size = 1, color="#0dc5c1")
          ),
          tabPanel(
            p(strong(em("殘差（圖像）")), HTML('&nbsp;'), HTML('&nbsp;'), HTML('&nbsp;')),
            plotOutput("ResiPlot") %>% withSpinner(size = 1, color="#0dc5c1")
          )
        ),
        width = 8
      )
    )
  })
  
  YearPicks6 <- reactive({
    年份範圍 <- 1900:1912
    年份範圍[年份範圍 >= input$YearPicks6[1] & 年份範圍 <= input$YearPicks6[2]]
  })
  
  Chi_Result <- eventReactive(input$Trigger7, {
    new_data %>%
      dplyr::filter(陽歷年份 %in% YearPicks6()) %>%
      dplyr::select(input$`Chi-Vars`) %>%
      table() %>%
      chisq.test()
  })
  
  output$ChiTest <- renderPrint({
    Chi_Result()
  })
  
  output$OriPlot <- renderPlot({
    t1 <- new_data %>%
      dplyr::filter(陽歷年份 %in% YearPicks6()) %>%
      dplyr::select(input$`Chi-Vars`) %>%
      table()
    balloonplot(t1,
                main = "Balloon Plot of the two Variables",
                xlab = "", ylab = "",
                label = F, show.margins = F)
  })
  
  output$Chi_Test <- renderPrint({
    Chi_Result()
  })
  
  output$ChiTab1 <- renderPrint({
    Chi_Result()$observed
  })
  
  output$ChiTab2 <- renderPrint({
    round(Chi_Result()$expected, 3)
  })
  
  output$ResiTab <- renderPrint({
    round(Chi_Result()$residuals, 3)
  })
  
  output$ResiPlot <- renderPlot({
    corrplot(Chi_Result()$residuals, is.cor = FALSE)
  })
  
  output$DataDownload8 <- downloadHandler(
    filename = "卡方檢定報告.pdf",
    content = function(file) {
      params <- list(
        Data = Chi_Result()
      )
      showNotification(
        p(
          em("報告生成中..."),
          style="text-align:center;color:black;font-size:35px"
        ), 
        id = "Notice1",
        duration = 10, 
        closeButton = T,
        type = "warning"
      )
      rmarkdown::render(
        report_path2, 
        output_file = file,
        params = params,
        envir = new.env(parent = globalenv())
      )
    }
  )
  
  output$UI8 <- renderUI({
    tabsetPanel(
      id = "Tab2",
      tabPanel(
        title = p(strong(em("按年")), HTML('&nbsp;'), HTML('&nbsp;'), HTML('&nbsp;'), HTML('&nbsp;'), style="font-size:20px"),
        value = "Year",
        column(
          plotOutput("yearBar", height = "650px") %>% withSpinner(size = 1.5, color="#0dc5c1"),
          style="background-color:lightblue;border: 1px solid black;",
          width = 12
        )
      ),
      tabPanel(
        title = p(strong(em("按季")), style="font-size:20px"),
        value = "Season",
        column(
          plotOutput("seasonBar", height = "650px") %>% withSpinner(size = 1.5, color="#0dc5c1"),
          style="background-color:lightblue;border: 1px solid black;",
          width = 12
        )
      )
    )
  })
  
  YearPicks7 <- eventReactive(input$Trigger8, {
    年份範圍 <- 1900:1912
    年份範圍[年份範圍 >= input$YearPicks7[1] & 年份範圍 <= input$YearPicks7[2]]
  })
  
  annualBar1 <- reactive({
    select_datas <- new_data %>%
      filter(陽歷年份 %in% YearPicks7()) %>%
      group_by(陽歷年份, 季節號, UQ(sym(input$PicksT1)), UQ(sym(input$PicksT2))) %>%
      summarise(Total = length(陽歷年份))
    
    ggplot(select_datas, aes(x = 陽歷年份, y = Total)) +
      geom_col(aes(fill = interaction(UQ(sym(input$PicksT1)), UQ(sym(input$PicksT2))))) +
      scale_y_continuous(breaks = seq(0, 70000, by = 5000)) +
      scale_fill_discrete() +
      labs(x = "年份", y = "總觀測數", fill = paste(input$PicksT1, input$PicksT2)) +
      theme_solarized() +
      theme(plot.title = element_text(color = "steelblue", size = 22),
            legend.text = element_text(size = 16),
            legend.title = element_text(size = 16),
            axis.title = element_text(size = 20),
            axis.text = element_text(size = 16),
            plot.background = element_rect(fill = "lightblue"))
  })
  
  annualBar2 <- reactive({
    select_datas <- new_data %>%
      filter(陽歷年份 %in% YearPicks7()) %>%
      filter(地區 == "京師") %>%
      group_by(陽歷年份, 季節號, UQ(sym(input$PicksT1)), UQ(sym(input$PicksT2))) %>%
      summarise(Total = length(陽歷年份))
    
    ggplot(select_datas, aes(x = 陽歷年份, y = Total)) +
      geom_col(aes(fill = interaction(UQ(sym(input$PicksT1)), UQ(sym(input$PicksT2))))) +
      scale_y_continuous(breaks = seq(0, 70000, by = 5000)) +
      scale_fill_discrete() +
      labs(x = "年份", y = "觀測總數", fill = paste(input$PicksT1, input$PicksT2)) +
      theme_solarized() +
      theme(plot.title = element_text(color = "steelblue", size = 22),
            legend.text = element_text(size = 16),
            legend.title = element_text(size = 16),
            axis.title = element_text(size = 20),
            axis.text = element_text(size = 16),
            plot.background = element_rect(fill = "lightblue"))
  })
  
  annualBar3 <- reactive({
    select_datas <- new_data %>%
      filter(陽歷年份 %in% YearPicks7()) %>%
      filter(地區 == "地方") %>%
      group_by(陽歷年份, 季節號, UQ(sym(input$PicksT1)), UQ(sym(input$PicksT2))) %>%
      summarise(Total = length(陽歷年份))
    
    ggplot(select_datas, aes(x = 陽歷年份, y = Total)) +
      geom_col(aes(fill = interaction(UQ(sym(input$PicksT1)), UQ(sym(input$PicksT2))))) +
      scale_y_continuous(breaks = seq(0, 70000, by = 5000)) +
      scale_fill_discrete() +
      labs(x = "年份", y = "觀測總數", fill = paste(input$PicksT1, input$PicksT2)) +
      theme_solarized() +
      theme(plot.title = element_text(color = "steelblue", size = 22),
            legend.text = element_text(size = 16),
            legend.title = element_text(size = 16),
            axis.title = element_text(size = 20),
            axis.text = element_text(size = 16),
            plot.background = element_rect(fill = "lightblue"))
  })
  
  annualBar4 <- reactive({
    select_datas <- new_data %>%
      filter(陽歷年份 %in% YearPicks7()) %>%
      group_by(陽歷年份, 季節號, UQ(sym(input$PicksT1))) %>%
      summarise(Total = length(陽歷年份))
    
    ggplot(select_datas, aes(x = 陽歷年份, y = Total)) +
      geom_col(aes(fill = UQ(sym(input$PicksT1)))) +
      scale_y_continuous(breaks = seq(0, 70000, by = 5000)) +
      scale_fill_discrete() +
      labs(x = "年份", y = "觀測總數", fill = paste(input$PicksT1)) +
      theme_solarized() +
      theme(plot.title = element_text(color = "steelblue", size = 22),
            legend.text = element_text(size = 16),
            legend.title = element_text(size = 16),
            axis.title = element_text(size = 20),
            axis.text = element_text(size = 16),
            plot.background = element_rect(fill = "lightblue"))
  })
  
  annualBar5 <- reactive({
    select_datas <- new_data %>%
      filter(陽歷年份 %in% YearPicks7()) %>%
      filter(地區 == "京師") %>%
      group_by(陽歷年份, 季節號, UQ(sym(input$PicksT1))) %>%
      summarise(Total = length(陽歷年份))
    
    ggplot(select_datas, aes(x = 陽歷年份, y = Total)) +
      geom_col(aes(fill = UQ(sym(input$PicksT1)))) +
      scale_y_continuous(breaks = seq(0, 70000, by = 5000)) +
      scale_fill_discrete() +
      labs(x = "年份", y = "觀測總數", fill = paste(input$PicksT1)) +
      theme_solarized() +
      theme(plot.title = element_text(color = "steelblue", size = 22),
            legend.text = element_text(size = 16),
            legend.title = element_text(size = 16),
            axis.title = element_text(size = 20),
            axis.text = element_text(size = 16),
            plot.background = element_rect(fill = "lightblue"))
  })
  
  annualBar6 <- reactive({
    select_datas <- new_data %>%
      filter(陽歷年份 %in% YearPicks7()) %>%
      filter(地區 == "地方") %>%
      group_by(陽歷年份, 季節號, UQ(sym(input$PicksT1))) %>%
      summarise(Total = length(陽歷年份))
    
    ggplot(select_datas, aes(x = 陽歷年份, y = Total)) +
      geom_col(aes(fill = UQ(sym(input$PicksT1)))) +
      scale_y_continuous(breaks = seq(0, 70000, by = 5000)) +
      scale_fill_discrete() +
      labs(x = "Years", y = "Total Count", fill = paste(input$PicksT1)) +
      theme_solarized() +
      theme(plot.title = element_text(color = "steelblue", size = 22),
            legend.text = element_text(size = 16),
            legend.title = element_text(size = 16),
            axis.title = element_text(size = 20),
            axis.text = element_text(size = 16),
            plot.background = element_rect(fill = "lightblue"))
  })
  
  seasonalBar1 <- reactive({
    select_datas <- new_data %>%
      filter(陽歷年份 %in% YearPicks7()) %>%
      group_by(陽歷年份, 季節號, UQ(sym(input$PicksT1)), UQ(sym(input$PicksT2))) %>%
      summarise(Total = length(陽歷年份))
    
    ggplot(select_datas, aes(x = interaction(陽歷年份, 季節號, lex.order = T), y = Total)) +
      geom_col(aes(fill = interaction(UQ(sym(input$PicksT1)), UQ(sym(input$PicksT2))))) +
      scale_y_continuous(breaks = seq(0, 70000, by = 5000)) +
      scale_fill_discrete() +
      labs(x = "年份.季節", y = "觀測總數", fill = paste(input$PicksT1, input$PicksT2)) +
      theme_solarized() +
      theme(plot.title = element_text(color = "steelblue", size = 22),
            axis.title.x = element_text(size = 20),
            axis.text.y = element_text(size = 16),
            plot.background = element_rect(fill = "lightblue"))
  })
  
  seasonalBar2 <- reactive({
    select_datas <- new_data %>%
      filter(陽歷年份 %in% YearPicks7()) %>%
      filter(地區 == "京師") %>%
      group_by(陽歷年份, 季節號, UQ(sym(input$PicksT1)), UQ(sym(input$PicksT2))) %>%
      summarise(Total = length(陽歷年份))
    
    ggplot(select_datas, aes(x = interaction(陽歷年份, 季節號, lex.order = T), y = Total)) +
      geom_col(aes(fill = interaction(UQ(sym(input$PicksT1)), UQ(sym(input$PicksT2))))) +
      scale_y_continuous(breaks = seq(0, 70000, by = 5000)) +
      scale_fill_discrete() +
      labs(x = "年份.季節", y = "觀測總數", fill = paste(input$PicksT1, input$PicksT2)) +
      theme_solarized() +
      theme(plot.title = element_text(color = "steelblue", size = 22),
            axis.title.x = element_text(size = 20),
            axis.text.y = element_text(size = 16),
            plot.background = element_rect(fill = "lightblue"))
  })
  
  seasonalBar3 <- reactive({
    select_datas <- new_data %>%
      filter(陽歷年份 %in% YearPicks7()) %>%
      filter(地區 == "地方") %>%
      group_by(陽歷年份, 季節號, UQ(sym(input$PicksT1)), UQ(sym(input$PicksT2))) %>%
      summarise(Total = length(陽歷年份))
    
    ggplot(select_datas, aes(x = interaction(陽歷年份, 季節號, lex.order = T), y = Total)) +
      geom_col(aes(fill = interaction(UQ(sym(input$PicksT1)), UQ(sym(input$PicksT2))))) +
      scale_y_continuous(breaks = seq(0, 70000, by = 5000)) +
      scale_fill_discrete() +
      labs(x = "年份.季節", y = "觀測總數", fill = paste(input$PicksT1, input$PicksT2)) +
      theme_solarized() +
      theme(plot.title = element_text(color = "steelblue", size = 22),
            axis.title.x = element_text(size = 20),
            axis.text.y = element_text(size = 16),
            plot.background = element_rect(fill = "lightblue"))
  })
  
  seasonalBar4 <- reactive({
    select_datas <- new_data %>%
      filter(陽歷年份 %in% YearPicks7()) %>%
      group_by(陽歷年份, 季節號, UQ(sym(input$PicksT1))) %>%
      summarise(Total = length(陽歷年份))
    
    ggplot(select_datas, aes(x = interaction(陽歷年份, 季節號, lex.order = T), y = Total)) +
      geom_col(aes(fill = UQ(sym(input$PicksT1)))) +
      scale_y_continuous(breaks = seq(0, 70000, by = 5000)) +
      scale_fill_discrete() +
      labs(x = "年份.季節", y = "觀測總數", fill = paste(input$PicksT1)) +
      theme_solarized() +
      theme(plot.title = element_text(color = "steelblue", size = 22),
            axis.title.x = element_text(size = 20),
            axis.text.y = element_text(size = 16),
            plot.background = element_rect(fill = "lightblue"))
  })
  
  seasonalBar5 <- reactive({
    select_datas <- new_data %>%
      filter(陽歷年份 %in% YearPicks7()) %>%
      filter(地區 == "京師") %>%
      group_by(陽歷年份, 季節號, UQ(sym(input$PicksT1))) %>%
      summarise(Total = length(陽歷年份))
    
    ggplot(select_datas, aes(x = interaction(陽歷年份, 季節號, lex.order = T), y = Total)) +
      geom_col(aes(fill = UQ(sym(input$PicksT1)))) +
      scale_y_continuous(breaks = seq(0, 70000, by = 5000)) +
      scale_fill_discrete() +
      labs(x = "年份.季節", y = "觀測總數", fill = paste(input$PicksT1)) +
      theme_solarized() +
      theme(plot.title = element_text(color = "steelblue", size = 22),
            axis.title.x = element_text(size = 20),
            axis.text.y = element_text(size = 16),
            plot.background = element_rect(fill = "lightblue"))
  })
  
  seasonalBar6 <- reactive({
    select_datas <- new_data %>%
      filter(陽歷年份 %in% YearPicks7()) %>%
      filter(地區 == "地方") %>%
      group_by(陽歷年份, 季節號, UQ(sym(input$PicksT1))) %>%
      summarise(Total = length(陽歷年份))
    
    ggplot(select_datas, aes(x = interaction(陽歷年份, 季節號, lex.order = T), y = Total)) +
      geom_col(aes(fill = UQ(sym(input$PicksT1)))) +
      scale_y_continuous(breaks = seq(0, 70000, by = 5000)) +
      scale_fill_discrete() +
      labs(x = "年份.季節", y = "觀測總數", fill = paste(input$PicksT1)) +
      theme_solarized() +
      theme(plot.title = element_text(color = "steelblue", size = 22),
            axis.title.x = element_text(size = 20),
            axis.text.y = element_text(size = 16),
            plot.background = element_rect(fill = "lightblue"))
  })
  
  output$yearBar <- renderPlot({
    if(input$PicksT2 == "不選擇"){
      if(input$PicksT3 == "全部數據") {
        annualBar4()
      } else if(input$PicksT3 == "中央政府部分"){
        annualBar5()
      } else {annualBar6()}
    } else {
      if(input$PicksT3 == "全部數據") {
        annualBar1()
      } else if(input$PicksT3 == "中央政府部分"){
        annualBar2()
      } else {annualBar3()}
    }
  })
  
  output$seasonBar <- renderPlot({
    if(input$PicksT2 == "不選擇"){
      if(input$PicksT3 == "全部數據") {
        seasonalBar4()
      } else if(input$PicksT3 == "中央政府部分"){
        seasonalBar5()
      } else {seasonalBar6()}
    } else {
      if(input$PicksT3 == "全部數據") {
        seasonalBar1()
      } else if(input$PicksT3 == "中央政府部分"){
        seasonalBar2()
      } else {seasonalBar3()}
    }
  })
  
  UI9 <- eventReactive(input$Trigger9, {
    height = "650px"
    height
  })
  
  output$UI9 <- renderUI({
    fluidRow(
      column(
        plotOutput("TimeSeries", height = UI9()) %>% withSpinner(size = 1.5, color="#0dc5c1"),
        style="background-color:Lightgrey;border: 1px solid black;",
        width = 12
      )
    )
  })
  
  output$DataDownload9 <- downloadHandler(
    filename = "趨勢圖.png",
    content = function(file) {
      if(input$Tab2 == "Year") {
        if(input$PicksT2 == "None"){
          if(input$PicksT3 == "Entire Population") {
            ggsave(filename = file, plot = annualBar4())
          } else if(input$PicksT3 == "Central Government Subsample"){
            ggsave(filename = file, plot = annualBar5())
          } else {ggsave(filename = file, plot = annualBar6())}
        } else {
          if(input$PicksT3 == "Entire Population") {
            ggsave(filename = file, plot = annualBar1())
          } else if(input$PicksT3 == "Central Government Subsample"){
            ggsave(filename = file, plot = annualBar2())
          } else {ggsave(filename = file, plot = annualBar3())}
        }
      }
      if(input$Tab2 == "Season") {
        if(input$PicksT2 == "None"){
          if(input$PicksT3 == "Entire Population") {
            ggsave(filename = file, plot = seasonalBar4())
          } else if(input$PicksT3 == "Central Government Subsample"){
            ggsave(filename = file, plot = seasonalBar5())
          } else {ggsave(filename = file, plot = seasonalBar6())}
        } else {
          if(input$PicksT3 == "Entire Population") {
            ggsave(filename = file, plot = seasonalBar1())
          } else if(input$PicksT3 == "Central Government Subsample"){
            ggsave(filename = file, plot = seasonalBar2())
          } else {ggsave(filename = file, plot = seasonalBar3())}
        }
      }
    }
  )
  
  timeSeries <- eventReactive(input$Trigger9, {
    select_datas <- new_data %>%
      group_by(陽歷年份, UQ(sym(input$PicksTS1))) %>%
      summarise(Total = length(陽歷年份)) %>%
      dcast(as.formula(paste("陽歷年份", "~", input$PicksTS1)), value.var = "Total")
    
    tsModel <- ts(data = select_datas, start = input$YearPicks8[1], end = input$YearPicks8[2]) %>%
      as.data.frame() %>%
      mutate(陽歷年份 = 陽歷年份 + 1899) %>%
      melt(id.vars = c("陽歷年份"),
           measure.vars = levels(new_data[[input$PicksTS1]]),
           variable.name = c(input$PicksTS1),
           value.name = c("Count"))
    
    ggplot(tsModel, aes(x = 陽歷年份, y = Count)) +
      geom_area(aes(fill = .data[[input$PicksTS1]], color = .data[[input$PicksTS1]]), alpha = 0.5, position = position_stack()) +
      scale_x_continuous(breaks = seq(from = 1900, to = 1912, by = 1)) +
      scale_color_discrete() +
      scale_fill_discrete() +
      labs(x = "年份", y = "觀測數量", title = paste("關於", input$PicksTS1, "的時間序列分析")) +
      theme_solarized() +
      theme(plot.title = element_text(color = "steelblue", size = 22),
            legend.text = element_text(size = 16),
            legend.title = element_text(size = 16),
            axis.title = element_text(size = 20),
            axis.text = element_text(size = 16),
            plot.background = element_rect(fill = "lightgrey"))
  })
  
  output$TimeSeries <- renderPlot({
    timeSeries()
  })
  
  output$DataDownload10 <- downloadHandler(
    filename = "時間序列圖.png",
    content = function(file) {
      ggsave(
        filename = file,
        plot = timeSeries(),
        device = "png"
      )
    }
  )
}