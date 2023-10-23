#!/usr/bin/python3
"""Needed module to retrieve dat from api"""
import requests
import sys


def get_employee_todo_progress(employee_id):
    """Define the base URL for the API"""

    base_url = "https://jsonplaceholder.typicode.com"

    params = {'userId': employee_id}

    # Make a GET request to retrieve the user's information
    user_response = requests.get(f"{base_url}/users/{employee_id}")
    user_data = user_response.json()
    employee_name = user_data.get('name')

    # Make a GET request to retrieve the user's TODO list with the parameters
    todo_response = requests.get(f"{base_url}/todos", params=params)

    todo_list = todo_response.json()
    total_tasks = len(todo_list)
    completed_tasks = [task for task in todo_list if task.get('completed')]

    print("Employee {} is done with tasks({}/{}):".format(
        employee_name, len(completed_tasks), total_tasks))
    for task in completed_tasks:
        print("\t {}".format(task.get('title')))


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python3 gather_data_from_an_API.py <employee_id>")
    else:
        employee_id = int(sys.argv[1])
        get_employee_todo_progress(employee_id)
