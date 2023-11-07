#!/usr/bin/python3
"""
Required modules
"""
import requests


def top_ten(subreddit):
    """prints the titles of the first 10 hot posts listed for a given subreddit"""
    url = "https://www.reddit.com/r/{}/hot.json?limit=10".format(subreddit)
    headers = {'User-Agent': 'MyRedditApi/1.0'}

    response = requests.get(url, headers=headers, allow_redirects=False)
    if response.status_code == 200:
        data = response.json()
        if 'data' in data and 'children' in data['data']:
            posts = data['data']['children']

            for post in posts:
                print(post['data']['title'])
    else:
        print("None")
