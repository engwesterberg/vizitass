# Vizzit - Full Stack Assignment
### This assignment entails the development of a very small, yet full stack Python3/uWSGI based website built from the ground up.

## Introduction
This project is based on a booking system for renting of cars, with a not-so-perfect database. Your assignment is to create a simple website according to the below **specification**, which displays the output of the two **tasks** given in this document.

Evaluation is based on code, database understanding, task solutions as well as general web development skillsets.

## Tasklist
### Task 1
Using a single SQL query, get customer details from all the customers of whom registered multiple phone numbers, where at least one phone number is specifically a mobile number (Type=CELL). The more customer details, the better.

### Task 2
Using a single SQL query, get information on all the blue cars of which were *not* being rented during the period of 2013­-03­-11 to 2013­-03­-20 inclusively. The more information about the cars, the better.

## Specification

### Database
A MySQL database, with its structure set up according to the included `db.mwb` (MySQL Workbench Database Model), and filled with the data from the `db.sql` file.

### Web Application
Written as a basic Python3/uWSGI web application, ***without*** the use of any type of external web framework like Django or Flask. It should be runnable using just the `uwsgi` command. See [this guide](https://uwsgi-docs.readthedocs.io/en/latest/WSGIquickstart.html) for some examples.

For HTML content, use Jinja2 to load HTML template files through a `Jinja2.BytecodeCache` enabled `Jinja2.FileSystemLoader`.

### Website
This is the end result. Defined below are three HTTP endpoints and descriptions on how they should work. Only one web page, and an API with two methods mirroring the two tasks. Design is completely irrelevant so long as it is readable.

##### HTTP Endpoint: /
A basic web page, containing two HTML tables initially empty of data, with table headers matching the data columns from your task solutions. Using pure javascript (***without*** an external framework like jQuery), request data from the two API endpoints (using Ajax or JSONP) and fill the two HTML tables with the response.

##### HTTP Endpoint: `/api/task/1/`
Executes **Task 1** and returns the data as a JSON response.

##### HTTP Endpoint: `/api/task/2/`
Executes **Task 2** and returns the data as a JSON response.

