
from flask import jsonify

from App import AppInstance
from DataModel import *

@AppInstance.route('/')
def Index():
	return 'Hello World!'


@AppInstance.route('/SayHello')
def SayHello():
	return 'Hello.'


@AppInstance.route('/SayHelloTo/<user>')
def SayHelloTo(user):
	return 'Hello %s.' % user


@AppInstance.route('/ShowAnInt/<int:intValue>')
def ShowAnInt(intValue):
	return 'The number was %d.' % intValue


@AppInstance.route('/ShowMultipleValues/<value1>/<value2>')
def ShowMultipleValues(value1,value2):
	return 'The values were: %s, %s.' % (value1,value2)


@AppInstance.route('/SpitSomeJsonData')
def SpitSomeJsonData():
	
	simpleList = []
	simpleList.append( "qweasdzxc1" )
	simpleList.append( 12345 )
	
	simpleDict = {}
	simpleDict[0] = simpleList
	simpleDict[1] = simpleList
	simpleDict[2] = simpleList
	
	response = jsonify( simpleDict )
	response.status_code = 200
	
	return response


@AppInstance.route('/AddPerson/<name>/<age>/<isHealthy>')
def AddPerson(name,age,isHealthy):
	
	person = Person( Name=name, Age=age, IsHealthy=isHealthy )
	person.save()
	
	response = jsonify( "" )
	response.status_code = 200
	
	return response


@AppInstance.route('/GetPersonList')
def GetPersonList():
	
	response = jsonify( results=list(Person.select()) )
	response.status_code = 200
	
	return response

