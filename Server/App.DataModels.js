
App.DataModels = {};

App.DataModels.Configure = function()
{
	var schemaOptions = {
	    toJSON: {
	      virtuals: true
	    }
	};

	var userSchema = new App.Db.Schema(
		{
			Id: String,
			Name: String
		},
		schemaOptions
	);

	App.DataModels.User = App.Db.model( "User", userSchema );

	// App.DataModels.User = App.Db.model( "User" ) ? App.Db.model( "User" ) : App.Db.model
	// (
	// 	"User", 
	// 	new App.Db.Schema ({
	// 	    Id: String,
	// 		Name: String
	// 	})
	// );
}
