
from flask import Flask
from peewee import SqliteDatabase

AppInstance = Flask(__name__)

DataBase = SqliteDatabase( 'BigHouse.sqlitedb', threadlocals=True )
DataBase.connect()

TableList = []

from Services import *
