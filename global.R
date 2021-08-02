library(shiny)
library(shiny.router)
library(shinyWidgets)
library(tidyverse)
library(shinycssloaders)
library(DT)
library(reshape2)
library(digest)
library(gplots)
library(ggmosaic)
library(ggthemes)
library(corrplot)
library(FactoMineR)
library(factoextra)
library(memisc)
library(rmarkdown)
library(showtext)
library(tinytex)
library(xlsx)

landing_page <- tags$div(
  tags$div(
    class = "container-fluid",
    style = "background-image: linear-gradient(#cddafd, #dfe7fd, #f0efeb, #bee1e6, #e2ece9, #fad2e1, #fde2e4, #fff1e6, #eae4e9)",
    br(),
    br(),
    br(),
    h1(
      class = "d-flex justify-content-around",
      span(
        class = "badge rounded-pill bg-primary",
        "中國歷史官員量化數據庫(清代)"
      )
    ),
    br(),
    br(),
    br(),
    tags$div(
      class = "d-flex justify-content-around",
      tags$div(
        class = "card bg-light rounded-pill text-center p-4 lh-lg",
        style = "width: 70rem;",
        tags$div(
          class = "card-body fs-4",
          "歡迎使用CGED-Q (1900-1912) 數據庫分析工具。CGED-Q (1900-1912) 數據庫是完全依照縉紳錄原始文獻錄入的，其中內容均襲清制，使用者请注意。在本站，你可以使用我們搭建的工具，對CGED-Q (1900-1912) 數據庫進行實時的響應式分析，包括進行動態的繪圖，制表和統計學檢定等等。從上方的導覽欄或者是下面的功能介紹開始探索吧！"
        )
      )
    ),
    br(),
    br(),
    br(),
    h1(
      class = "d-flex justify-content-around",
      span(
        class = "badge rounded-pill bg-primary",
        "功能介紹"
      )
    ),
    br(),
    br(),
    br(),
    tags$div(
      class = "container-fluid",
      tags$div(
        class = "row",
        tags$div(
          class = "col text-center d-flex justify-content-around",
          tags$div(
            class = "card border border-primary rounded",
            style = "width: 20rem;",
            tags$img(
              src = "images/Pic1.png",
              class = "card-img-top",
              alt = "pic1"
            ),
            tags$div(
              class = "card-body",
              tags$h5(
                class = "card-title fs-3",
                "數據與變量"
              ),
              tags$p(
                class = "card-text fs-5",
                "先簡單了解CGED-Q (1900-1912) 數據的結構，包括其中含有的變量，變量可能的取值，以及取值的分布等等。"
              ),
              tags$a(
                href = route_link("sample_data"),
                target = "_blank",
                class = "btn btn-lg btn-primary",
                "前往..."
              )
            )
          )
        ),
        tags$div(
          class = "col text-center d-flex justify-content-around",
          tags$div(
            class = "card border border-primary rounded",
            style = "width: 20rem;",
            tags$img(
              src = "images/Pic2.png",
              class = "card-img-top",
              alt = "pic2"
            ),
            tags$div(
              class = "card-body",
              tags$h5(
                class = "card-title fs-3",
                "可視化"
              ),
              tags$p(
                class = "card-text fs-5",
                "通過即時響應式的繪圖，使用者可以快速掌握各變量的分布情況，並初步了解變量間的關系。"
              ),
              tags$a(
                href = route_link("variable_distribution"),
                target = "_blank",
                class = "btn btn-lg btn-primary",
                "前往..."
              )
            )
          )
        ),
        tags$div(
          class = "col text-center d-flex justify-content-around",
          tags$div(
            class = "card border border-primary rounded",
            style = "width: 20rem;",
            tags$img(
              src = "images/Pic3.png",
              class = "card-img-top",
              alt = "pic3"
            ),
            tags$div(
              class = "card-body",
              tags$h5(
                class = "card-title fs-3",
                "統計表"
              ),
              tags$p(
                class = "card-text fs-5",
                "統計表作爲對統計圖的一個延伸，爲使用者提供更精確更量化的信息，包括分組後各變量的分布情況。"
              ),
              tags$a(
                href = route_link("variable_distribution"),
                target = "_blank",
                class = "btn btn-lg btn-primary",
                "前往..."
              )
            )
          )
        )
      ),
      br(),
      br(),
      br(),
      br(),
      tags$div(
        class = "row",
        tags$div(
          class = "col text-center d-flex justify-content-around",
          tags$div(
            class = "card border border-primary rounded",
            style = "width: 20rem;",
            tags$img(
              src = "images/Pic4.png",
              class = "card-img-top",
              alt = "pic4"
            ),
            tags$div(
              class = "card-body",
              tags$h5(
                class = "card-title fs-3",
                "多重共變分析"
              ),
              tags$p(
                class = "card-text fs-5",
                "緊承上一個模塊，想要定量研究變量間的關系還需要更精確的統計方法，比如多重共變分析（MCA）。"
              ),
              tags$a(
                href = route_link("variable_correlation"),
                target = "_blank",
                class = "btn btn-lg btn-primary",
                "前往..."
              )
            )
          )
        ),
        tags$div(
          class = "col text-center d-flex justify-content-around",
          tags$div(
            class = "card border border-primary rounded",
            style = "width: 20rem;",
            tags$img(
              src = "images/Pic5.png",
              class = "card-img-top",
              alt = "pic5"
            ),
            tags$div(
              class = "card-body",
              tags$h5(
                class = "card-title fs-3",
                "列聯表"
              ),
              tags$p(
                class = "card-text fs-5",
                "列聯表可以整合兩或多個變量的取值分布，使它們之間的關系一目了然。"
              ),
              tags$a(
                href = route_link("variable_correlation"),
                target = "_blank",
                class = "btn btn-lg btn-primary",
                "前往..."
              )
            )
          )
        ),
        tags$div(
          class = "col text-center d-flex justify-content-around",
          tags$div(
            class = "card border border-primary rounded",
            style = "width: 20rem;",
            tags$img(
              src = "images/Pic6.png",
              class = "card-img-top",
              alt = "pic6"
            ),
            tags$div(
              class = "card-body",
              tags$h5(
                class = "card-title fs-3",
                "馬賽克圖"
              ),
              tags$p(
                class = "card-text fs-5",
                "馬賽克圖將列聯表的結果以圖表的方式呈現，更加直觀，易懂。"
              ),
              tags$a(
                href = route_link("variable_correlation"),
                target = "_blank",
                class = "btn btn-lg btn-primary",
                "前往..."
              )
            )
          )
        )
      ),
      br(),
      br(),
      br(),
      br(),
      tags$div(
        class = "row",
        tags$div(
          class = "col text-center d-flex justify-content-around",
          tags$div(
            class = "card border border-primary rounded",
            style = "width: 20rem;",
            tags$img(
              src = "images/Pic7.png",
              class = "card-img-top",
              alt = "pic7"
            ),
            tags$div(
              class = "card-body",
              tags$h5(
                class = "card-title fs-3",
                "卡方測定"
              ),
              tags$p(
                class = "card-text fs-5",
                "卡方測定專門用於檢測兩個分類變量間的相關性。"
              ),
              tags$a(
                href = route_link("variable_correlation"),
                target = "_blank",
                class = "btn btn-lg btn-primary",
                "前往..."
              )
            )
          )
        ),
        tags$div(
          class = "col text-center d-flex justify-content-around",
          tags$div(
            class = "card border border-primary rounded",
            style = "width: 20rem;",
            tags$img(
              src = "images/Pic8.png",
              class = "card-img-top",
              alt = "pic8"
            ),
            tags$div(
              class = "card-body",
              tags$h5(
                class = "card-title fs-3",
                "趨勢分析"
              ),
              tags$p(
                class = "card-text fs-5",
                "通過趨勢分析與繪圖，使用者可以觀察到晚清末年中央和地方政府結構與組成上的變化。"
              ),
              tags$a(
                href = route_link("trend_analysis"),
                target = "_blank",
                class = "btn btn-lg btn-primary",
                "前往..."
              )
            )
          )
        ),
        tags$div(
          class = "col text-center d-flex justify-content-around",
          tags$div(
            class = "card border border-primary rounded",
            style = "width: 20rem;",
            tags$img(
              src = "images/Pic9.png",
              class = "card-img-top",
              alt = "pic9"
            ),
            tags$div(
              class = "card-body",
              tags$h5(
                class = "card-title fs-3",
                "時間序列分析"
              ),
              tags$p(
                class = "card-text fs-5",
                "通過時間序列分析與繪圖，使用者可以觀察到晚清末年中央和地方政府結構與組成上的變化。"
              ),
              tags$a(
                href = route_link("trend_analysis"),
                target = "_blank",
                class = "btn btn-lg btn-primary",
                "前往..."
              )
            )
          )
        )
      )
    ),
    br(),
    br(),
    br(),
    br(),
    br()
  ),
  tags$div(
    class = "container-fluid",
    style = "background-color:ivory",
    br(),
    br(),
    tags$div(
      class = "d-flex justify-content-center align-items-center",
      tags$h2(
        "設計與開發：",
        tags$a(
          href = "https://github.com/CharlieLiu-HK",
          target="_blank",
          tags$img(
            src="images/signature.png",
            alt="劉俊德"
          )
        ),
        hr()
      )
    ),
    br(),
    br()
  )
)

