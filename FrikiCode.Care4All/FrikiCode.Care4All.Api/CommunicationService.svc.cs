using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text;
using System.Reflection;
using System.IO;

using FrikiCode.Care4All.Model;

namespace FrikiCode.Care4All.Api
{
    public class CommunicationService : ICommunication
    {
        #region Family

        public IEnumerable<User> GetUsers(string parentUserId)
        {
            Guid parentId = Guid.Empty;
            Guid.TryParse(parentUserId, out parentId);

            var dbContext = new Care4allDatabaseContext();

            var users = from u in dbContext.Users where u.ParentId == parentId select u;

            return users.ToList();
        }

        public IEnumerable<ResponseHelper> GetFeedsForUser(string userId)
        {
            Guid userIdAsGuid = Guid.Empty;
            Guid.TryParse(userId, out userIdAsGuid);

            var dbContext = new Care4allDatabaseContext();

            var responses = from r in dbContext.Responses where r.RespondingUserId == userIdAsGuid select r;

            var responseList = new List<ResponseHelper>();
            foreach( Response response in responses )
            {
                var messge = from m in dbContext.Messages where m.Id == response.MessageId select m;
                var user = from u in dbContext.Users where u.Id == response.AskingUserId select u;

                var responseHelper = new ResponseHelper();
                    responseHelper.RespondingUserPic = user.ToList()[0].HelperPhoto;
                    responseHelper.Question = messge.ToList()[0].Content;
                    responseHelper.Content = response.Content;

                responseList.Add( responseHelper );
            }

            return responseList;
        }

        #endregion

        #region Granny

        public IEnumerable<MessageHelper> GetMessagesForUser(string parentUserIdWithUserId)
        {
            var parentUserIdWithUserIdAsArray = parentUserIdWithUserId.Split(new char[] { ';' });

            var parentUserIdAsString = parentUserIdWithUserIdAsArray[0];
            var userIdAsString = parentUserIdWithUserIdAsArray[1];

            Guid parentUserId;
            Guid userId;
            Guid.TryParse( parentUserIdAsString, out parentUserId );
            Guid.TryParse( userIdAsString, out userId );

            var dbContext = new Care4allDatabaseContext();

            var messagesToAsk = from ma in dbContext.MessageActivations 
                                where ma.DestinationUserId == userId select ma; // ma.SourceUserId == parentUserId &&

            var messageList = new List<MessageHelper>();
            foreach (MessageActivation messageToAsk in messagesToAsk )
            {
                var message = from m in dbContext.Messages where m.Id == messageToAsk.MessageId select m;
                var jokeMessage = from m in dbContext.Messages where m.Id == messageToAsk.JokeMessageId select m;
                var user = from u in dbContext.Users where u.Id == messageToAsk.SourceUserId select u;

                var messageHelper = new MessageHelper();
                    messageHelper.AskingUserId = user.ToList()[0].Id;
                    messageHelper.AskingUserPic = user.ToList()[0].HelperPhoto;
                    messageHelper.Message = message.ToList()[0];
                    if (message.ToList()[0].Type == 1)
                        messageHelper.JokeMessage = jokeMessage.ToList()[0].Content;

                messageList.Add(messageHelper);
            }

            return messageList;
        }

        /// <summary>
        /// userId;messageId;answer
        /// </summary>
        /// <param name="userIdWithAnswer"></param>
        public void RegisterAnswerForUser(string userIdWithAnswer)
        {
            var userIdWithAnswerAsArray = userIdWithAnswer.Split(new char[] { ';' });

            var userIdAsString = userIdWithAnswerAsArray[0];
            var messageIdAsString = userIdWithAnswerAsArray[1];
            var answer = userIdWithAnswerAsArray[2];

            Guid userId;
            Guid.TryParse( userIdAsString, out userId );

            Guid messageId;
            Guid.TryParse(messageIdAsString, out messageId);

            var dbContext = new Care4allDatabaseContext();

            var messageActivation = from ma in dbContext.MessageActivations where ma.MessageId == messageId select ma;

            var response = new Response() { Id = Guid.NewGuid(), 
                AskingUserId = messageActivation.ToList()[0].SourceUserId,
                RespondingUserId = userId,
                MessageId = messageId,
                Content = answer
            };

            dbContext.Responses.Add( response );
            dbContext.SaveChanges();
        }

        #endregion

        public string GetProgressForUser(string userId)
        {
            Guid userIdAsGuid = Guid.Empty;
            Guid.TryParse(userId, out userIdAsGuid);

            var dbContext = new Care4allDatabaseContext();

            var responses = from r in dbContext.Responses where r.RespondingUserId == userIdAsGuid select r;

            int dayCount = 1;
            var dayCountAsString = new StringBuilder();
            var dataProgress = new StringBuilder();
            foreach (Response response in responses)
            {
                dayCount++;
                dayCountAsString.AppendFormat("{0},", dayCount);

                var message = from m in dbContext.Messages where m.Id == response.MessageId select m;
                var answer = message.ToList()[0].Content;

                // null, null, 30, 45, 69, 70
                if ( answer.Contains("Yes") )
                {
                    dataProgress.AppendFormat( "{0},", 1 );
                }
                else if (answer.Contains("No"))
                {
                    dataProgress.AppendFormat("{0},", -1);
                }
                else
                {
                    dataProgress.AppendFormat("{0},", 0);
                }
            }
            if (dayCountAsString.Length > 0)
                dayCountAsString.Remove(dayCountAsString.Length - 1, 1);
            if (dataProgress.Length > 0)
                dataProgress.Remove(dataProgress.Length - 1, 1);

            var progress = new StringBuilder();
                progress.Append( "{\"data\":[" );
                progress.Append("{ \"data\": [ ");
                progress.Append( dataProgress.ToString() );
                progress.Append( " ], \"title\": \"\" }" ); // { "data": [ null, null, 30, 45, 69, 70 ], "title": "Smith" }
                progress.Append( "],\"x_labels\": [ " );
                progress.Append( dayCountAsString.ToString() );
                progress.Append( " ] }" );

            return progress.ToString();
        }

        public string GetProgressSample()
        {
            return "{    \"data\": [        {            \"data\": [                null,                null,                30,                45,                69,                70             ],            \"title\": \"Smith\"         },        {            \"data\": [                null,                5,                10,                15,                22,                30             ],            \"title\": \"Repub\"         },        {            \"data\": [                40,                55,                56,                66,                40,                -30             ],            \"title\": \"Dem\"         },        {            \"data\": [                null,                89,                90,                85,                60,                -15             ],            \"title\": \"DDD\"         },        {            \"data\": [                66,                77,                55,                33,                50,                -6             ],            \"title\": \"EEE\"         }     ],    \"x_labels\": [        2006,        2007,        2008,        2009,        2010,        2011     ]}";
        }
    }
}
