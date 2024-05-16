#!/bin/sh

# create 5000 votes (1000 for option a, 4000 for option b)
ab -n 1000 -c 50 -p postb -T "application/x-www-form-urlencoded" http://nginx:8000/
ab -n 1000 -c 50 -p posta -T "application/x-www-form-urlencoded" http://nginx:8000/
ab -n 3000 -c 50 -p postb -T "application/x-www-form-urlencoded" http://nginx:8000/
