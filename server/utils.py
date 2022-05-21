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


import contractions
import torch
import numpy as np
from transformers import BertTokenizer
from torch import nn
from transformers import BertModel
from torch.optim import Adam
from tqdm import tqdm
from sklearn.metrics import precision_recall_fscore_support as score


log = logging.getLogger()


def scrap_tweets(user):
    # Data scrapping
    os.system("snscrape --jsonl --max-results 1000 twitter-user " + user + " > user-tweets.json")

    # Data loading and processing
    data = pd.read_json('user-tweets.json', lines=True)

    data.drop(['_type', 'url', 'date', 'renderedContent',  'id', 'replyCount', 'likeCount', 'quoteCount','conversationId', 'lang', 'source','sourceUrl', 'outlinks', 'tcooutlinks', 'sourceLabel', 'retweetCount', 'media', 'retweetedTweet', 'quotedTweet', 'inReplyToTweetId', 'inReplyToUser', 'mentionedUsers', 'coordinates', 'place', 'hashtags', 'cashtags',], axis=1, inplace=True)
    data_grouped=data.groupby(data.user.apply(pd.Series).username).content.apply(list).transform(lambda x : ' '.join(x)).reset_index()
    data_grouped['content'] = data_grouped.apply(lambda row: preprocess(row['content']), axis=1)

    # Data selection and vectorization
    x=data_grouped['content']

    return x


def get_tweets_user(user):

    x = scrap_tweets(user)

    ##### FOR TESTING #####
    data = pd.read_json('user-tweets.json', lines=True)
    data.drop(['_type', 'url', 'date', 'renderedContent',  'id', 'replyCount', 'likeCount', 'quoteCount','conversationId', 'lang', 'source','sourceUrl', 'outlinks', 'tcooutlinks', 'sourceLabel', 'retweetCount', 'media', 'retweetedTweet', 'quotedTweet', 'inReplyToTweetId', 'inReplyToUser', 'mentionedUsers', 'coordinates', 'place', 'hashtags', 'cashtags',], axis=1, inplace=True)
    #######################
    
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

def get_tweets_user_ml(user):

    x = scrap_tweets(user)

    ##### FOR TESTING #####
    data = pd.read_json('user-tweets.json', lines=True)
    data.drop(['_type', 'url', 'date', 'renderedContent',  'id', 'replyCount', 'likeCount', 'quoteCount','conversationId', 'lang', 'source','sourceUrl', 'outlinks', 'tcooutlinks', 'sourceLabel', 'retweetCount', 'media', 'retweetedTweet', 'quotedTweet', 'inReplyToTweetId', 'inReplyToUser', 'mentionedUsers', 'coordinates', 'place', 'hashtags', 'cashtags',], axis=1, inplace=True)
    #######################  

    model = pickle.load(open('model/mBERT.sav', 'rb'))

    test = Dataset(test_data)

    test_dataloader = torch.utils.data.DataLoader(test, batch_size=4)

    use_cuda = torch.cuda.is_available()
    device = torch.device("cuda" if use_cuda else "cpu")

    if use_cuda:

        model = model.cuda()

    total_acc_test = 0
    y_test = []
    y_pred = []
    with torch.no_grad():

        for test_input, test_label in test_dataloader:

              test_label = test_label.to(device)
              mask = test_input['attention_mask'].to(device)
              input_id = test_input['input_ids'].squeeze(1).to(device)

              output = model(input_id, mask)

              acc = (output.argmax(dim=1) == test_label).sum().item()
              y_test.extend(test_label.tolist())
              y_pred.extend(output.argmax(dim=1).tolist())
              total_acc_test += acc
    
    print(f'Test Accuracy: {total_acc_test / len(test_data): .3f}')
    precision,recall,fscore,support=score(y_test,y_pred,average='weighted')
    print(f'Precision: {precision}')
    print(f'Recall: {recall}')
    print(f'fscore: {fscore}')

    #Predictor
    
    print(y_pred)

    # Delete used file
    os.system("rm -rf user-tweets.json")

    return data