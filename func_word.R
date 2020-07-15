gfun <- function(input_text) {
    
# start_time <- Sys.time()
#Load Libraries 

    library(sqldf)
    library(stringr)
    library(quanteda)
    
    input_text <-corpus(input_text)
    #summary(input_text)
    
    inputtokens <- tokens(input_text)
    inputtokens <- tokens(inputtokens, remove_punct = TRUE, remove_numbers = TRUE)
    inputtokens <- tokens_select(inputtokens, stopwords('english'),selection='remove')
    #inputtokens <- tokens_wordstem(inputtokens)
    inputtokens <- tokens_tolower(inputtokens)
    inputtokens <-tokens(inputtokens, remove_punct = TRUE, remove_hyphens = TRUE)
    inputtokens<-as.character(inputtokens)
    input_text_fin<-str_flatten(inputtokens, " ")
    #print(input_text_fin)
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
        #print(x)
      #If input text is greater then 5 words then Consider last 5 words for next word prediction 
        
        if (x>=5) {
            finword<-str_flatten(word(input_text_fin,(x-3):x)," ") 
            x<-4
        } else {
            finword<-str_flatten(word(input_text_fin,1:x)," ")
        }
        
     
        for (fnd in x:0 )
        {
          #print(fnd)
          if (fnd==4) {
            mak4_freq<- readRDS("mak4_freq.RDS")
            makword<-fn$sqldf("select feature from mak5_freq where feature like'$finword' || '%' order by frequency desc limit 1")
            if (lengths(makword)>=1) {
              result<-str_remove(makword,finword)
              
              #print(fnd)
              return(result)
              break }
            # else 
            # {print("Not found in four")}
          }
          if (fnd==3) {
            mak4_freq<- readRDS("mak4_freq.RDS")
            finword<-str_flatten(word(input_text_fin,1:fnd)," ")
            makword<-fn$sqldf("select feature from mak4_freq where feature like'$finword' || '%' order by frequency desc limit 1")
            if (lengths(makword)>=1) {
              result<-str_remove(makword,finword)
              
              #print(fnd)
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
              
              #print(fnd)
              return(result)
              break }
                    else { return ("No match found")
                      }
          } 
        
        }  
        
        
        
        
        
           
##########################start old
        
    #     if (x==4) {
    #         
    #         #print("Came in -4")
    #         makword<-''
    #         
    #         #for online
    #         mak5_freq<- readRDS("mak5_freq.RDS")
    #         #mak5_freq<- readRDS("D:/DS/data_products/mak_capstone/data/mak5_freq.RDS")
    #         makword<-fn$sqldf("select feature from mak5_freq where feature like'$finword' || '%' order by frequency desc limit 1")
    #         if (lengths(makword)>=1) {
    #             
    #             
    #             result<-str_remove(makword,finword)
    #             ##print(sprintf("Loop value=%i :: Result value<=%s> Result lenght=%s and actually its =%s",x,result,nchar(result),makword))
    #             return(result)
    #             
    #         }
    #     }
    #     
    #     
    #     else if (x==3) {
    #  
    #         #print("came in 3")
    #         mak4_freq<- readRDS("mak4_freq.RDS")
    #         #print(head(mak4_freq,4))
    #         #mak4_freq<- readRDS("D:/DS/data_products/mak_capstone/data/mak4_freq.RDS")
    #         makword<-fn$sqldf("select feature from mak4_freq where feature like'$finword' || '%' order by frequency desc limit 1")
    #         #print(makword)
    #         #print(lengths(makword))
    #         if (lengths(makword)>=1) {
    #             
    #             
    #             result<-str_remove(makword,finword)
    #             return(result)
    #         }
    #         
    # 
    #     }
    #     
    #     else if (x==2) {
    #         
    #         mak3_freq<- readRDS("mak3_freq.RDS")
    #         #mak3_freq<- readRDS("D:/DS/data_products/mak_capstone/data/mak3_freq.RDS")
    #         makword<-fn$sqldf("select feature from mak3_freq where feature like'$finword' || '%' order by frequency desc limit 1")
    #         if (lengths(makword)>=1) {
    #             result<-str_remove(makword,finword)
    #             #print(sprintf("Loop value=%i :: Result value<=%s> Result lenght=%s and actually its =%s",x,result,nchar(result),makword))
    #             return(result)
    #             #break
    #         } 
    #     }
    #     else if (x==1) {
    #         # print("Came in 1")
    #         mak2_freq<- readRDS("mak2_freq.RDS")
    #         #mak2_freq<- readRDS("D:/DS/data_products/mak_capstone/data/mak2_freq.RDS")
    #         makword<-fn$sqldf("select feature from mak2_freq where feature like'$finword' || '%' order by frequency desc limit 1")
    #         result<-str_remove(makword,finword)
    #         #print(sprintf("Loops  value=%i :: Result value<=%s> Result lenght=%s and actually its =%s",x,result,nchar(result),makword))
    #         return(result)
    #     }
    #     
    #     else {
    #         return (input_text_fin)
    #     }
    #     
    # 
    #     
    # }
    
    # end_time <- Sys.time()
    # 
    # tm<-end_time - start_time
    # print(tm)
############## end old
    }
}

