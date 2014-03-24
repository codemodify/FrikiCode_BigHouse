
require( "./App.Implementation.js"  );
require( "./App.Services.js"        );
require( "./App.DataModels.js"      );

App.Configure();
App.DefineRoute( "/MyService1"                                  , App.Services.MyService1               );
App.DefineRoute( "/MyService2:v"                                , App.Services.MyService2               );
App.DefineRoute( "/WriteToDb:Id"                                , App.Services.WriteToDb                );
App.DefineRoute( "/ReadFromDb"                                  , App.Services.ReadFromDb               );

App.DefineRoute( "/RegisterWithFacebook:facebook"               , App.Services.RegisterWithFacebook     );
App.DefineRoute( "/PreparePin:parentIdWithPinAndDetails"        , App.Services.PreparePin               );
App.DefineRoute( "/RegisterWithPin:pin"                         , App.Services.RegisterWithPin          );

App.DefineRoute( "/GetUsers:parentUserId"                       , App.Services.GetUsers                 );
App.DefineRoute( "/GetFeedsForUser:userId"                      , App.Services.GetFeedsForUser          );
App.DefineRoute( "/GetMessagesForUser:parentUserIdWithUserId"   , App.Services.GetMessagesForUser       );
App.DefineRoute( "/RegisterAnswerForUser:userIdWithAnswer"      , App.Services.RegisterAnswerForUser    );
App.DefineRoute( "/GetProgressForUser:userId"                   , App.Services.GetProgressForUser       );
App.DefineRoute( "/GetProgressSample"                           , App.Services.GetProgressSample        );

App.Run();
