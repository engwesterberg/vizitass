from jinja2 import Environment, FileSystemLoader, Template
import fnmatch as fnmatch
import mysql.connector
import json


def print_html_doc(document_path):
    templateLoader = FileSystemLoader(searchpath="./")
    templateEnv = Environment(loader=templateLoader)
    template = templateEnv.get_template(document_path)
    return template.render()


def get_db_connection():
    return mysql.connector.connect(
        host="localhost",
        user="root",
        password="pass",
        database="booking")


def index(env, start_response):
    start_response('200 OK', [('content-type', 'text/html')])
    template = print_html_doc('index.html')
    return [str.encode(template)]


def task1(env, start_response):
    start_response('200 OK', [('content-type', 'text/html')])
    db = get_db_connection()
    cursor = db.cursor()
    cursor.execute("CALL getCustomersWithMinOneCell()", multi=True)
    row_headers = [x[0] for x in cursor.description]
    result = cursor.fetchall()
    cursor.close()
    db.close()
    json_data = []

    for result in result:
        json_data.append(dict(zip(row_headers, result)))

    return str.encode(json.dumps(json_data))


def task2(env, start_response):
    start_response('200 OK', [('content-type', 'text/html')])
    db = get_db_connection()
    cursor = db.cursor()
    cursor.execute(
        "CALL getCarsNotRentedWithinInterval('2013-03-20', '2013-03-11');",
        multi=True
    )
    row_headers = [x[0] for x in cursor.description]
    result = cursor.fetchall()
    cursor.close()
    db.close()
    json_data = []

    for result in result:
        json_data.append(dict(zip(row_headers, result)))

    return str.encode(json.dumps(json_data))


routes = [
        ('/', index),
        ('/task/1', task1),
        ('/task/2', task2),
        ]


def application(env, start_response):
    for path, app in routes:
        if fnmatch.fnmatch(env['PATH_INFO'], path):
            return app(env, start_response)
    return [b"Vizzit - Full Stack Assignment"]
