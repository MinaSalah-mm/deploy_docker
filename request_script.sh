#!/bin/bash

# Method 1: Using a C-style for loop
for ((i=1; i<=100; i++))
do
    curl http://localhost:8080 &
done
