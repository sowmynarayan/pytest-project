from setuptools import setup
setup(
    name='pytest-project',
    version='1.0.0',
    description='A Pytest skeleton project',
    packages=[
        'pytest_project'
        ],
    install_requires=[
        'pytest>=3.3.0',
        'requests>=2.18.1',
        'tenacity',
        'pytest-xdist',
        'pytest-html',
        'jq'
    ]
)
