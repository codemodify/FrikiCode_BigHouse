
App.Routes = {};

App.Routes.MyService1 = function ( params, response, responseDelegate )
{
	responseDelegate( response, "qweasdzxc" );
}

App.Routes.MyService2 = function ( params, response, responseDelegate )
{
	responseDelegate( response, "qweasdzxc" + params.v );
}

App.Routes.WriteToDb = function ( params, response, responseDelegate )
{	
	var user = new App.DataModels.User();
		user.Id = "5f3d20e1-dd9e-436a-8659-24fd7c0c0f0b";
		user.Name = params.UserName;
		user.save
		(
			function( err, users )
			{
				if( err ) 
				{
					console.log( err );
					responseDelegate( response, false );
				}
				else
				{
					responseDelegate( response, true );
				}
			}
		);
}

App.Routes.ReadFromDb = function ( params, response, responseDelegate )
{
	App.DataModels.User.find
	(
		{},
		function( err, users )
		{
			if( err )
			{
				console.log( err );
				responseDelegate( response, null );
			}
			else
			{
				responseDelegate( response, users );
			}
		}
	);

	// Kitten.find({ name: /^Fluff/ }, callback);	
}
