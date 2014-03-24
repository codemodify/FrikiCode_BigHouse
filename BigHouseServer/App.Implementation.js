
App = {};

App.Db = null;

App.HouseKeeping = {};

App.HouseKeeping.GenerateGuid = function ()
{
    var uuid = require( 'node-uuid' );

    return uuid.v4();
}

App.HouseKeeping.AppInstance = null;

App.HouseKeeping.OnDbConnect = function()
{
    App.DataModels.Configure();
    App.HouseKeeping.AppInstance.listen("8080");
    console.log( "OK." );
}

App.HouseKeeping.SendResponseToClient = function( response, data )
{
    response.writeHead( 200, {"Content-Type": "application/json"} );
    response.write( JSON.stringify( data ) );
    response.end();
}

App.Configure = function()
{
    var express = require( "express" );
    
    App.HouseKeeping.AppInstance = express();
}

App.DefineRoute = function( route, delegate )
{
    App.HouseKeeping.AppInstance.get
    (
        route,
        function( request, response )
        {
            delegate( request.params, response, App.HouseKeeping.SendResponseToClient );
        }
    );
}

App.Run = function()
{
    App.Db = require( 'mongoose' );
    App.Db.connection.on( 'error', console.error.bind( console, 'DB-Error: ' ) );
    App.Db.connection.once( 'open', App.HouseKeeping.OnDbConnect );
    App.Db.connect('mongodb://bighouse:fckgwrhqq2@ds053597.mongolab.com:53597/bighouse');
}
