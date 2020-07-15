library(quanteda)
library(sqldf)
library(quanteda)
library(stringr)
library(data.table)
##############Downloading files and making corpus
# 1234567
# 100000
# 100000
# 
# 190000
# 20000
# 2000


#path setting
# For local D:/DS/data_products/mak_capstone/data/
# For online "data/en_US.twitter.txt"

setwd("D:/DS/data_products/mak_capstone/")
#twitter_con <- file("data/en_US.twitter.txt")
# twitter_con <- file("D:/DS/data_products/mak_capstone/data/en_US.twitter.txt") 
# twitterfeed<-readLines(twitter_con,9900)
# close(twitter_con)
# 
# #news_con <- file("data/en_US.news.txt") 
# news_con <- file("D:/DS/data_products/mak_capstone/data/en_US.news.txt") 
# newsfeed<-readLines(news_con,1000)
# close(news_con)
# 
# #blog_con <- file("data/en_US.blogs.txt") 
# blog_con <- file("D:/DS/data_products/mak_capstone/data/en_US.blogs.txt") 
# blogfeed<-readLines(blog_con,1000)
# close(blog_con)
# 
# 
# 
# ## combine the text documents to a single corpus
# mak_combined <- c(twitterfeed,newsfeed,blogfeed)
# rm(twitterfeed,newsfeed,blogfeed)


mytextsamp <-c('zinger burger good yummy tasty','zinger candy lovely yummy tasty')
               #GOP line on Obama gay marriage stance seems to be that he flip-flopped. Really want to use that with Romney as your presidential candidate?')
#'I know, I know. Then you kick yourself when the fight goes lopsided. But if the upset DOES happen, wow. Nothing like it')

makcorpus <-corpus(mytextsamp)

#OFF FOR TESTING SHOULD BE ON FOR PRODUCTION
#makcorpus <-corpus(mak_combined)

#summary(makcorpus)

#Tokenize the Corpus
#Creating Corpus & Cleansing
maktokens <- tokens(makcorpus)
maktokens <- tokens(maktokens, remove_punct = TRUE, remove_numbers = TRUE)
maktokens <- tokens_select(maktokens, stopwords('english'),selection='remove')
#maktokens <- tokens_wordstem(maktokens)
maktokens <- tokens_tolower(maktokens)

#Create NGRAM
#########################################################NGRAM ANALYSIS
#Ngram Analysis
#mak_tokens<-tokens_ngrams(doc.tokens, n = c(1,2,3,4,5,6,7),skip=2,concatenator = " ")

mak_1gram<-tokens_ngrams(maktokens, n =1,concatenator = " ")
mak_2gram<-tokens_ngrams(maktokens, n =2,concatenator = " ")
mak_3gram<-tokens_ngrams(maktokens, n =3,concatenator = " ")
mak_4gram<-tokens_ngrams(maktokens, n =4,concatenator = " ")
mak_5gram<-tokens_ngrams(maktokens, n =5,concatenator = " ")



rm(maktokens)
#toks_neg_bigram <- tokens_compound(mak_ngrams, pattern = phrase('see way*'))


##################converting to dfm

mak_1dfm <- dfm(mak_1gram,verbose = FALSE)
mak_2dfm <- dfm(mak_2gram,verbose = FALSE)
mak_3dfm <- dfm(mak_3gram,verbose = FALSE)
mak_4dfm <- dfm(mak_4gram,verbose = FALSE)
mak_5dfm <- dfm(mak_5gram,verbose = FALSE)


#rm(mak_1gram,mak_2gram,mak_3gram,mak_4gram,mak_5gram)

#Generating Frequencies
mak1_freq<-textstat_frequency(
    mak_1dfm,
    n = NULL,
    groups = NULL,
    ties_method = c("min", "average", "first", "random", "max", "dense"),
)

mak1_freq <-data.table(mak1_freq[,1:3])
#mak1_freq[1:4,1:3]

#Generating Frequencies 2
mak2_freq<-textstat_frequency(
    mak_2dfm,
    n = NULL,
    groups = NULL,
    ties_method = c("min", "average", "first", "random", "max", "dense"),
)

mak2_freq <-data.table(mak2_freq[,1:3])
#mak2_freq[1:4,1:3]


#Generating Frequencies 3
mak3_freq<-textstat_frequency(
    mak_3dfm,
    n = NULL,
    groups = NULL,
    ties_method = c("min", "average", "first", "random", "max", "dense"),
)

mak3_freq <-data.table(mak3_freq[,1:3])
#mak3_freq[1:4,1:3]

#Generating Frequencies 4
mak4_freq<-textstat_frequency(
    mak_4dfm,
    n = NULL,
    groups = NULL,
    ties_method = c("min", "average", "first", "random", "max", "dense"),
)

mak4_freq <-data.table(mak4_freq[,1:3])
#mak4_freq[1:20,1:3]


#Generating Frequencies 5
mak5_freq<-textstat_frequency(
    mak_5dfm,
    n = NULL,
    groups = NULL,
    ties_method = c("min", "average", "first", "random", "max", "dense"),
)
mak5_freq <-data.table(mak5_freq[,1:3])
#mak5_freq <-as.data.frame(mak5_freq[,1:3])

# ##For Online
saveRDS(mak1_freq, "mak1_freq.RDS")
saveRDS(mak2_freq, "mak2_freq.RDS")
saveRDS(mak3_freq, "mak3_freq.RDS")
saveRDS(mak4_freq, "mak4_freq.RDS")
saveRDS(mak5_freq, "mak5_freq.RDS")


# saveRDS(mak1_freq, "D:/DS/data_products/mak_capstone/mak1_freq.RDS")
# saveRDS(mak2_freq, "D:/DS/data_products/mak_capstone/mak2_freq.RDS")
# saveRDS(mak3_freq, "D:/DS/data_products/mak_capstone/mak3_freq.RDS")
# saveRDS(mak4_freq, "D:/DS/data_products/mak_capstone/mak4_freq.RDS")
# saveRDS(mak5_freq, "D:/DS/data_products/mak_capstone/mak5_freq.RDS")

#To be enabled for ONLINE

#rm(mak_combined,mak_1dfm,mak_2dfm,mak_3dfm,mak_4dfm,mak_5dfm,mak1_freq,mak2_freq,mak3_freq,mak4_freq,mak5_freq)


