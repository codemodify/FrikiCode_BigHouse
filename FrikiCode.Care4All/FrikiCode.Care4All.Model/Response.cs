using System;
using System.Collections.Generic;

namespace FrikiCode.Care4All.Model
{
    public class Response
    {
        public System.Guid Id { get; set; }
        public System.Guid AskingUserId { get; set; }
        public System.Guid RespondingUserId { get; set; }
        public System.Guid MessageId { get; set; }
        public string Content { get; set; }
    }
}
