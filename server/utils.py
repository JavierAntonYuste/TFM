# Libraries
import pandas as pd
import os, pickle, sklearn, logging, string, base64, re, collections, nltk
import numpy as np
import matplotlib.pyplot as plt

from sklearn.feature_extraction.text import TfidfVectorizer


from nltk.corpus import stopwords
from nltk.tokenize import word_tokenize

from wordcloud import WordCloud

nltk.download('stopwords')
nltk.download('punkt')



log = logging.getLogger()

def get_prediction(user):
    x,data = scrap_tweets(user)
    wordcloud=get_wordcloud(data)
    prediction=str(make_prediction(x))
    graph=get_graph(data)
    meanwords=get_mean(data)
    mentioned_users=get_most_mentioned_users(data)
    
    # Data preparation for JSON
    username=data['user'][0].get('username')
    pic=data['user'][0].get('profileImageUrl').replace('_normal','') 

    # Delete used file
    os.system("rm -rf user-tweets.json") 

    return {'prediction': prediction, 'username': username, 'meanwords':meanwords, \
        'mentioned_users':mentioned_users,'pic':pic, 'wordcloud':wordcloud, 'graph': graph}


def scrap_tweets(user):
    # Data scrapping
    os.system("snscrape --jsonl --max-results 1000 twitter-user " + user + " > user-tweets.json")

    # Data loading and processing
    data = pd.read_json('user-tweets.json', lines=True)

    data.drop(['_type', 'url', 'renderedContent',  'id', 'replyCount', 'likeCount', \
        'quoteCount','conversationId', 'lang', 'source','sourceUrl', 'outlinks', 'tcooutlinks', \
        'sourceLabel', 'retweetCount', 'media', 'retweetedTweet', 'quotedTweet', \
        'inReplyToTweetId', 'inReplyToUser', 'mentionedUsers', 'coordinates', 'place',\
         'hashtags', 'cashtags',], axis=1, inplace=True)
    data_grouped=data.groupby(data.user.apply(pd.Series).username).content.apply(list).transform(lambda x : ' '.join(x)).reset_index()
    data_grouped['content'] = data_grouped.apply(lambda row: preprocess(row['content']), axis=1)

    # Data selection and vectorization
    x=data_grouped['content']

    return x,data

def make_prediction(x):
    vectorizer = pickle.load(open('model/TfidfVectorizer.pickle', "rb"))
    x_vec = vectorizer.transform(x.apply(lambda x: ' '.join(x)))

    #Predictor
    loaded_model = pickle.load(open('model/RandomForest.sav', 'rb'))
    y_pred = loaded_model.predict(x_vec)
    return y_pred[0]


def preprocess(words, type='doc'):
    tokens = nltk.word_tokenize(words)
    porter = nltk.PorterStemmer()
    lemmas = [porter.stem(t) for t in tokens]
    stoplist = stopwords.words('english')
    lemmas_clean = [w for w in tokens if w not in stoplist]
    punctuation = set(string.punctuation)
    words = [w for w in lemmas_clean if  w not in punctuation]
    return words

def test(user):
    x,data = scrap_tweets(user)
    
    vectorizer = pickle.load(open('model/TfidfVectorizer.pickle', "rb"))
    x = vectorizer.transform(x.apply(lambda x: ' '.join(x)))

    #Predictor
    loaded_model = pickle.load(open('model/RandomForest.sav', 'rb'))
    y_pred = loaded_model.predict(x)
    print(y_pred)

    # Delete used file
    os.system("rm -rf user-tweets.json")

    # Data preparation for JSON
    prediction=str(y_pred[0])
    username=data['user'][0].get('username')
    pic=data['user'][0].get('profileImageUrl')
    pic_orig=pic.replace('_normal','') 


    return {'prediction': prediction, 'username': username, 'pic':pic_orig }

def get_wordcloud(data):
    # Start with one review:
    data_grouped=data.groupby(data.user.apply(pd.Series).username).content.apply(list).transform(lambda x : ' '.join(x)).reset_index()

    text = data_grouped['content'][0]
    text_clean = re.sub(r"(?:\@|https?\://)\S+", "", text)

    stopwords = nltk.corpus.stopwords.words('english')
    # Create and generate a word cloud image:
    wordcloud = WordCloud(stopwords=stopwords, background_color='#c3e3fdf9', width=1600, height=800).generate(text_clean).to_file('wordcloud.png')

    with open("wordcloud.png", "rb") as image:
        f = image.read()
        im_b64 = base64.b64encode(f).decode("utf8")

    os.system("rm -rf wordcloud.png")

    return im_b64

def get_graph(data):
    tweet_df_24h=pd.DataFrame()
    tweet_df_24h= data.groupby(pd.Grouper(key='date', freq='24H', convention='start')).size()
    tweet_df_24h.plot(figsize=(18,6), color='#e91e63')

    plt.ylabel('24 Hours Tweet Count')
    plt.xlabel('Date')
    plt.title('Tweet Frequency')
    plt.grid(True)
    plt.savefig('graph.png', transparent=True)

    with open("graph.png", "rb") as image:
        f = image.read()
        im_b64 = base64.b64encode(f).decode("utf8")

    del tweet_df_24h
    os.system("rm -rf graph.png")

    return im_b64

def get_mean(data):
    data["n_words"] = data["content"].apply(lambda x: len(x))
    return data['n_words'].mean()

def get_most_mentioned_users(data):
    result=data.apply(lambda row: re.findall("@([a-zA-Z0-9]{1,15})",row['content']), axis=1)
    result_filtered = [x for x in result if x]
    result_flat = [x for xs in result_filtered for x in xs]

    counter=collections.Counter(result_flat)
    return counter.most_common(5)
