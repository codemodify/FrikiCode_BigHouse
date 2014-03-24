using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;

using FrikiCode.Care4All.Model;

namespace FrikiCode.Care4All.Api
{
    [ServiceContract(Namespace="FrikiCode.Care4All.Api")]
    public interface ICommunication
    {
        #region Family

        [OperationContract]
        [WebGet(UriTemplate = "GetUsers/{parentUserId}", ResponseFormat = WebMessageFormat.Json)]
        IEnumerable<User> GetUsers(string parentUserId);

        [OperationContract]
        [WebGet(UriTemplate = "GetFeedsForUser/{userId}", ResponseFormat = WebMessageFormat.Json)]
        IEnumerable<ResponseHelper> GetFeedsForUser(string userId);

        #endregion

        #region Granny

        [OperationContract]
        [WebGet(UriTemplate = "GetMessagesForUser/{parentUserIdWithUserId}", ResponseFormat = WebMessageFormat.Json)]
        IEnumerable<MessageHelper> GetMessagesForUser(string parentUserIdWithUserId);

        [OperationContract]
        [WebGet(UriTemplate = "RegisterAnswerForUser/{userIdWithAnswer}", ResponseFormat = WebMessageFormat.Json)]
        void RegisterAnswerForUser(string userIdWithAnswer);

        #endregion

        [OperationContract]
        [WebGet(UriTemplate = "GetProgressForUser/{userId}", ResponseFormat = WebMessageFormat.Json)]
        string GetProgressForUser(string userId);

        [OperationContract]
        [WebGet(UriTemplate = "GetProgressSample", ResponseFormat = WebMessageFormat.Json)]
        string GetProgressSample();
    }
}
