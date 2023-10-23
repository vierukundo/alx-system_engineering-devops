#!/usr/bin/python3
"""Needed module to retrieve dat from api"""
import csv
import requests
import sys


def get_employee_todo_progress(employee_id):
    """Define the base URL for the API"""

    base_url = "https://jsonplaceholder.typicode.com"

    params = {'userId': employee_id}

    # Make a GET request to retrieve the user's information
    user_response = requests.get(f"{base_url}/users/{employee_id}")
    user_data = user_response.json()
    employee_username = user_data.get('username')

    # Make a GET request to retrieve the user's TODO list with the parameters
    todo_response = requests.get(f"{base_url}/todos", params=params)

    todo_list = todo_response.json()
    # export data in the CSV format
    with open("{}.csv".format(employee_id), 'w') as f:
        writer = csv.writer(f, quoting=csv.QUOTE_ALL)
        for task in todo_list:
            row = [
                    task.get('userId'), employee_username,
                    task.get('completed'), task.get('title')
                    ]
            writer.writerow(row)


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python3 gather_data_from_an_API.py <employee_id>")
    else:
        employee_id = int(sys.argv[1])
        get_employee_todo_progress(employee_id)
