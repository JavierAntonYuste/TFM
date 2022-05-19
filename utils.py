# Libraries
import pandas as pd
import os, pickle
import sklearn, logging

from sklearn.feature_extraction.text import TfidfVectorizer

import nltk
nltk.download('stopwords')
from nltk.corpus import stopwords
from nltk.tokenize import word_tokenize
import string

log = logging.getLogger()

def get_tweets_user(user):

    # Data scrapping
    print('Data scrapping')
    os.system("snscrape --jsonl --max-results 10 twitter-user " + user + " > user-tweets.json")

    # Data loading and processing
    print('Processing data...')

    data = pd.read_json('user-tweets.json', lines=True)

    print('Processing data 1...')
    #data.drop(['_type', 'url', 'date', 'renderedContent',  'id', 'replyCount', 'likeCount', 'quoteCount','conversationId', 'lang', 'source','sourceUrl', 'outlinks', 'tcooutlinks', 'sourceLabel', 'retweetCount', 'media', 'retweetedTweet', 'quotedTweet', 'inReplyToTweetId', 'inReplyToUser', 'mentionedUsers', 'coordinates', 'place', 'hashtags', 'cashtags',], axis=1, inplace=True)
    print('Processing data 2 ...')
    data_grouped=data.groupby(data.user.apply(pd.Series).username).content.apply(list).transform(lambda x : ' '.join(x)).reset_index()

    print('PreProcessing data...')

    data_grouped['content'] = data_grouped.apply(lambda row: preprocess(row['content']), axis=1)

    x=data_grouped['content']
    print(x)

    print('Vectorizing...')

    vectorizer = TfidfVectorizer(analyzer='word', stop_words='english')
    x = vectorizer.fit_transform(x.apply(lambda x: ' '.join(x)))

    #Predictor
    log.info('Predicting data')
    loaded_model = pickle.load(open('model/RandomForest.sav', 'rb'))
    log.info('Predicting data ')
    y_pred = loaded_model.predict(x)

    os.system("rm -rf user-tweets.json")

    return data



def preprocess(words, type='doc'):
    tokens = nltk.word_tokenize(words)
    porter = nltk.PorterStemmer()
    lemmas = [porter.stem(t) for t in tokens]
    stoplist = stopwords.words('english')
    lemmas_clean = [w for w in tokens if w not in stoplist]
    punctuation = set(string.punctuation)
    words = [w for w in lemmas_clean if  w not in punctuation]
    return words


def predict(user):

    # Data scrapping
    log.info('Data scrapping')
    os.system("snscrape --jsonl --max-results 10 twitter-user " + user + " > user-tweets.json")

    # Data loading and processing
    log.info('Processing data...')

    tweets_df = pd.read_json('user-tweets.json', lines=True)
    tweets_df.drop(['_type', 'url', 'date', 'renderedContent',  'id', 'replyCount', 'likeCount', 'quoteCount','conversationId', 'lang', 'source','sourceUrl', 'outlinks', 'tcooutlinks', 'sourceLabel', 'retweetCount', 'media', 'retweetedTweet', 'quotedTweet', 'inReplyToTweetId', 'inReplyToUser', 'mentionedUsers', 'coordinates', 'place', 'hashtags', 'cashtags',], axis=1, inplace=True)
    data_grouped=data.groupby(data.user.apply(pd.Series).username).content.apply(list).transform(lambda x : ' '.join(x)).reset_index()
    x=data_grouped['content']
    x = vectorizer.fit_transform(x.apply(lambda x: ' '.join(x)))


    #Predictor
    log.info('Predicting data')

    loaded_model = pickle.load(open('model/RandomForest.sav', 'rb'))
    y_pred = loaded_model.predict(x)
   
    os.system("rm -rf user-tweets.json")

    return y_pred