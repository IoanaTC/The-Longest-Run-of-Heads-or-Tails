tosses.gen <- function(trials,prob){
  
  # generate values from a uniform distribution
  tosses <-runif(trials) #trials = number of observations desired
  
  # the length of the vector "faces" is equal to the number of tosses
  # will represent the result obtained with each throw (H or T)
  faces <- seq(1,length(tosses)) 
  
  # when we toss the coin we can get either heads which we will mark with 1 
  # or tails which we will mark with 0
  for (i in 1:length(tosses)){
    if (tosses[i]<=prob){ 
      faces[i] = 1}
    else faces[i] = 0
  }
  
  # we will use a "data.frame" type structure, initialized with NA, 
  # to store our future data
  mydata <- data.frame(matrix(data = NA,ncol=3,nrow=(length(faces))))
  colnames(mydata) <- c("face","id","longest_run")
  
  #the first column will represent the result of each coin toss (1 or 0)
  mydata[,1]<-faces  
  
  # we will use an ID number for each run
  # therefore that is what our second column will store
  id <- 1
  mydata[1,2] <- 1  # 1 is the start number (id)
  
  for (i in 2:length(faces)){
    
    f1 <- mydata[i-1,1]  #the previous result
    f2 <- mydata[i,1]    #the current result we are looking at
    
    #if they have the same value, they will receive the same id
    if (f1 == f2) mydata[i,2] <- id
    else {
      id <- id +1
      mydata[i,2] <- id}
  }
  
  # all_Runs will store the observed frequency of each id value, 
  # determining the exact run length for each run
  all_Runs <- table(mydata[,2])
  
  # the third column will represent the corresponding run length
  # for each unique value of id
  val<-2
  curr<-1
  mydata[1,3] <- all_Runs[curr]
  
  while(val <= length(mydata)){
    i1 <- mydata[val-1,2]
    i2 <- mydata[val,2]
    if (i1 == i2) {
      mydata[val,3] <- all_Runs[curr]}
    else {
      curr <- curr + 1 
      mydata[val,3] <- all_Runs[curr]}
    val <- val + 1
  }
  
  return(mydata)
}


plot.gen <- function(minlength, mydata){
  
    # we find the maximum length of a streak, observed during current experiment
    maxlength <- max(mydata[,3])
    
    # we inform the user of the current experiment results
    exp.title <- paste("Nr de incercari = ", nrow(mydata), ", Cel mai mare sir obtinut = ",
                      maxlength, "\n Marcate fiind doar succesiunile cu lungimea = ", minlength, sep = "")
    
    
    tosses <- nrow(mydata)
    
    # we erase the white characters surrounding the plot, for better ui experience
    par(mar=c(3,.5,3,.5)+0.1)
    
    # the plot consists of 25 columns and ceiling(tosses/25) rows
    plot(1,1,xlim=c(0,25+1),ylim=c(0,ceiling(nrow(mydata)/25)+1),col=0,
         yaxt="n",xaxt="n",xlab="",ylab="",main=exp.title)
    
    
    # we create a table containing the positions inside the matrix of each toss
    # x = the horizontal Cartesian coordinate of the coin flip [1..25]
    # y = the vertical Cartesian coordinate of the coin flip [1..ceiling(tosses/25)]
    
    i <- seq(1, nrow(mydata)) # we need an index in order to arrange the coordinates
    
    x <- i %% 25 # i = [0..24]
    
    x[which(x==0)]<-25 # x = [1..25], the horizontal structure of the matrix
    
    # the vertical structure
    # it is reversed, as the streak of results is being written inside a plot
    # we use coordinates as if we were to write points inside a chart xOy
    y <- ceiling(nrow(mydata)/25) - ceiling (i/25) + 1
    
    # we bind the results together 
    mydata <- cbind(mydata,x,y)
    
    
    # for each toss in particular
    for (i in 1:nrow(mydata)){
      # we verify if the result is "Heads", or "Tails"
      my.coin <-coords[i,1]
      if(my.coin == 1){
        #Heads
        
        # we check if the current toss is part of a streak
        # if it is, we color it red
        if(mydata[i,3]>=minlength)
            text(mydata[i,4], mydata[i,5], "H",
                 col="teal", font = 2)
        else 
          text(mydata[i,4],mydata[i,5],"H")}
      }
      if(my.coin == 0){
        # Tails
        text(mydata[i,4],mydata[i,5],"T")
      }
      
    }
