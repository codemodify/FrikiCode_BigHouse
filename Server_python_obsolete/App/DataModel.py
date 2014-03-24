
from peewee import *

from App import DataBase
from App import TableList

class Person(Model):
	Name = CharField()
	Age = IntegerField()
	IsHealthy = BooleanField()
	
	class Meta:
		database = DataBase


TableList.append( Person )
