import os
import pytest
from pytest_project.api_clients.api_clients import PytestProjectApiClients

@pytest.mark.cli
@pytest.mark.script_launch_mode('subprocess')
def test_cli_check(script_runner):
    """
    Example testcase for a CLI
    """
    cmd = 'ls'
    option = '-l'
    ret = script_runner.run(cmd, option)
    assert not str(ret.stderr)

@pytest.mark.rest
def test_rest_check():
    """
    Example testcase for a REST API call
    """
    api_clients = PytestProjectApiClients()
    response = api_clients.pytest_project_api.get_example_data()
    assert response.ok, "Expected GET to succeed. {}".format(response.text)
    print(str(response.json()))
