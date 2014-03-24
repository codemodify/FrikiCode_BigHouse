
from App import TableList
from App import AppInstance

for table in TableList:
	table.create_table( True )

AppInstance.run( debug=True )