sample_data <- tags$div(
  tags$div(
    class = "container-fluid",
    style = "background-image: linear-gradient(#FFF5EB, #DEEDF0, #F4C7AB, #B2B8A3)",
    br(),
    tags$h1(
      class = "d-flex justify-content-around fs-1",
      tags$span(
        class = "badge rounded-pill bg-primary",
        "認識數據與變量"
      )
    ),
    br(),
    hr(),
    tags$div(
      class = "container-fluid row p-3",
      tags$nav(
        class = "navbar col-2 flex-column justify-content-center align-items-center p-3 fs-4",
        tags$a(
          class = "navbar-brand fs-3",
          href = "#",
          "導覽"
        ),
        br(),
        tags$nav(
          class = "nav nav-pills flex-column",
          tags$a(
            class = "nav-link",
            href = "#",
            "認識數據"
          ),
          tags$a(
            class = "nav-link",
            href = "#",
            "認識變量"
          ),
          tags$a(
            class = "nav-link",
            href = "#",
            "結果下載"
          )
        )
      ),
      tags$div(
        class = "col-10 p-3",
        `data-bs-spy` = "scroll",
        `data-bs-target` = "#",
        `data-bs-offset` = "0",
        tabindex = "0",
        tags$h4(
          class = "fs-3",
          style = "width: 80%; color: #404040;",
          "認識數據"
        ),
        br(),
        tags$p(
          class = "fs-4",
          style = "width: 80%; color: #404040;",
          "本站使用的數據，是由CGED-Q (1900-1912) 部分的數據整理得來的，其中僅保留了一些關鍵變量，並將部分變量進行了重新編碼。我們首先從這些數據中隨機抽取1000個條目，來初步了解下這組數據的樣子。"
        ),
        tags$p(
          class = "fs-4",
          style = "width: 80%; color: #404040;",
          "點擊下面按鈕來啓動響應式模塊，再點擊模塊中的“讀取樣本數據”按鈕，就可以得到含有樣本數據的表格。在該表格中，可以使用最上邊一行的搜索欄篩選特定的變量取值。"
        ),
        br(),
        tags$button(
          type = "button",
          class = "btn btn-primary fs-4",
          `data-bs-toggle` = "modal",
          `data-bs-target` = "#page-1-modal-1",
          "啓動模塊"
        ),
        tags$div(
          class = "modal fade",
          id = "page-1-modal-1",
          tabindex = "-1",
          `aria-labelledby` = "#page-1-exampleModalLabel-1",
          `aria-hidden` = "true",
          tags$div(
            class = "modal-dialog modal-fullscreen modal-dialog-centered modal-dialog-scrollable",
            tags$div(
              class = "modal-content",
              tags$div(
                class = "modal-header",
                tags$h5(
                  class = "modal-title",
                  id = "page-1-exampleModalLabel-1",
                  "認識數據",
                  tags$button(
                    type = "button",
                    class = "btn-close",
                    `data-bs-dismiss` = "modal",
                    `aria-label` = "Close"
                  )
                )
              ),
              tags$div(
                class = "modal-body",
                br(),
                actionBttn(
                  "Trigger1",
                  label = "讀取數據樣本",
                  icon = icon("file-import"),
                  style = "fill",
                  color = "primary",
                  size = "lg"
                ),
                br(),
                br(),
                DT::dataTableOutput("RawData", width = "100%") %>% withSpinner(size = 1.5, color="#0dc5c1")
              ),
              tags$div(
                class = "modal-footer",
                tags$button(
                  type = "button",
                  class = "btn btn-lg btn-secondary",
                  `data-bs-dismiss` = "modal",
                  "關閉"
                )
              )
            )
          )
        ),
        br(),
        br(),
        br(),
        tags$h4(
          class = "fs-3",
          style = "width: 80%; color: #404040;",
          "認識變量"
        ),
        br(),
        tags$p(
          class = "fs-4",
          style = "width: 80%; color: #404040;",
          "在大致看過數據後，我們來檢視每一個變量。點擊下方的按鈕來啓動響應式模塊，在模塊裏選擇不同的變量以查看他們的含義，可能的取值，和不同取值的分布。你也可以點擊下載按鈕將這個模塊中的結果下載到本地硬碟上。"
        ),
        br(),
        tags$button(
          type = "button",
          class = "btn btn-primary fs-4",
          `data-bs-toggle` = "modal",
          `data-bs-target` = "#page-1-modal-2",
          "啓動模塊"
        ),
        tags$div(
          class = "modal fade",
          id = "page-1-modal-2",
          tabindex = "-1",
          `aria-labelledby` = "#page-1-exampleModalLabel-2",
          `aria-hidden` = "true",
          tags$div(
            class = "modal-dialog modal-xl modal-dialog-centered modal-dialog-scrollable",
            tags$div(
              class = "modal-content",
              tags$div(
                class = "modal-header",
                tags$h5(
                  class = "modal-title",
                  id = "page-1-exampleModalLabel-2",
                  "認識變量",
                  tags$button(
                    type = "button",
                    class = "btn-close",
                    `data-bs-dismiss` = "modal",
                    `aria-label` = "Close"
                  )
                )
              ),
              tags$div(
                class = "modal-body",
                br(),
                tags$h5(
                  "下面是一條樣例數據："
                ),
                br(),
                fluidRow(
                  tableOutput("Example1") %>% withSpinner(size = 1, color="#0dc5c1")
                ),
                hr(),
                br(),
                sidebarLayout(
                  sidebarPanel(
                    radioButtons(
                      "Picks0",
                      p(strong(em("在左邊選擇不同的變量：")), style="color:coral;font-size:18px"),
                      choices = c("陽歷年份", "季節號", "姓氏", "名字", "身份二", "旗分一", "旗分二", "出身一", "地區", "機構一", "機構二", "官職", "銓選方式"),
                      selected = c("陽歷年份")
                    ),
                    br(),
                    br(),
                    downloadBttn(
                      "DataDownload2",
                      label = "下載表格",
                      style = "fill",
                      color = "success",
                      size = "lg"
                    ),
                    width = 4
                  ),
                  mainPanel(
                    tags$head(
                      tags$style(
                        "#Discriptions{color: steelblue; font-size: 22px; font-style: italic;}"
                      )
                    ),
                    tags$head(
                      tags$style(
                        "#Summaries{color: grey; font-size: 22px; font-style: italic;}"
                      )
                    ),
                    br(),
                    textOutput("Discriptions") %>% withSpinner(size = 1, color="#0dc5c1"),
                    br(),
                    br(),
                    tableOutput("Summaries") %>% withSpinner(size = 1, color="#0dc5c1")
                  )
                )
              ),
              tags$div(
                class = "modal-footer",
                tags$button(
                  type = "button",
                  class = "btn btn-lg btn-secondary",
                  `data-bs-dismiss` = "modal",
                  "關閉"
                )
              )
            )
          )
        ),
        br(),
        br(),
        br(),
        tags$h4(
          class = "fs-3",
          style = "width: 80%; color: #404040;",
          "結果下載"
        ),
        br(),
        tags$p(
          class = "fs-4",
          style = "width: 80%; color: #404040;",
          "在本站中，所有根據用戶輸入而實時得出的結果都可以進行下載，不同形式的結果，如表格，圖片等，都會按照默認的設置下載成不同格式的文件，如表格結果則會下載爲Excel表，圖片結果就會下載成IMG或PNG文件，如果一頁上有多個結果，那麼在下載的時候這些結果便會被自動整合到一個PDF文件中，再下載到硬碟上。"
        ),
        tags$p(
          class = "fs-4",
          style = "width: 80%; color: #404040;",
          "點擊下面的按鈕，下載上面生成的樣本數據。"
        ),
        br(),
        downloadBttn(
          "DataDownload1",
          label = "下載數據",
          style = "fill",
          color = "success",
          size = "lg"
        )
      )
    ),
    br(),
    hr(),
    br(),
    br(),
    tags$div(
      class = "d-flex justify-content-center align-items-center",
      tags$h2(
        "設計與開發："
      ),
      tags$a(
        href = "https://github.com/CharlieLiu-HK",
        target = "_blank",
        tags$img(
          src = "images/signature.png",
          alt="劉俊德"
        )
      )
    ),
    br(),
    br()
  )
)

