#!/bin/bash
set -ex

# Build the automation runner
docker build -t pytest-project ./pytest -f "./docker/runner.dockerfile"

# Output what is running in docker prior to running the tests
docker ps

# Create a folder for test reports
if [[ ! -d "./reports" ]]; then
    mkdir "./reports"
fi

# Use timestamp for local, COMMIT hash for gitlab
if [[ -z "$CI_COMMIT_SHA" ]]; then
    CONTAINER_NAME="jobs-e2e-$(date +%s)"
    XML_TEST_REPORT_NAME="test_report_$(date +%s).xml"
    HTML_TEST_REPORT_NAME="test_report_$(date +%s).html"
else
    CONTAINER_NAME="jobs-e2e-${CI_COMMIT_SHA}-${CI_JOB_ID}"
    XML_TEST_REPORT_NAME="${CI_COMMIT_SHA}_${CI_JOB_ID}_report.xml"
    HTML_TEST_REPORT_NAME="${CI_COMMIT_SHA}_${CI_JOB_ID}_report.html"
fi


# Copy test results from the container if tests pass or fail
function copy_test_results {
    docker cp "${CONTAINER_NAME}:/reports/${XML_TEST_REPORT_NAME}" "./reports/${XML_TEST_REPORT_NAME}"
    docker cp "${CONTAINER_NAME}:/reports/${HTML_TEST_REPORT_NAME}" "./reports/${HTML_TEST_REPORT_NAME}"
    docker rm "${CONTAINER_NAME}"
}
trap copy_test_results EXIT


# Run the tests
docker run \
    --name ${CONTAINER_NAME} \
    pytest-project pytest \
    --capture=tee-sys \
    --pyargs pytest_project \
    --junitxml=/reports/${XML_TEST_REPORT_NAME} \
    --html=/reports/${HTML_TEST_REPORT_NAME} \
    -k "not tbd"
