
App.Services = {};

App.Services.MyService1 = function (params, response, responseDelegate)
{
    responseDelegate( response, "qweasdzxc" );
}

App.Services.MyService2 = function (params, response, responseDelegate)
{
    responseDelegate( response, "qweasdzxc" + params.v );
}

App.Services.WriteToDb = function (params, response, responseDelegate)
{
    var user = new App.DataModels.User();
        user.Id = "5f3d20e1-dd9e-436a-8659-24fd7c0c0f0b";
        user.HelperName = params.Id;
        user.save
        (
            function( err, user )
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

App.Services.ReadFromDb = function (params, response, responseDelegate)
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

// User Service
// ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ----
App.Services.RegisterWithFacebook = function( params, response, responseDelegate )
{
    // 0          1    2
    // facebookID;Name;Photo
    // Ex: 123123123123123;Jane;ASDQWPOKDOIJUIUu86234b23j423423k42=

    var facebookAsArray     = params.facebook.split( ";" );

    var facebookIdAsString  = facebookAsArray[ 0 ];
    var name                = facebookAsArray[ 1 ];
    var photoAsBase64       = facebookAsArray[ 2 ];

    App.DataModels.User.find // for existing record
    (
        { Id: facebookIdAsString },
        function( err, users )
        {
            if( err )
            {
                console.log( err );
                responseDelegate( response, null );
            }
            else
            {
                if( users.length !== 0 ) // record was found, use it
                {
                    responseDelegate( response, users[ 0 ] );
                }
                else
                {
                    var user = new App.DataModels.User();
                        user.Id             = App.HouseKeeping.GenerateGuid();
                        user.ParentId       = "";
                        user.ThirdPartyId   = facebookIdAsString;
                        user.PinCode        = "";
                        user.HelperName     = name;
                        user.HelperPhoto    = photoAsBase64;
                        user.save
                        (
                            function( err, user )
                            {
                                if( err ) 
                                {
                                    console.log( err );
                                    responseDelegate( response, null );
                                }
                                else
                                {
                                    responseDelegate( response, user );
                                }
                            }
                        );
                }
            }
        }
    );
}

App.Services.PreparePin = function( params, response, responseDelegate )
{
    // 0        1   2           3
    // parentID;pin;GrandmaName;Photo
    // Ex: {xxxx-xxxx-xxxx-xxxx};1401;Jane;ASDQWPOKDOIJUIUu86234b23j423423k42=

    var parentIdWithPinAndDetailsAsArray = params.parentIdWithPinAndDetails.split( ";" );

    var parentId = parentIdWithPinAndDetailsAsArray[ 0 ];

    // Get Grand Ma-s details
    var pin             = parentIdWithPinAndDetailsAsArray[ 1 ];
    var grandmaName     = parentIdWithPinAndDetailsAsArray[ 2 ];
    var photoAsBase64   = parentIdWithPinAndDetailsAsArray[ 3 ];

    var user = new App.DataModels.User();
        user.Id             = App.HouseKeeping.GenerateGuid();
        ParentId            = parentId;
        PinCode             = pin;
        user.HelperName     = grandmaName;
        user.HelperPhoto    = photoAsBase64;
        user.save
        (
            function( err, user )
            {
                if( err ) 
                {
                    console.log( err );
                    responseDelegate( response, null );
                }
                else
                {
                    // region Generate Default Settings

                    var dictionary =
                    {
                        "c1d80f1c-3c08-4b10-8df1-2ad0b05f8cc4" : "77227f63-76c9-498c-82ac-5f71e88c9eb0",
                        "fbe2807a-de4e-4cb2-8bec-7c875d97aff0" : "00000000-0000-0000-0000-000000000000",
                        "e99a2ab8-b239-4920-a074-f33aa0da4967" : "fd7a4513-e93c-41db-b54f-86cdda3bffbc",
                        "ff9c94b2-c28c-444a-bb4c-10eb8b3c6731" : "00000000-0000-0000-0000-000000000000",
                        "a3ebd50c-35ec-4f2c-a00f-9151d2fff8a3" : "fc1109a3-e73d-47b5-8bda-ddcdcbee154b",
                        "a92d978c-4a9a-4c5b-a128-08b8ff02d86e" : "992b7cd3-83be-47c5-8abd-a9d3b8424d8b",
                        "9ecd3f15-d0e3-4329-be35-9b0992d622a9" : "a15f8ae7-92c4-4b27-bf88-582d829cc5a9",
                        "76e2b960-4f9a-4b0b-9e33-4c49b24113e9" : "00000000-0000-0000-0000-000000000000"
                    }

                    for( var key in dictionary )
                    {
                        var messageActivation = new App.DataModels.MessageActivation();
                            messageActivation.Id                = new App.DataModels.MessageActivation();
                            messageActivation.SourceUserId      = parentId;
                            messageActivation.DestinationUserId = user.Id;
                            messageActivation.MessageId         = key;
                            messageActivation.JokeMessageId     = value;
                            messageActivation.IsActive          = "1";

                            messageActivation.save
                            (
                                function( err, users )
                                {
                                    if( err ) 
                                    {
                                        console.log( err );
                                    }
                                    else
                                    {}
                                }
                            );
                    }

                    responseDelegate( response, null );
                }
            }
        );
}

App.Services.RegisterWithPin = function( params, response, responseDelegate )
{
    var pin = params.pin;

    App.DataModels.User.find // for existing record
    (
        { PinCode: pin },
        function( err, users )
        {
            if( err )
            {
                console.log( err );
                responseDelegate( response, null );
            }
            else
            {
                if( users.length !== 0 ) // record was found, use it
                {
                    var user = users[ 0 ];
                        user.PinCode = string.Empty;
                        user.save
                        (
                            function( err, user )
                            {
                                if( err ) 
                                {
                                    console.log( err );
                                    responseDelegate( response, null );
                                }
                                else
                                {
                                    responseDelegate( response, user );
                                }
                            }
                        );

                    return ;
                }
                else
                {
                    responseDelegate( response, null );
                }
            }
        }
    );
}

// Communication - Family Service
// ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ----
App.Services.GetUsers = function( params, response, responseDelegate )
{
    // C# => IEnumerable<User> GetUsers( string parentUserId )

    var parentId = params.parentUserId;

    App.DataModels.User.find
    (
        { ParentId: parentId },
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
}

App.Services.GetFeedsForUser = function( params, response, responseDelegate )
{
    // C# => IEnumerable<ResponseHelper> GetFeedsForUser(string userId)
    // public class ResponseHelper
    // {
    //     public string RespondingUserPic { get; set; }
    //     public string Question { get; set; }
    //     public string Content { get; set; }
    // }

    var userId = params.userId;

    App.DataModels.Response.find
    (
        { RespondingUserId: userId },
        function( err, responses )
        {
            if( err )
            {
                console.log( err );
                responseDelegate( response, null );
            }
            else
            {
                if( responses.length !== 0 )
                {
                    // collect needed info to make next queries in db
                    var messageIdList = new Array();
                    var userIdList  = new Array();
                    for( var i=0; i < responses.length; i++ )
                    {
                        messageIdList.push( responses[i].MessageId      );
                        userIdList   .push( responses[i].AskingUserId   );
                    }

                    // make requests to have all the data in place
                    var messages = App.DataModels.Messages.find( {} );
                        messages.where( 'MessageId' ).in( messageIdList );
                        messages.exec( function ( err, foundMessages )
                        {
                            if( err ){ console.log( err ); responseDelegate( response, null ); } else 
                            {
                                var userIdList = App.DataModels.User.find( {} );
                                userIdList.where( 'Id' ).in( userIdList );
                                userIdList.exec( function ( err, foundUsers ) 
                                {
                                    if( err )
                                    {
                                        console.log( err ); 
                                        responseDelegate( response, null ); 
                                    }
                                    else 
                                    {
                                        var responseList = new Array(); // new List<MessageHelper>();

                                        for( var i=0; i < responses.length; i++ )
                                        {
                                            var message = null;
                                            var user    = null;

                                            // get the data
                                            for( var j = 0; j < foundMessages.length; j++ )
                                            {
                                                if( foundMessages[j].MessageId === responses[i].MessageId )
                                                {
                                                    message = foundMessages[j];
                                                    break;
                                                }
                                            }
                                            for( var k = 0; k < foundUsers.length; k++ )
                                            {
                                                if ( foundUsers[k].Id === responses[k].AskingUserId )
                                                {
                                                    user = responses[k];
                                                    break;
                                                }
                                            }

                                            var responseHelper = 
                                            {
                                                "RespondingUserPic" : user.Id,
                                                "Question"          : message.Content,
                                                "Content"           : responses[i].Content
                                            };

                                            responseList.Add( responseHelper );
                                        }

                                        responseDelegate( response, responseList ); 
                                    }
                                });
                            };
                        });
                }
                else
                {
                    responseDelegate( response, new Array() );
                }
            }
        }
    );
}

// Communication - Granny Service
// ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ----
App.Services.GetMessagesForUser = function( params, response, responseDelegate )
{
    // C# => IEnumerable<MessageHelper> GetMessagesForUser( string parentUserIdWithUserId );
    // public class MessageHelper
    // {
    //     public Guid AskingUserId { get; set; }
    //     public string AskingUserPic { get; set; }
    //     public Message Message { get; set; }
    //     public string JokeMessage { get; set; }
    // }

    var parentUserIdWithUserIdAsArray   = params.parentUserIdWithUserId.split( ";" );
    var parentUserId                    = parentUserIdWithUserIdAsArray[ 0 ];
    var userId                          = parentUserIdWithUserIdAsArray[ 1 ];

    App.DataModels.MessageActivation.find // for existing record
    (
        { DestinationUserId: userId },
        function( err, messagesToAsk )
        {
            if( err )
            {
                console.log( err );
                responseDelegate( response, null );
            }
            else
            {
                if( messagesToAsk.length !== 0 )
                {
                    // collect needed info to make next queries in db
                    var messageIdList = new Array();
                    var jokeMessageIdList = new Array();
                    var sourceUserIdList  = new Array();
                    for( var i=0; i < messagesToAsk.length; i++ )
                    {
                        messageIdList.push( messagesToAsk[i].MessageId      );
                        jokeMessageIdList.push( jokeMessageId[i].JokeMessageId  );
                        sourceUserIdList .push( jokeMessageId[i].SourceUserId   );
                    }

                    // make requests to have all the data in place
                    var messages = App.DataModels.Messages.find( {} );
                        messages.where( 'MessageId' ).in( messageIdList );
                        messages.exec( function ( err, foundMessages )
                        {
                            if( err ){ console.log( err ); responseDelegate( response, null ); } else {

                            var jokeMessages = App.DataModels.Messages.find( {} );
                                jokeMessages.where( 'JokeMessageId' ).in( jokeMessageIdList );
                                jokeMessages.exec( function ( err, foundJokeMessages ) 
                                {
                                    if( err ){ console.log( err ); responseDelegate( response, null ); } else {

                                    var users = App.DataModels.Messages.find( {} );
                                        users.where( 'SourceUserId' ).in( sourceUserIdList );
                                        users.exec( function ( err, foundUsers ) 
                                        {
                                            if( err ){ console.log( err ); responseDelegate( response, null ); } else {

                                            var messageList = new Array(); // new List<MessageHelper>();

                                            for( var i=0; i < messagesToAsk.length; i++ )
                                            {
                                                var message     = null;
                                                var jokeMessage = null;
                                                var user        = null;

                                                // get the data
                                                for( var j = 0; j < messages.length; j++ )
                                                {
                                                    if( messages[j].MessageId === messagesToAsk[i].MessageId )
                                                    {
                                                        message = messages[j];
                                                        break;
                                                    }
                                                }
                                                for( var k = 0; k < jokeMessages.length; k++ )
                                                {
                                                    if( jokeMessages[k].JokeMessageId === messagesToAsk[k].JokeMessageId )
                                                    {
                                                        jokeMessage = jokeMessage[k];
                                                        break;
                                                    }
                                                }
                                                for( var l = 0; l < users.length; l++ )
                                                {
                                                    if ( users[l].SourceUserId === messagesToAsk[l].SourceUserId )
                                                    {
                                                        user = users[l];
                                                        break;
                                                    }
                                                }

                                                var messageHelper = 
                                                {
                                                    "AskingUserId"  : user.Id,
                                                    "AskingUserPic" : user.HelperPhoto,
                                                    "Message"       : message,
                                                    "JokeMessage"   : message.Type === "1" ? jokeMessage.Content : ""
                                                };

                                                messageList.Add( messageHelper );
                                            }

                                            responseDelegate( response, messageList ); }
                                        }) };
                                }) };
                        });
                }
                else
                {
                    responseDelegate( response, new Array() );
                }
            }
        }
    );
}

App.Services.RegisterAnswerForUser = function( params, response, responseDelegate )
{
    var userIdWithAnswerAsArray = params.userIdWithAnswer.split( ";" );

    var userId      = userIdWithAnswerAsArray[ 0 ];
    var messageId   = userIdWithAnswerAsArray[ 1 ];
    var answer      = userIdWithAnswerAsArray[ 2 ];

    App.DataModels.MessageActivation.find // for existing record
    (
        { MessageId: messageId },
        function( err, messageActivations )
        {
            if( err )
            {
                console.log( err );
                responseDelegate( response, null );
            }
            else
            {
                if( messageActivations.length === 0 )
                {
                    responseDelegate( response, null );
                }
                else
                {
                    var response = new App.DataModels.Response();
                        response.Id                 = App.HouseKeeping.GenerateGuid();
                        response.AskingUserId       = messageActivation[0].SourceUserId;
                        response.RespondingUserId   = userId;
                        response.MessageId          = messageId;
                        response.Content            = answer;
                        response.save
                        (
                            function( err, response )
                            {
                                if( err ) 
                                {
                                    console.log( err );
                                    responseDelegate( response, null );
                                }
                                else
                                {
                                    responseDelegate( response, response );
                                }
                            }
                        );
                }
            }
        }
    );
}

// Communication - Other Service
// ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ----
App.Services.GetProgressForUser = function( params, response, responseDelegate )
{
    var userId = params.userId;

    // FIXME: Imeplement
}

App.Services.GetProgressSample = function( params, response, responseDelegate )
{
    var sameplData = 
    {
        "data": [ { "data": [ null, null, 30, 45, 69, 70 ], "title": "Smith" },
                  { "data": [ null, 5, 10, 15, 22, 30 ], "title": "Repub" },
                  { "data": [ 40, 55, 56, 66, 40, -30 ], "title": "Dem" },
                  { "data": [ null, 89, 90, 85, 60, -15 ], "title": "DDD" },
                  { "data": [ 66, 77, 55, 33, 50, -6 ], "title": "EEE" } ],
        "x_labels": [ 2006, 2007, 2008, 2009, 2010, 2011 ]
    };

    responseDelegate( response, sameplData );
}
