using System;
using System.Collections.Generic;

namespace FrikiCode.Care4All.Model
{
    public class User
    {
        public System.Guid Id { get; set; }
        public System.Guid ParentId { get; set; }
        public string ThirdPartyId { get; set; }
        public string PinCode { get; set; }
        public string HelperName { get; set; }
        public string HelperPhoto { get; set; }
    }
}
