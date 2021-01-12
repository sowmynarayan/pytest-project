from pytest_project.api_clients.pytest_project_api import PytestProjectApi

class PytestProjectApiClients:
    """
    Collection of clients that a user session can call
    """
    def __init__(self):
        self.pytest_project_api = PytestProjectApi()

