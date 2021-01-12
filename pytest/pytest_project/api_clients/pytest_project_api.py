import requests
from requests import Response
from pytest_project.api_clients.base_api_class import BaseApi

class PytestProjectApi(BaseApi):
    """
    Set of API clients and helpers that call this service
    """

    def __init__(self):
        self.example_url = 'http://api.open-notify.org/'

    def get_example_data(self) -> Response:

        url = f'{self.example_url}/astros.json'
        response = requests.get(url)
        return response
