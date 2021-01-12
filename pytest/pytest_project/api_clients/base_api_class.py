"""Abstract for base API class."""
import os
import logging

class BaseApi:
    """Represents a base API class object."""

    def __init__(self):
        self.log = logging.getLogger(__name__)
        self.log.setLevel(os.getenv('LOG_LEVEL', 'INFO'))
