gfun <- function(input_text) {

#Import Libraries
    library(sqldf)
    library(stringr)
    library(quanteda)
    
 #Toeknize the input string   
    input_text <-corpus(input_text)
    inputtokens <- tokens(input_text)
    inputtokens <- tokens(inputtokens, remove_punct = TRUE, remove_numbers = TRUE)
    inputtokens <- tokens_select(inputtokens, stopwords('english'),selection='remove')
    inputtokens <- tokens_tolower(inputtokens)
    inputtokens <-tokens(inputtokens, remove_punct = TRUE, remove_hyphens = TRUE)
    inputtokens<-as.character(inputtokens)
    input_text_fin<-str_flatten(inputtokens, " ")

  #Tackling for 0 lenght input
    
      if (length(input_text_fin)==0) {
        return (input_text)
        
    }
    else {

        x<-sapply(strsplit(input_text_fin, " "), length)
          finword<-''
          makword<-''
          result<-'' 
          x<-sapply(strsplit(input_text_fin, " "), length)
     
      #If input text is greater then 5 words then Consider last 5 words for next word prediction 
 if (x>=5) {
            finword<-str_flatten(word(input_text_fin,(x-3):x)," ") 
            x<-4
        } else {
            finword<-str_flatten(word(input_text_fin,1:x)," ")
        }
        
     #This is main program logic ,it takes the input string and based on number of words search in saved RDS by utilizing Stupid Backoff method.
        for (fnd in x:0 )
        {
  
          if (fnd==4) {
            mak4_freq<- readRDS("mak4_freq.RDS")
            makword<-fn$sqldf("select feature from mak5_freq where feature like'$finword' || '%' order by frequency desc limit 1")
            if (lengths(makword)>=1) {
              result<-str_remove(makword,finword)
             return(result)
              break }

          }
          if (fnd==3) {
            mak4_freq<- readRDS("mak4_freq.RDS")
            finword<-str_flatten(word(input_text_fin,1:fnd)," ")
            makword<-fn$sqldf("select feature from mak4_freq where feature like'$finword' || '%' order by frequency desc limit 1")
            if (lengths(makword)>=1) {
              result<-str_remove(makword,finword)
              
            
              return(result)
              break }
          } 
          
          if (fnd==2) {
            finword<-str_flatten(word(input_text_fin,1:fnd)," ")
            mak3_freq<- readRDS("mak3_freq.RDS")
            makword<-fn$sqldf("select feature from mak3_freq where feature like'$finword' || '%' order by frequency desc limit 1")
            if (lengths(makword)>=1) {
              result<-str_remove(makword,finword)
              
              #print(fnd)
              return(result)
              break }
          } 
          if (fnd==1) {
            finword<-str_flatten(word(input_text_fin,1:fnd)," ")
            mak2_freq<- readRDS("mak2_freq.RDS")
            makword<-fn$sqldf("select feature from mak2_freq where feature like'$finword' || '%' order by frequency desc limit 1")
            if (lengths(makword)>=1) {
              result<-str_remove(makword,finword)
              
          
              return(result)
              break }
                    else { return ("No match found")
                      }
          } 
        
        }  
        
        
        
        
        
 
    }
}

