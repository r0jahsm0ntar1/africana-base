#!/bin/bash

# Check if port 8080 is in use
if lsof -i :8080 > /dev/null ; then
  # Get the PID of the process using port 8080
  PID=$(lsof -i :8080 | awk 'NR==2 {print $2}')

  # Kill the process using port 8080
  kill -9 $PID
  echo "Process with PID $PID using port 8080 was killed."
else
  echo "Port 8080 is not in use."
fi
