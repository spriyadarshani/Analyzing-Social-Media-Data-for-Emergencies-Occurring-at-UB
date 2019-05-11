library("twitteR")
library("ROAuth")
library("NLP")
library("syuzhet")
library("tm")
library("SnowballC")
library("stringi")
library("topicmodels")
library("syuzhet")
library("tmap")

consumer_key <- 'xxx'
consumer_secret <- 'xxx'
access_token <- 'xxx'
access_secret <- 'xxx'
setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)

tweets_bufbliz <- searchTwitter("ub + snow + alert", n=1000,lang = "en")

blizzard_tweets <- twListToDF(tweets_bufbliz)

blizzard_text<- blizzard_tweets$text

#convert all text to lower case
blizzard_text<- tolower(blizzard_text)

# Replace blank space (“rt”)
blizzard_text <- gsub("rt", "", blizzard_text)

# Replace @UserName
blizzard_text <- gsub("@\\w+", "", blizzard_text)

# Remove punctuation
blizzard_text <- gsub("[[:punct:]]", "", blizzard_text)

# Remove links
blizzard_text <- gsub("http\\w+", "", blizzard_text)

# Remove tabs
blizzard_text <- gsub("[ |\t]{2,}", "", blizzard_text)

# Remove blank spaces at the beginning
blizzard_text <- gsub("^ ", "", blizzard_text)

# Remove blank spaces at the end
blizzard_text <- gsub(" $", "", blizzard_text)

#create corpus
blizzard_tweets.text.corpus <- Corpus(VectorSource(blizzard_text))

#clean up by removing stop words
blizzard_tweets.text.corpus <- tm_map(blizzard_tweets.text.corpus, function(x)removeWords(x,stopwords()))

View(blizzard_text)