variable_distribution <- tags$div(
  tags$div(
    class = "container-fluid",
    style = "background-image: linear-gradient(#FFF5EB, #DEEDF0, #F4C7AB, #B2B8A3)",
    br(),
    tags$h1(
      class = "d-flex justify-content-around fs-1",
      tags$span(
        class = "badge rounded-pill bg-primary",
        "探索變量的分布"
      )
    ),
    br(),
    hr(),
    tags$div(
      class = "container-fluid row p-3",
      tags$nav(
        class = "navbar col-2 flex-column justify-content-center align-items-center p-3 fs-4",
        tags$a(
          class = "navbar-brand fs-3",
          href = "#",
          "導覽"
        ),
        br(),
        tags$nav(
          class = "nav nav-pills flex-column",
          tags$a(
            class = "nav-link",
            href = "#",
            "分布圖",
            tags$nav(
              class = "nav nav-pills flex-column",
              tags$a(
                class = "nav-link ms-3 my-1",
                href = "#",
                "生成圖表"
              ),
              tags$a(
                class = "nav-link ms-3 my-1",
                href = "#",
                "下載結果"
              )
            )
          ),
          br(),
          tags$a(
            class = "nav-link",
            href = "#",
            "統計表",
            tags$nav(
              class = "nav nav-pills flex-column",
              tags$a(
                class = "nav-link ms-3 my-1",
                href = "#",
                "生成圖表"
              ),
              tags$a(
                class = "nav-link ms-3 my-1",
                href = "#",
                "下載結果"
              )
            )
          )
        )
      ),
      tags$div(
        class = "col-10 p-3", 
        `data-bs-spy` = "scroll",
        `data-bs-target` = "#",
        `data-bs-offset` = "0",
        tabindex = "0",
        br(),
        tags$h4(
          class = "fs-3",
          "分布圖"
        ),
        br(),
        tags$p(
          class = "fs-4",
          "在上一個板塊，我們了解了數據中有哪些變量，以及各變量的含义和可能的取值，下面，我們首先使用繪制分布圖的方法來研究一下各變量取值的分布。"
        ),
        br(),
        tags$h4(
          class = "fs-3",
          "生成圖表"
        ),
        br(),
        tags$p(
          class = "fs-4",
          "首先，申明要如何繪制分布圖，點擊下面的按鈕，啓動響應式模塊，點擊其中的“設定參數”按鈕，設定分布圖的參數，你可以選擇繪制一個變量、兩個變量，或者三個變量的分布圖；使用下面的滑杆，你也可以選擇使用特定年份的數據來繪圖（無特別說明的話默認使用的是1900年到1912年的全部數據）。設定參數後，點擊“生成圖表”按鈕以顯示統計圖。"
        ),
        br(),
        tags$button(
          type = "button",
          class = "btn btn-primary fs-4",
          `data-bs-toggle` = "modal",
          `data-bs-target` = "#page-2-modal-1",
          "啓動模塊"
        ),
        tags$div(
          class = "modal fade",
          id = "page-2-modal-1",
          tabindex = "-1",
          `aria-labelledby` = "#page-2-exampleModalLabel-1",
          `aria-hidden` = "true",
          tags$div(
            class = "modal-dialog modal-fullscreen modal-dialog-centered modal-dialog-scrollable",
            tags$div(
              class = "modal-content",
              tags$div(
                class = "modal-header",
                tags$h5(
                  class = "modal-title",
                  id = "page-2-exampleModalLabel-1",
                  "生成圖表",
                  tags$button(
                    type = "button",
                    class = "btn-close",
                    `data-bs-dismiss` = "modal",
                    `aria-label` = "Close"
                  )
                )
              ),
              tags$div(
                class = "modal-body",
                br(),
                dropdown(
                  p(strong(em("選擇用來繪圖的變量：")),
                    style="color:coral;font-size:19px"
                  ),
                  selectInput(
                    "Picks1", "變量一：",
                    choices = c("身份二", "旗分一", "旗分二", "出身一", "地區", "銓選方式"),
                    selected = "旗分二"
                  ),
                  selectInput(
                    "Picks2", "變量二：",
                    choices = c("身份二", "旗分一", "旗分二", "出身一", "地區", "銓選方式", "不选择"),
                    selected = "出身一"
                  ),
                  selectInput(
                    "Picks3", "變量三：",
                    choices = c("身份二", "旗分一", "旗分二", "出身一", "地區", "銓選方式", "不选择"),
                    selected = "地區"
                  ),
                  sliderTextInput(
                    inputId = "YearPicks1",
                    label = "選擇使用哪些年的數據來繪圖：",
                    choices = 1900:1912,
                    selected = c(1900, 1912),
                    grid = T
                  ),
                  label = "設定參數",
                  icon = icon("delicious"),
                  style = "fill",
                  status = "danger",
                  size = "lg"
                ),
                br(),
                br(),
                actionBttn(
                  "Trigger2",
                  label = "生成圖表",
                  icon = icon("file-import"),
                  style = "fill",
                  color = "primary",
                  size = "lg"
                ),
                br(),
                br(),
                uiOutput("UI2")
              ),
              tags$div(
                class = "modal-footer",
                tags$button(
                  type = "button",
                  class = "btn btn-lg btn-secondary",
                  `data-bs-dismiss` = "modal",
                  "關閉"
                )
              )
            )
          )
        ),
        br(),
        br(),
        br(),
        tags$h4(
          class = "fs-3",
          "下載結果"
        ),
        br(),
        tags$p(
          class = "fs-4",
          "點擊下面的按鈕，可以將上面生成的統計圖下載到本地硬碟上。"
        ),
        br(),
        downloadBttn(
          "DataDownload3",
          label = "下載圖表",
          style = "fill",
          color = "success",
          size = "lg"
        ),
        br(),
        br(),
        br(),
        hr(),
        br(),
        br(),
        tags$h4(
          class = "fs-3",
          "統計表"
        ),
        br(),
        tags$p(
          class = "fs-4",
          "承接上一個模塊的統計圖，在本模塊，你可以實時生成統計表來觀察各變量不同取值的分布。"
        ),
        br(),
        tags$h4(
          class = "fs-3",
          "生成圖表"
        ),
        br(),
        tags$p(
          class = "fs-4",
          "首先，申明要如何生成統計表，點擊下面的按鈕，啓動響應式模塊，點擊其中的“設定參數”按鈕，設定統計表的參數，你可以選擇一個變量，將所有的數據根據這個變量的取值進行分組；使用下面的滑杆，你也可以選擇使用特定年份的數據來生成表（無特別說明的話默認使用的是1900年到1912年的全部數據）。設定參數後，點擊“生成圖表”按鈕以顯示統計表。"
        ),
        br(),
        tags$button(
          type = "button",
          class = "btn btn-primary fs-4",
          `data-bs-toggle` = "modal",
          `data-bs-target` = "#page-2-modal-2",
          "啓動模塊"
        ),
        tags$div(
          class = "modal fade",
          id = "page-2-modal-2",
          tabindex = "-1",
          `aria-labelledby` = "#page-2-exampleModalLabel-2",
          `aria-hidden` = "true",
          tags$div(
            class = "modal-dialog modal-fullscreen modal-dialog-centered modal-dialog-scrollable",
            tags$div(
              class = "modal-content",
              tags$div(
                class = "modal-header",
                tags$h5(
                  class = "modal-title",
                  id = "page-2-exampleModalLabel-2",
                  "生成圖表",
                  tags$button(
                    type = "button",
                    class = "btn-close",
                    `data-bs-dismiss` = "modal",
                    `aria-label` = "Close"
                  )
                )
              ),
              tags$div(
                class = "modal-body",
                br(),
                dropdown(
                  radioButtons(
                    "Picks4",
                    p(strong(em("選擇一個變量對數據進行編組：")), style="color:coral;font-size:18px"),
                    choices = c("旗分二", "出身一", "地區"),
                    selected = "出身一"
                  ),
                  sliderTextInput(
                    inputId = "YearPicks2",
                    label = "選擇使用哪個年份的數據生成統計表：",
                    choices = 1900:1912,
                    selected = c(1900, 1912),
                    grid = T
                  ),
                  label = "設定參數",
                  icon = icon("delicious"),
                  style = "fill",
                  status = "danger",
                  size = "lg"
                ),
                br(),
                br(),
                actionBttn(
                  "Trigger3",
                  label = "生成圖表",
                  icon = icon("file-import"),
                  style = "fill",
                  color = "primary",
                  size = "lg"
                ),
                br(),
                br(),
                uiOutput("UI3")
              ),
              tags$div(
                class = "modal-footer",
                tags$button(
                  type = "button",
                  class = "btn btn-lg btn-secondary",
                  `data-bs-dismiss` = "modal",
                  "關閉"
                )
              )
            )
          )
        ),
        br(),
        br(),
        br(),
        tags$h4(
          class = "fs-3",
          "下載結果"
        ),
        br(),
        tags$p(
          class = "fs-4",
          "點擊下面的按鈕，可以將上面生成的統計表下載到本地硬碟上。"
        ),
        br(),
        downloadBttn(
          "DataDownload4",
          label = "下載圖表",
          style = "fill",
          color = "success",
          size = "lg"
        ),
        br()
      )
    ),
    br(),
    hr(),
    br(),
    br(),
    tags$div(
      class = "d-flex justify-content-center align-items-center",
      tags$h2(
        "設計與開發："
      ),
      tags$a(
        href = "https://github.com/CharlieLiu-HK",
        target = "_blank",
        tags$img(
          src = "images/signature.png",
          alt="劉俊德"
        )
      )
    ),
    br(),
    br()
  )
)

