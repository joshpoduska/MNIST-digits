server <- function(input, output, session) {

  vals = reactiveValues(x=NULL, y=NULL)
  draw = reactiveVal(FALSE)
  result = reactiveVal(NULL)
  rendered = reactiveVal(NULL)

  output$model <- renderImage({
    filename <- normalizePath(file.path('model.png'))
    list(src = filename,
         width = 200,
         height = 500,
         align="right"
         )
  }, deleteFile = FALSE)
  
  output$NVIDIA <- renderImage({
    filename <- normalizePath(file.path('domino-nvidia.png'))
    list(src = filename,
         width = 320,
         height = 48,
         align="right"
    )
  }, deleteFile = FALSE)
  
  output$aws <- renderImage({
    filename <- normalizePath(file.path('domino-aws.png'))
    list(src = filename,
         width = 320,
         height = 55
    )
  }, deleteFile = FALSE)
  
  output$aws2 <- renderImage({
    filename <- normalizePath(file.path('domino-aws.png'))
    list(src = filename,
         width = 320,
         height = 55
    )
  }, deleteFile = FALSE)
  
  output$webapp <- renderImage({
    filename <- normalizePath(file.path('webapp.png'))
    list(src = filename,
         width = 580,
         height = 300
    )
  }, deleteFile = FALSE)
  
  output$apie <- renderImage({
    filename <- normalizePath(file.path('apie.png'))
    list(src = filename,
         width = 600,
         height = 90
    )
  }, deleteFile = FALSE)
  
  observeEvent(input$click, handlerExpr = {
    temp <- draw()
    draw(!temp)
    if(!draw()) {
      vals$x <- c(vals$x, NA)
      vals$y <- c(vals$y, NA)
    } 
  })
  
  # reset the plot on DEL click
  observeEvent(input$reset, handlerExpr = {
    vals$x <- NULL; vals$y <- NULL
    draw(FALSE)
    output$prediction <- renderText({ 
      ""
    })
  })
  
  # on hover, record.
  observeEvent(input$hover, {
    if (draw()) {
      vals$x <- c(vals$x, input$hover$x)
      vals$y <- c(vals$y, input$hover$y)
    }
  })
  
  # plot function to do the smoothing and resizing
  myplot = reactive({
    ggplot() + 
      geom_path(aes(x=vals$x, y=vals$y), size=input$mywidth, color="white", alpha=1) + 
      xlim(0, 28) + ylim(0,28) + theme_grey() %+replace% 
      theme(panel.background = element_rect(fill='black'), axis.line=element_blank(), 
            panel.grid = element_blank(), axis.text=element_blank(),
            axis.ticks=element_blank(), axis.title=element_blank(),legend.position="none")
  })
  
  # basic plot to be as quick as possible
  output$plot= renderPlot({
    plot(x=vals$x, y=vals$y, xlim=c(0, 28), ylim=c(0, 28), ylab="y", xlab="x", type="l", lwd=input$mywidth)
  })
  
  # resized and smoothed plot
  output$plot2828 = renderPlot({
    if (is.null(rendered())) {return(NULL)}
    plot(rendered())
  })
 
 
  observeEvent(input$predict, ignoreInit = TRUE, handlerExpr = {
    if (is.null(vals$x)) {
      output$prediction <- renderText({ 
        "ERROR - Draw a digit first"
      })
    } else {
      
      g=myplot()
      ggsave("out.png", g, width = 5, height = 5)
      
      source_python('pred_for_r.py')
      get_list('out.png')
      
    url <- "https://vip.domino.tech:443/models/5dbc6d32c9e77c0007cdf8a7/latest/model"
    response <- POST(
        url,
        authenticate("kkepcszUkQUnloiLqo0HMVyLDgR8E0YgcywxZVFFfapEOf0okltfgBpWuaKeQfKN", 
        "kkepcszUkQUnloiLqo0HMVyLDgR8E0YgcywxZVFFfapEOf0okltfgBpWuaKeQfKN", type = "basic"),
        body=toJSON(list(data=list(input_list = get_list('out.png'))), auto_unbox = TRUE),
        content_type("application/json")
        )
      
      pred0 <- paste(content(response)$result[[1]][[1]], round(content(response)$result[[1]][[2]],4), sep=': ')
      pred1 <- paste(content(response)$result[[2]][[1]], round(content(response)$result[[2]][[2]],4), sep=': ')
      pred2 <- paste(content(response)$result[[3]][[1]], round(content(response)$result[[3]][[2]],4), sep=': ')
      pred3 <- paste(content(response)$result[[4]][[1]], round(content(response)$result[[4]][[2]],4), sep=': ')
      pred4 <- paste(content(response)$result[[5]][[1]], round(content(response)$result[[5]][[2]],4), sep=': ')
      pred5 <- paste(content(response)$result[[6]][[1]], round(content(response)$result[[6]][[2]],4), sep=': ')
      pred6 <- paste(content(response)$result[[7]][[1]], round(content(response)$result[[7]][[2]],4), sep=': ')
      pred7 <- paste(content(response)$result[[8]][[1]], round(content(response)$result[[8]][[2]],4), sep=': ')
      pred8 <- paste(content(response)$result[[9]][[1]], round(content(response)$result[[9]][[2]],4), sep=': ')
      pred9 <- paste(content(response)$result[[10]][[1]], round(content(response)$result[[10]][[2]],4), sep=': ')
      preds <- paste(pred0, pred1, pred2, pred3, pred4, pred5, pred6, pred7, pred8, pred9, sep="<br>")
      
      output$prediction <- renderText({ 
        preds
      })
    }
  })
}

