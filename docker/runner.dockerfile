FROM python:3

COPY ./requirements-test.txt /pytest/requirements-test.txt
RUN pip3 install -r /pytest/requirements-test.txt

COPY . /pytest
RUN pip3 install --no-cache-dir -e /pytest

COPY pytest.ini /pytest.ini
