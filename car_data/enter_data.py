#!/usr/bin/env python3

import csv

file_name = input('Enter name of save file: ')
date = ''

with open(file_name, 'a') as csvfile:
    car_data = csv.writer(csvfile)
    while(True):
        date = input('Date: ')
        miles = input('Miles: ')
        gal = input('Gallons: ')
        money = input('Money: ')
        if(date == 'quit'):
            break

        car_data.writerow([date, miles, gal, money])
