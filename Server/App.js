
require( "./App.Implementation.js" );
require( "./App.Routes.js" );
require( "./App.DataModels.js" );

App.Configure();
App.DefineRoute( "/MyService1"			, App.Routes.MyService1 );
App.DefineRoute( "/MyService2:v"		, App.Routes.MyService2 );
App.DefineRoute( "/WriteToDb:UserName"	, App.Routes.WriteToDb  );
App.DefineRoute( "/ReadFromDb"			, App.Routes.ReadFromDb );
App.Run();
