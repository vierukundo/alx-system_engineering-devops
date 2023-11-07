#!/usr/bin/python3
"""
Required modules
"""
import requests


def recurse(subreddit, hot_list=[], after=None):
    """returns a list containing the titles of all
    hot articles for a given subreddit"""
    if subreddit is None:
        return None
    url = "https://www.reddit.com/r/{}/hot.json?limit=10".format(subreddit)
    headers = {'User-Agent': 'MyRedditApi/1.0'}
    if after:
        url += f"&after={after}"
    response = requests.get(url, headers=headers, allow_redirects=False)
    if response.status_code == 200:
        data = response.json()
        if 'data' in data and 'children' in data['data']:
            posts = data['data']['children']
            for post in posts:
                hot_list.append(post['data']['title'])
            after = data['data']['after']
            if after:
                return recurse(subreddit, hot_list, after)
            else:
                return hot_list
        else:
            return None
    else:
        return None