variable_correlation <- tags$div(
  tags$div(
    class = "container-fluid",
    style = "background-image: linear-gradient(#FFF5EB, #DEEDF0, #F4C7AB, #B2B8A3)",
    br(),
    tags$h1(
      class = "d-flex justify-content-around fs-1",
      tags$span(
        class = "badge rounded-pill bg-primary",
        "探索變量間的關系"
      )
    ),
    br(),
    hr(),
    tags$div(
      class = "container-fluid row p-3",
      tags$nav(
        class = "navbar col-2 flex-column justify-content-center align-items-center p-3 fs-4",
        tags$a(
          class = "navbar-brand fs-3",
          href = "#",
          "導覽"
        ),
        br(),
        tags$nav(
          class = "nav nav-pills flex-column",
          tags$a(
            class = "nav-link",
            href = "#",
            "多重共變分析",
            tags$nav(
              class = "nav nav-pills flex-column",
              tags$a(
                class = "nav-link ms-3 my-1",
                href = "#",
                "生成圖表"
              ),
              tags$a(
                class = "nav-link ms-3 my-1",
                href = "#",
                "下載結果"
              )
            )
          ),
          br(),
          tags$a(
            class = "nav-link",
            href = "#",
            "列聯表",
            tags$nav(
              class = "nav nav-pills flex-column",
              tags$a(
                class = "nav-link ms-3 my-1",
                href = "#",
                "生成圖表"
              ),
              tags$a(
                class = "nav-link ms-3 my-1",
                href = "#",
                "下載結果"
              )
            )
          ),
          br(),
          tags$a(
            class = "nav-link",
            href = "#",
            "馬賽克圖",
            tags$nav(
              class = "nav nav-pills flex-column",
              tags$a(
                class = "nav-link ms-3 my-1",
                href = "#",
                "生成圖表"
              ),
              tags$a(
                class = "nav-link ms-3 my-1",
                href = "#",
                "下載結果"
              )
            )
          ),
          br(),
          tags$a(
            class = "nav-link",
            href = "#",
            "卡方測定",
            tags$nav(
              class = "nav nav-pills flex-column",
              tags$a(
                class = "nav-link ms-3 my-1",
                href = "#",
                "生成圖表"
              ),
              tags$a(
                class = "nav-link ms-3 my-1",
                href = "#",
                "下載結果"
              )
            )
          )
        )
      ),
      tags$div(
        class = "col-10 p-3", 
        `data-bs-spy` = "scroll",
        `data-bs-target` = "#",
        `data-bs-offset` = "0",
        tabindex = "0",
        br(),
        tags$h4(
          class = "fs-3",
          "多重共變分析"
        ),
        br(),
        tags$p(
          class = "fs-4",
          "在上一個板塊，我們了解了各變量取值的分佈，也觀察到了一些變量之間的相互關係，下面，我們將使用統計學手段，更直觀地量化不同變量間的聯繫。"
        ),
        br(),
        tags$h4(
          class = "fs-3",
          "生成圖表"
        ),
        br(),
        tags$p(
          class = "fs-4",
          "首先，要申明如何進行多共變量分析，點擊下面按鈕，啟動響應式模塊，點擊其中“設定參數”的按鈕，選擇要將哪些變量包括在最終的分析中，也可以使用下面的滑桿，來選擇使用哪一些年份的數據來繪圖，設定參數後，點擊“生成圖表”按鈕來顯示結果。"
        ),
        br(),
        tags$button(
          type = "button",
          class = "btn btn-primary fs-4",
          `data-bs-toggle` = "modal",
          `data-bs-target` = "#page-3-modal-1",
          "啓動模塊"
        ),
        tags$div(
          class = "modal fade",
          id = "page-3-modal-1",
          tabindex = "-1",
          `aria-labelledby` = "#page-3-exampleModalLabel-1",
          `aria-hidden` = "true",
          tags$div(
            class = "modal-dialog modal-fullscreen modal-dialog-centered modal-dialog-scrollable",
            tags$div(
              class = "modal-content",
              tags$div(
                class = "modal-header",
                tags$h5(
                  class = "modal-title",
                  id = "page-3-exampleModalLabel-1",
                  "生成圖表",
                  tags$button(
                    type = "button",
                    class = "btn-close",
                    `data-bs-dismiss` = "modal",
                    `aria-label` = "Close"
                  )
                )
              ),
              tags$div(
                class = "modal-body",
                br(),
                dropdown(
                  checkboxGroupInput(
                    "Picks7",
                    label = p(strong(em("選擇要用哪些變量來進行多重共變分析：")), style="color:coral;font-size:19px"),
                    choices = c("身份二", "旗分一", "旗分二", "出身一", "地區", "銓選方式"),
                    selected = c("身份二", "旗分一", "旗分二", "出身一", "地區"),
                    inline = F
                  ),
                  selectInput(
                    "Picks8",
                    p(strong(em("選擇要用哪個圖像來檢視多重共變分析的吻合度：")), style="color:coral;font-size:19px"),
                    choices = c("篩選圖" = 1, "'Cos2' 多維度圖" = 2, "'Cos2' 第一維度圖" = 3, "'Cos2' 第二維度圖" = 4),
                    selected = "篩選圖"
                  ),
                  sliderTextInput(
                    inputId = "YearPicks3",
                    label = "選擇要使用哪些年的數據來進行多重共變分析：",
                    choices = 1900:1912,
                    selected = c(1900, 1912),
                    grid = T
                  ),
                  label = "設定參數",
                  icon = icon("delicious"),
                  style = "fill",
                  status = "danger",
                  size = "lg"
                ),
                br(),
                br(),
                actionBttn(
                  "Trigger4",
                  label = "顯示圖表",
                  icon = icon("file-import"),
                  style = "fill",
                  color = "primary",
                  size = "lg"
                ),
                br(),
                br(),
                uiOutput("UI4")
              ),
              tags$div(
                class = "modal-footer",
                tags$button(
                  type = "button",
                  class = "btn btn-lg btn-secondary",
                  `data-bs-dismiss` = "modal",
                  "關閉"
                )
              )
            )
          )
        ),
        br(),
        br(),
        br(),
        tags$h4(
          class = "fs-3",
          "下載結果"
        ),
        br(),
        tags$p(
          class = "fs-4",
          "點擊下面的按鈕，可以將上面生成的結果整合到一個PDF文件中，再下載到本地硬碟上。"
        ),
        br(),
        downloadBttn(
          "DataDownload5",
          label = "下載圖表",
          style = "fill",
          color = "success",
          size = "lg"
        ),
        br(),
        br(),
        br(),
        hr(),
        br(),
        br(),
        tags$h4(
          class = "fs-3",
          "列聯表"
        ),
        br(),
        tags$p(
          class = "fs-4",
          "在上一個多共變量分析的模塊中，你可能注意到了一些相關性很強的變量，在這個模塊，使用列聯表，你可以將不同的變量整合到一個表格中，觀察數據的分佈。"
        ),
        br(),
        tags$h4(
          class = "fs-3",
          "生成圖表"
        ),
        br(),
        tags$p(
          class = "fs-4",
          "首先，要申明如何生成列聯表，點擊下面的按鈕，啟動響應式模塊，點擊其中的設定參數按鈕，你可以選擇兩個，三個，或多個變量進行整合，從而生成列聯表，你也可以使用下面的滑桿，來選擇使用哪一些年份的數據來繪圖。在設定參數後，點擊生成圖表按鈕來查看結果。"
        ),
        br(),
        tags$button(
          type = "button",
          class = "btn btn-primary fs-4",
          `data-bs-toggle` = "modal",
          `data-bs-target` = "#page-3-modal-2",
          "啓動模塊"
        ),
        tags$div(
          class = "modal fade",
          id = "page-3-modal-2",
          tabindex = "-1",
          `aria-labelledby` = "#page-3-exampleModalLabel-2",
          `aria-hidden` = "true",
          tags$div(
            class = "modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable",
            tags$div(
              class = "modal-content",
              tags$div(
                class = "modal-header",
                tags$h5(
                  class = "modal-title",
                  id = "page-3-exampleModalLabel-2",
                  "生成圖表",
                  tags$button(
                    type = "button",
                    class = "btn-close",
                    `data-bs-dismiss` = "modal",
                    `aria-label` = "Close"
                  )
                )
              ),
              tags$div(
                class = "modal-body",
                br(),
                dropdown(
                  checkboxGroupInput(
                    "Picks5",
                    p(strong(em("選擇兩個或多個變量來生成統計表:")), style="color:coral;font-size:19px"),
                    choices = c("地區", "旗分二", "身份二", "旗分一", "銓選方式", "出身一"),
                    selected = c("旗分二", "身份二", "出身一")
                  ),
                  sliderTextInput(
                    inputId = "YearPicks4",
                    label = "選擇使用哪些年份的數據來生成統計表：",
                    choices = 1900:1912,
                    selected = c(1900, 1912),
                    grid = T
                  ),
                  label = "設定參數",
                  icon = icon("delicious"),
                  style = "fill",
                  status = "danger",
                  size = "lg"
                ),
                br(),
                br(),
                actionBttn(
                  "Trigger5",
                  label = "顯示圖表",
                  icon = icon("file-import"),
                  style = "fill",
                  color = "primary",
                  size = "lg"
                ),
                br(),
                br(),
                uiOutput("UI5")
              ),
              tags$div(
                class = "modal-footer",
                tags$button(
                  type = "button",
                  class = "btn btn-lg btn-secondary",
                  `data-bs-dismiss` = "modal",
                  "關閉"
                )
              )
            )
          )
        ),
        br(),
        br(),
        br(),
        tags$h4(
          class = "fs-3",
          "下載結果"
        ),
        br(),
        tags$p(
          class = "fs-4",
          "點擊下面的按鈕，可以將上面生成的列聯表下載到本地硬碟上。"
        ),
        br(),
        downloadBttn(
          "DataDownload6",
          label = "下載圖表",
          style = "fill",
          color = "success",
          size = "lg"
        ),
        br(),
        br(),
        br(),
        hr(),
        br(),
        br(),
        tags$h4(
          class = "fs-3",
          "馬賽克圖"
        ),
        br(),
        tags$p(
          class = "fs-4",
          "馬賽克圖可以將列聯表的結果以繪圖的方法呈現，使其更直觀，易懂。"
        ),
        br(),
        tags$h4(
          class = "fs-3",
          "生成圖表"
        ),
        br(),
        tags$p(
          class = "fs-4",
          "首先，要申明如何繪製馬賽克圖，點擊下面的按鈕，啟動響應式模塊，點擊其中的設定參數按鈕，你可以選擇繪製含有一個，兩個或三個變量的馬賽克圖，你也可以使用下面的滑桿，來選擇使用哪一些年份的數據來繪圖。設定參數後，點擊生成圖表來獲取結果。"
        ),
        br(),
        tags$button(
          type = "button",
          class = "btn btn-primary fs-4",
          `data-bs-toggle` = "modal",
          `data-bs-target` = "#page-3-modal-3",
          "啓動模塊"
        ),
        tags$div(
          class = "modal fade",
          id = "page-3-modal-3",
          tabindex = "-1",
          `aria-labelledby` = "#page-3-exampleModalLabel-3",
          `aria-hidden` = "true",
          tags$div(
            class = "modal-dialog modal-fullscreen modal-dialog-centered modal-dialog-scrollable",
            tags$div(
              class = "modal-content",
              tags$div(
                class = "modal-header",
                tags$h5(
                  class = "modal-title",
                  id = "page-3-exampleModalLabel-3",
                  "生成圖表",
                  tags$button(
                    type = "button",
                    class = "btn-close",
                    `data-bs-dismiss` = "modal",
                    `aria-label` = "Close"
                  )
                )
              ),
              tags$div(
                class = "modal-body",
                br(),
                dropdown(
                  p(strong(em("選擇用來繪制馬賽克圖的變量：")),
                    style="color:coral;font-size:19px"
                  ),
                  selectInput(
                    "PicksM1", "變量一：",
                    choices = c("地區" = "Region", "旗分二" = "BannerTwo", "身份二" = "Qualification", "旗分一" = "BannerOne", "銓選方式" = "Manner", "出身一" = "Ethnicity"),
                    selected = "Qualification"
                  ),
                  selectInput(
                    "PicksM2", "變量二：",
                    choices = c("地區" = "Region", "旗分二" = "BannerTwo", "身份二" = "Qualification", "旗分一" = "BannerOne", "銓選方式" = "Manner", "出身一" = "Ethnicity", "未選擇"),
                    selected = "BannerTwo"
                  ),
                  selectInput(
                    "PicksM3", "變量三：",
                    choices = c("地區" = "Region", "旗分二" = "BannerTwo", "身份二" = "Qualification", "旗分一" = "BannerOne", "銓選方式" = "Manner", "出身一" = "Ethnicity", "未選擇"),
                    selected = "Region"
                  ),
                  sliderTextInput(
                    inputId = "YearPicks5",
                    label = "選擇使用哪一個年份的數據來繪製馬賽克圖：",
                    choices = 1900:1912,
                    selected = c(1900, 1912),
                    grid = T
                  ),
                  label = "設定參數",
                  icon = icon("delicious"),
                  style = "fill",
                  status = "danger",
                  size = "lg"
                ),
                br(),
                br(),
                actionBttn(
                  "Trigger6",
                  label = "生成圖表",
                  icon = icon("file-import"),
                  style = "fill",
                  color = "primary",
                  size = "lg"
                ),
                br(),
                br(),
                uiOutput("UI6")
              ),
              tags$div(
                class = "modal-footer",
                tags$button(
                  type = "button",
                  class = "btn btn-lg btn-secondary",
                  `data-bs-dismiss` = "modal",
                  "關閉"
                )
              )
            )
          )
        ),
        br(),
        br(),
        br(),
        tags$h4(
          class = "fs-3",
          "下載結果"
        ),
        br(),
        tags$p(
          class = "fs-4",
          "點擊下面的按鈕，可以將上面生成的馬賽克圖下載到本地硬碟上。"
        ),
        br(),
        downloadBttn(
          "DataDownload7",
          label = "下載圖表",
          style = "fill",
          color = "success",
          size = "lg"
        ),
        br(),
        br(),
        br(),
        hr(),
        br(),
        br(),
        tags$h4(
          class = "fs-3",
          "卡方測定"
        ),
        br(),
        tags$p(
          class = "fs-4",
          "使用上面的諸多工具，我們可以檢驗變量的分佈和變量間的關係，但是，兩個變量是否相關，還要經過嚴格的統計學測定才可以確定，分類變量間的相關性，主要可以使用卡方測定來檢測，詳情見下。"
        ),
        br(),
        tags$h4(
          class = "fs-3",
          "生成圖表"
        ),
        br(),
        tags$p(
          class = "fs-4",
          "首先，要申明如何進行卡方測定，點擊下面按鈕，啟動響應式模塊，點擊其中“設定參數”的按鈕，選擇要將對哪兩個變量進行測定，使用下面的滑桿，你也可以選擇不同年份的數據進行檢測。設定參數後，點擊“生成圖表”按鈕來顯示結果。"
        ),
        br(),
        tags$button(
          type = "button",
          class = "btn btn-primary fs-4",
          `data-bs-toggle` = "modal",
          `data-bs-target` = "#page-3-modal-4",
          "啓動模塊"
        ),
        tags$div(
          class = "modal fade",
          id = "page-3-modal-4",
          tabindex = "-1",
          `aria-labelledby` = "#page-3-exampleModalLabel-4",
          `aria-hidden` = "true",
          tags$div(
            class = "modal-dialog modal-fullscreen modal-dialog-centered modal-dialog-scrollable",
            tags$div(
              class = "modal-content",
              tags$div(
                class = "modal-header",
                tags$h5(
                  class = "modal-title",
                  id = "page-3-exampleModalLabel-4",
                  "生成圖表",
                  tags$button(
                    type = "button",
                    class = "btn-close",
                    `data-bs-dismiss` = "modal",
                    `aria-label` = "Close"
                  )
                )
              ),
              tags$div(
                class = "modal-body",
                br(),
                dropdown(
                  p(strong(em("選擇兩個變量來進行卡方檢定:")),
                    style="color:coral;font-size:19px"
                  ),
                  selectInput(
                    "Chi-Vars",
                    "（由於卡方檢定只接受兩個變量，選取任何其他數量的變量會導致錯誤。）",
                    choices =  c("地區", "身份二", "旗分一", "銓選方式", "出身一", "旗分二"),
                    selected = c("地區", "身份二"),
                    multiple = T
                  ),
                  sliderTextInput(
                    inputId = "YearPicks6",
                    label = "選擇使用哪些年的數據來進行卡方檢定：",
                    choices = 1900:1912,
                    selected = c(1900, 1912),
                    grid = T
                  ),
                  label = "設定參數",
                  icon = icon("delicious"),
                  style = "fill",
                  status = "danger",
                  size = "lg"
                ),
                br(),
                br(),
                actionBttn(
                  "Trigger7",
                  label = "生成圖表",
                  icon = icon("file-import"),
                  style = "fill",
                  color = "primary",
                  size = "lg"
                ),
                br(),
                br(),
                uiOutput("UI7")
              ),
              tags$div(
                class = "modal-footer",
                tags$button(
                  type = "button",
                  class = "btn btn-lg btn-secondary",
                  `data-bs-dismiss` = "modal",
                  "關閉"
                )
              )
            )
          )
        ),
        br(),
        br(),
        br(),
        tags$h4(
          class = "fs-3",
          "下載結果"
        ),
        br(),
        tags$p(
          class = "fs-4",
          "點擊下面的按鈕，可以將上面生成的結果重新整合編輯成一個新的PDF文檔，下載到本地硬碟上。"
        ),
        br(),
        downloadBttn(
          "DataDownload8",
          label = "下載圖表",
          style = "fill",
          color = "success",
          size = "lg"
        ),
        br(),
        br(),
        br()
      )
    ),
    br(),
    hr(),
    br(),
    br(),
    tags$div(
      class = "d-flex justify-content-center align-items-center",
      tags$h2(
        "設計與開發："
      ),
      tags$a(
        href = "https://github.com/CharlieLiu-HK",
        target = "_blank",
        tags$img(
          src = "images/signature.png",
          alt="劉俊德"
        )
      )
    ),
    br(),
    br()
  )
)

