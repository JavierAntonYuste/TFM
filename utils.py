# Libraries
import pandas as pd
import os

def getTweetsUser(user):
    os.system("snscrape --jsonl --max-results 10 twitter-user " + user + " > user-tweets.json")
    tweets_df = pd.read_json('user-tweets.json', lines=True)
    os.system("rm -rf user-tweets.json")

    return tweets_df


