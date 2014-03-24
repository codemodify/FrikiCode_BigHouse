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
    public interface IUser
    {
        [OperationContract]
        [WebGet(UriTemplate = "RegisterWithFacebook/{facebook}", ResponseFormat = WebMessageFormat.Json)]
        User RegisterWithFacebook(string facebook);

        [OperationContract]
        [WebGet(UriTemplate = "PreparePin/{parentIdWithPinAndDetails}", ResponseFormat = WebMessageFormat.Json)]
        void PreparePin(string parentIdWithPinAndDetails);

        [OperationContract]
        [WebGet(UriTemplate = "RegisterWithPin/{pin}", ResponseFormat = WebMessageFormat.Json)]
        User RegisterWithPin(string pin);
    }
}
