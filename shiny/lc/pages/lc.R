


save("rfcf",file="rfcf.R")
plotly::plot_ly(rfcf,x=rfcf$month,color = rfcf$term)%>%  
  add_lines(y=rfcf$riskfree)