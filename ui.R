ui <- tags$div(
  tags$head(
    tags$meta(charset = "UTF-8"),
    tags$meta(`http-equiv` = "X-UA-Compatible", content = "IE=edge"),
    tags$meta(name = "viewport", content = "width=device-width, initial-scale=1.0"),
    tags$meta(rel = "stylesheet", type = "text/css", href = "bootstrap.min.css"),
    tags$link(rel = "stylesheet", type = "text/css", href = "bootstrap.css"),
    tags$link(rel = "stylesheet", type = "text/css", href = "style.css"),
    includeHTML("google-analytics.html")
  ),
  tags$script(src = "bootstrap.min.js"),
  tags$script(src = "bootstrap.bundle.js"),
  tags$script(src = "script.js"),
  tags$nav(
    class = "navbar navbar-expand-lg navbar-light",
    style = "background-color: #fff2e6",
    tags$div(
      class = "container-fluid",
      tags$a(
        class = "navbar-brand fs-4",
        href = "#top",
        tags$img(
          src = "images/c.png",
          alt = "C",
          width = "35",
          height = "35",
          class = "d-inline align-middle"
        ),
        tags$img(
          src = "images/g.png",
          alt = "G",
          width = "35",
          height = "35",
          class = "d-inline align-middle"
        ),
        tags$img(
          src = "images/e.png",
          alt = "E",
          width = "35",
          height = "35",
          class = "d-inline align-middle"
        ),
        tags$img(
          src = "images/d.png",
          alt = "D",
          width = "35",
          height = "35",
          class = "d-inline align-middle"
        ),
        tags$img(
          src = "images/q.png",
          alt = "Q",
          width = "35",
          height = "35",
          class = "d-inline align-middle"
        ),
        tags$p(
          class = "d-inline align-middle",
          "(1900-1912) 數據瀏覽與分析工具"
        )
      ),
      tags$button(
        class = "navbar-toggler",
        type = "button",
        `data-bs-toggle` = "collapse",
        `data-bs-target` = "#navbarSupportedContent",
        `aria-controls` = "navbarSupportedContent",
        `aria-expanded` = "false",
        `aria-label` = "Toggle navigation",
        tags$span(
          class = "navbar-toggler-icon"
        )
      ),
      div(
        class = "collapse navbar-collapse",
        id = "navbarSupportedContent",
        tags$ul(
          class = "navbar-nav align-middle",
          tags$li(
            class = "nav-item fas-5",
            tags$p(
              style = "color: #fff2e6",
              "This is a placeholder for some whitespace."
            )
          ),
          tags$li(
            class = "nav-item dropdown fs-5",
            tags$a(
              class = "nav-link dropdown-toggle",
              href = "#top",
              id = "navbarDropdown",
              role = "button",
              `data-bs-toggle` = "dropdown",
              `aria-expanded` = "false",
              "關於數據"
            ),
            tags$ul(
              class = "dropdown-menu",
              `aria-labelledby` = "navbarDropdown",
              tags$li(
                tags$a(
                  class = "dropdown-item fs-5",
                  href = "https://www.shss.ust.hk/lee-campbell-group/",
                  target = "_blank",
                  "李康研究團隊主頁"
                )
              ),
              tags$li(
                class = "dropdown-divider"
              ),
              tags$li(
                tags$a(
                  class = "dropdown-item fs-5",
                  href = "https://www.shss.ust.hk/lee-campbell-group/projects/china-government-employee-database-qing-cged-q/",
                  target = "_blank",
                  "CGED-Q 項目介紹"
                )
              ),
              tags$li(
                class = "dropdown-divider"
              ),
              tags$li(
                tags$a(
                  class = "dropdown-item fs-5",
                  href = "http://vis.cse.ust.hk/searchjsl/",
                  target = "_blank",
                  "CGED-Q 官員條目搜索系統"
                )
              ),
              tags$li(
                class = "dropdown-divider"
              ),
              tags$li(
                tags$a(
                  class = "dropdown-item fs-5",
                  href = "https://www.cambridge.org/core/journals/journal-of-chinese-history/article/big-data-for-the-study-of-qing-officialdom-the-china-government-employee-databaseqing-cgedq/08012BBACCA482B19D7FE2724FDCC840",
                  target = "_blank",
                  "CGED-Q 相關出版物"
                )
              ),
              tags$li(
                class = "dropdown-divider"
              ),
              tags$li(
                tags$a(
                  class = "dropdown-item fs-5",
                  href = "https://dataspace.ust.hk/dataset.xhtml?persistentId=doi:10.14711/dataset/E9GKRS",
                  target = "_blank",
                  "CGED-Q (1900-1912) 香港下載（香港科技大學數據空間）"
                )
              ),
              tags$li(
                class = "dropdown-divider"
              ),
              tags$li(
                tags$a(
                  class = "dropdown-item fs-5",
                  href = "http://39.96.59.69/DownloadFile/DLFile",
                  target = "_blank",
                  "CGED-Q (1900-1912) 北京下載（中國人民大學數據共享平臺）"
                )
              ),
              tags$li(
                class = "dropdown-divider"
              ),
              tags$li(
                tags$a(
                  class = "dropdown-item fs-5",
                  href = "https://dataverse.harvard.edu/dataverse/leecampbellgroup",
                  target = "_blank",
                  "CGED-Q (1900-1912) 北美下載（美國哈佛大學數據空間）"
                )
              )
            )
          ),
          tags$li(
            class = "nav-item fs-5",
            tags$a(
              class = "nav-link active",
              `aria-current` = "page",
              href = route_link("sample_data"),
              target = "_blank",
              "認識數據與變量"
            )
          ),
          tags$li(
            class = "nav-item fs-5",
            tags$a(
              class = "nav-link active",
              `aria-current` = "page",
              href = route_link("variable_distribution"),
              target = "_blank",
              "探索變量的分布"
            )
          ),
          tags$li(
            class = "nav-item fs-5",
            tags$a(
              class = "nav-link active",
              `aria-current` = "page",
              href = route_link("variable_correlation"),
              target = "_blank",
              "探索變量間的關系"
            )
          ),
          tags$li(
            class = "nav-item fs-5",
            tags$a(
              class = "nav-link active",
              `aria-current` = "page",
              href = route_link("trend_analysis"),
              target = "_blank",
              "趨勢分析"
            )
          ),
          tags$li(
            class = "nav-item dropdown fs-5",
            tags$a(
              class = "btn btn-outline-info text-primary mx-5 fs-5",
              href = "https://github.com/CharlieLiu-HK/CGED-Q-Web-App",
              role = "button",
              target = "_blank",
              "查看網頁源碼"
            )
          )
        )
      )
    )
  ),
  page_router$ui
)