trend_analysis <- tags$div(
  tags$div(
    class = "container-fluid",
    style = "background-image: linear-gradient(#FFF5EB, #DEEDF0, #F4C7AB, #B2B8A3)",
    br(),
    tags$h1(
      class = "d-flex justify-content-around fs-1",
      tags$span(
        class = "badge rounded-pill bg-primary",
        "趨勢分析"
      )
    ),
    br(),
    hr(),
    tags$div(
      class = "container-fluid row p-3",
      tags$nav(
        class = "navbar col-2 flex-column justify-content-center align-items-center p-3 fs-4",
        tags$a(
          class = "navbar-brand fs-3",
          href = "#",
          "導覽"
        ),
        br(),
        tags$nav(
          class = "nav nav-pills flex-column",
          tags$a(
            class = "nav-link",
            href = "#",
            "趨勢圖",
            tags$nav(
              class = "nav nav-pills flex-column",
              tags$a(
                class = "nav-link ms-3 my-1",
                href = "#",
                "生成圖表"
              ),
              tags$a(
                class = "nav-link ms-3 my-1",
                href = "#",
                "下載結果"
              )
            )
          ),
          br(),
          tags$a(
            class = "nav-link",
            href = "#",
            "時間序列分析",
            tags$nav(
              class = "nav nav-pills flex-column",
              tags$a(
                class = "nav-link ms-3 my-1",
                href = "#",
                "生成圖表"
              ),
              tags$a(
                class = "nav-link ms-3 my-1",
                href = "#",
                "下載結果"
              )
            )
          )
        )
      ),
      tags$div(
        class = "col-10 p-3", 
        `data-bs-spy` = "scroll",
        `data-bs-target` = "#",
        `data-bs-offset` = "0",
        tabindex = "0",
        br(),
        tags$h4(
          class = "fs-3",
          "趨勢分析"
        ),
        br(),
        tags$p(
          class = "fs-4",
          "本站使用的數據涵蓋從1900年到1912年所有縉紳錄條目，在這個模塊裏，你可以使用繪圖的方式，觀察各變量分布在不同年份間的變化，從而進一步了解晚清政府在結構上的變化。"
        ),
        br(),
        tags$h4(
          class = "fs-3",
          "生成圖表"
        ),
        br(),
        tags$p(
          class = "fs-4",
          "首先，申明要如何繪制趨勢圖，點擊下面的按鈕，啓動響應式模塊，點擊其中的“設定參數”按鈕，設定趨勢圖的參數，你可以選擇一個或者兩個變量進行繪圖；你也可以選擇使用全部或某一部分（中央政府/地方政府）的數據來進行繪圖；使用下面的滑杆，你也可以選擇使用特定年份的數據來繪圖（無特別說明的話默認使用的是1900年到1912年的全部數據）。設定參數後，點擊“生成圖表”按鈕以顯示趨勢圖。"
        ),
        br(),
        tags$button(
          type = "button",
          class = "btn btn-primary fs-4",
          `data-bs-toggle` = "modal",
          `data-bs-target` = "#page-4-modal-1",
          "啓動模塊"
        ),
        tags$div(
          class = "modal fade",
          id = "page-4-modal-1",
          tabindex = "-1",
          `aria-labelledby` = "#page-4-exampleModalLabel-1",
          `aria-hidden` = "true",
          tags$div(
            class = "modal-dialog modal-fullscreen modal-dialog-centered modal-dialog-scrollable",
            tags$div(
              class = "modal-content",
              tags$div(
                class = "modal-header",
                tags$h5(
                  class = "modal-title",
                  id = "page-4-exampleModalLabel-1",
                  "生成圖表",
                  tags$button(
                    type = "button",
                    class = "btn-close",
                    `data-bs-dismiss` = "modal",
                    `aria-label` = "Close"
                  )
                )
              ),
              tags$div(
                class = "modal-body",
                br(),
                dropdown(
                  p(strong(em("選擇一個或兩個變量來繪製趨勢圖：")),
                    style="color:coral;font-size:19px"
                  ),
                  selectInput(
                    "PicksT1",
                    "變量一：",
                    choices =  c("地區", "身份二", "旗分一", "銓選方式", "出身一", "旗分二"),
                    selected = "旗分二"
                  ),
                  selectInput(
                    "PicksT2",
                    "變量二：",
                    choices =  c("地區", "身份二", "旗分一", "銓選方式", "出身一", "旗分二", "不選擇"),
                    selected = "地區"
                  ),
                  p(strong(em("選擇使用哪一部分的數據：")),
                    style="color:coral;font-size:19px"
                  ),
                  radioButtons(
                    "PicksT3",
                    p("你可以選擇供職於中央政府那一部分官員的數據，也可以選擇供職於地方政府那一部分的數據，或者是使用整個數據："),
                    choices = c("全部數據", "中央政府部分", "地方政府部分"),
                    selected = "全部數據"
                  ),
                  sliderTextInput(
                    inputId = "YearPicks7",
                    label = "選擇使用哪些年份的數據進行繪圖：",
                    choices = 1900:1912,
                    selected = c(1900, 1912),
                    grid = T
                  ),
                  label = "設定參數",
                  icon = icon("delicious"),
                  style = "fill",
                  status = "danger",
                  size = "lg"
                ),
                br(),
                br(),
                actionBttn(
                  "Trigger8",
                  label = "生成圖表",
                  icon = icon("file-import"),
                  style = "fill",
                  color = "primary",
                  size = "lg"
                ),
                br(),
                br(),
                uiOutput("UI8")
              ),
              tags$div(
                class = "modal-footer",
                tags$button(
                  type = "button",
                  class = "btn btn-lg btn-secondary",
                  `data-bs-dismiss` = "modal",
                  "關閉"
                )
              )
            )
          )
        ),
        br(),
        br(),
        br(),
        tags$h4(
          class = "fs-3",
          "下載結果"
        ),
        br(),
        downloadBttn(
          "DataDownload9",
          label = "下載圖表",
          style = "fill",
          color = "success",
          size = "lg"
        ),
        br(),
        br(),
        br(),
        hr(),
        br(),
        br(),
        tags$h4(
          class = "fs-3",
          "時間序列分析"
        ),
        br(),
        tags$p(
          class = "fs-4",
          "除了繪圖，時間序列分析也是研究趨勢的重要方法之一，詳情見下。"
        ),
        br(),
        tags$h4(
          class = "fs-3",
          "生成圖表"
        ),
        br(),
        tags$p(
          class = "fs-4",
          "首先，申明要如何生成分析圖，點擊下面的按鈕，啓動響應式模塊，點擊其中的“設定參數”按鈕，設定分析的參數，先選擇進行分析需要使用的變量；使用下面的滑杆，你也可以選擇使用特定年份的數據來生成表（無特別說明的話默認使用的是1900年到1912年的全部數據）。設定參數後，點擊“生成圖表”按鈕以顯示統計表。"
        ),
        br(),
        tags$button(
          type = "button",
          class = "btn btn-primary fs-4",
          `data-bs-toggle` = "modal",
          `data-bs-target` = "#page-4-modal-2",
          "啓動模塊"
        ),
        tags$div(
          class = "modal fade",
          id = "page-4-modal-2",
          tabindex = "-1",
          `aria-labelledby` = "#page-4-exampleModalLabel-2",
          `aria-hidden` = "true",
          tags$div(
            class = "modal-dialog modal-fullscreen modal-dialog-centered modal-dialog-scrollable",
            tags$div(
              class = "modal-content",
              tags$div(
                class = "modal-header",
                tags$h5(
                  class = "modal-title",
                  id = "page-4-exampleModalLabel-2",
                  "生成圖表",
                  tags$button(
                    type = "button",
                    class = "btn-close",
                    `data-bs-dismiss` = "modal",
                    `aria-label` = "Close"
                  )
                )
              ),
              tags$div(
                class = "modal-body",
                br(),
                dropdown(
                  p(strong(em("選擇使用哪個變量來進行時間序列分析：")),
                    style="color:coral;font-size:19px"
                  ),
                  radioButtons(
                    "PicksTS1",
                    label = NULL,
                    choices = c("地區", "身份二", "旗分一", "銓選方式", "出身一", "旗分二"),
                    selected = "出身一"
                  ),
                  sliderTextInput(
                    inputId = "YearPicks8",
                    label = "選擇使用哪些年份的數據來進行時間序列分析：",
                    choices = 1900:1912,
                    selected = c(1900, 1912),
                    grid = T
                  ),
                  label = "設定參數",
                  icon = icon("delicious"),
                  style = "fill",
                  status = "danger",
                  size = "lg"
                ),
                br(),
                br(),
                actionBttn(
                  "Trigger9",
                  label = "生成圖表",
                  icon = icon("file-import"),
                  style = "fill",
                  color = "primary",
                  size = "lg"
                ),
                br(),
                br(),
                uiOutput("UI9")
              ),
              tags$div(
                class = "modal-footer",
                tags$button(
                  type = "button",
                  class = "btn btn-lg btn-secondary",
                  `data-bs-dismiss` = "modal",
                  "關閉"
                )
              )
            )
          )
        ),
        br(),
        br(),
        br(),
        tags$h4(
          class = "fs-3",
          "下載結果"
        ),
        br(),
        tags$p(
          class = "fs-4",
          "點擊下面的按鈕，可以將上面生成的統計表下載到本地硬碟上。"
        ),
        br(),
        downloadBttn(
          "DataDownload10",
          label = "下載圖表",
          style = "fill",
          color = "success",
          size = "lg"
        ),
        br()
      )
    ),
    br(),
    hr(),
    br(),
    br(),
    tags$div(
      class = "d-flex justify-content-center align-items-center",
      tags$h2(
        "設計與開發："
      ),
      tags$a(
        href = "https://github.com/CharlieLiu-HK",
        target = "_blank",
        tags$img(
          src = "images/signature.png",
          alt="劉俊德"
        )
      )
    ),
    br(),
    br()
  )
)

