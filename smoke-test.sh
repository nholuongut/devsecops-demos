#!/bin/bash

# Send a request to the calculator API and store the response in a variable
response=$(curl -s -X POST -H "Content-Type: application/x-www-form-urlencoded" -d 'num1=3&num2=5&operation=add' http://34.238.38.207:8090/manik-calculator/calculate)

# Check if the response contains the expected result
if [[ "$response" == *"8"* ]]; then
  echo "Smoke test passed"
  exit 0
else
  echo "Smoke test failed"
  exit 1
fi
