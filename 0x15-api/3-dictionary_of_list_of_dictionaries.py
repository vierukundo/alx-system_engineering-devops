#!/usr/bin/python3i
"""Needed module to retrieve dat from api"""
import json
import requests
import sys


def todo_all_employees_progress():
    """Define the base URL for the API"""

    base_url = "https://jsonplaceholder.typicode.com"
    user_id = 1

    while True:
        try:
            user_data = requests.get(f"{base_url}/users/{user_id}").json()
            params = {'userId': user_id}
            todo_list = requests.get(f"{base_url}/todos", params=params).json()
        except Exception:
            sys.exit(1)

        user_associated_task = {}
        task_list = []
        username = user_data.get('username')

        for task in todo_list:
            task_info = {}
            task_info['task'] = task.get('title')
            task_info['completed'] = task.get('completed')
            task_info['username'] = username

            task_list.append(task_info)
        user_associated_task['{}'.format(user_id)] = task_list

        user_id += 1

    with open('todo_all_employees.json', 'w') as f:
        json.dump(user_associated_task, f)


if __name__ == "__main__":
    todo_all_employees_progress()
