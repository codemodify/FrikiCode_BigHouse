
App.DataModels = {};

App.DataModels.Configure = function()
{
    var SchemaOptions = 
    {
        toJSON:
        {
            virtuals: true
        }
    };

    var UserModel               = new App.Db.Schema( 
    {
        Id              : String, // guid
        ParentId        : String, // guid
        ThirdPartyId    : String, // string     
        PinCode         : String, // string     
        HelperName      : String, // string     
        HelperPhoto     : String  // string     

    }, SchemaOptions );
    var ResponseModel           = new App.Db.Schema( 
    {
        Id                  : String, // guid
        AskingUserId        : String, // guid
        RespondingUserId    : String, // guid
        MessageId           : String, // guid
        Content             : String  // string

    }, SchemaOptions );
    var MessageModel            = new App.Db.Schema( 
    {
        Id                  : String, // guid
        Content             : String, // string
        Type                : String  // int

    }, SchemaOptions );
    var MessageActivationModel  = new App.Db.Schema( 
    {
        Id                  : String, // guid
        SourceUserId        : String, // guid
        DestinationUserId   : String, // guid
        MessageId           : String, // guid
        JokeMessageId       : String, // guid
        IsActive            : String  // bool

    }, SchemaOptions );

    App.DataModels.User                 = App.Db.model( "User"              , UserModel                 );
    App.DataModels.Response             = App.Db.model( "Response"          , ResponseModel             );
    App.DataModels.Message              = App.Db.model( "Message"           , MessageModel              );
    App.DataModels.MessageActivation    = App.Db.model( "MessageActivation" , MessageActivationModel    );
}