page_router <- make_router(
  route("landing_page", landing_page),
  route("sample_data", sample_data),
  route("variable_distribution", variable_distribution),
  route("variable_correlation", variable_correlation),
  route("trend_analysis", trend_analysis)
)

new_data <- read.csv("www/final_data.csv", encoding = "UTF-8") %>% dplyr::select(!X)
new_data <- new_data %>% mutate(陽歷年份 = factor(陽歷年份, levels = c("1900", "1901", "1902", "1903", "1904", "1905", "1906", "1907", "1908", "1909", "1910", "1911", "1912")),
                                季節號 = factor(季節號, levels = c("1", "2", "3", "4")),
                                身份二 = factor(身份二, levels = c("無記錄", "其他", "漢", "漢軍", "蒙古", "滿洲")),
                                旗分一 = factor(旗分一, levels = c("無旗分", "其他", "鑲藍", "正藍", "鑲紅", "鑲白", "正紅", "正白", "正黃", "鑲黃")),
                                旗分二 = factor(旗分二, levels = c("旗人", "非旗人")),
                                出身一 = factor(出身一, levels = c("無記錄", "其他", "生員", "蔭生", "貢生", "翻譯", "吏員", "畢業生", "監生", "舉人", "進士")),
                                地區 = factor(地區, levels = c("京師", "地方")),
                                銓選方式 = factor(銓選方式, levels = c("無記錄", "其他", "選", "補", "調", "升", "授"))
                                )

showtext_auto()

report_path <- tempfile(fileext = ".Rmd")
file.copy("www/MCA Report.Rmd", report_path, overwrite = TRUE)
report_path2 <- tempfile(fileext = ".Rmd")
file.copy("www/Chi-Test Report.Rmd", report_path2, overwrite = TRUE)