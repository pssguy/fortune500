

output$data <- DT::renderDataTable({
  
  
  fortune %>% 
    
    DT::datatable(rownames=FALSE)
})