# Libraries
import pandas as pd
import os, pickle
import sklearn, logging

from sklearn.feature_extraction.text import TfidfVectorizer

import nltk
nltk.download('stopwords')
nltk.download('punkt')

from nltk.corpus import stopwords
from nltk.tokenize import word_tokenize
import string

log = logging.getLogger()

def get_tweets_user(user):

    # Data scrapping
    os.system("snscrape --jsonl --max-results 100 twitter-user " + user + " > user-tweets.json")

    # Data loading and processing
    data = pd.read_json('user-tweets.json', lines=True)

    data.drop(['_type', 'url', 'date', 'renderedContent',  'id', 'replyCount', 'likeCount', 'quoteCount','conversationId', 'lang', 'source','sourceUrl', 'outlinks', 'tcooutlinks', 'sourceLabel', 'retweetCount', 'media', 'retweetedTweet', 'quotedTweet', 'inReplyToTweetId', 'inReplyToUser', 'mentionedUsers', 'coordinates', 'place', 'hashtags', 'cashtags',], axis=1, inplace=True)
    data_grouped=data.groupby(data.user.apply(pd.Series).username).content.apply(list).transform(lambda x : ' '.join(x)).reset_index()
    data_grouped['content'] = data_grouped.apply(lambda row: preprocess(row['content']), axis=1)

    # Data selection and vectorization
    x=data_grouped['content']
    vectorizer = pickle.load(open('model/TfidfVectorizer.pickle', "rb"))
    x = vectorizer.transform(x.apply(lambda x: ' '.join(x)))

    #Predictor
    loaded_model = pickle.load(open('model/RandomForest.sav', 'rb'))
    y_pred = loaded_model.predict(x)
    print(y_pred)

    # Delete used file
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
