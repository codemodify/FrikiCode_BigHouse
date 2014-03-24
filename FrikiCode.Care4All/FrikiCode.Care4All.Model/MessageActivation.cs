using System;
using System.Collections.Generic;

namespace FrikiCode.Care4All.Model
{
    public class MessageActivation
    {
        public System.Guid Id { get; set; }
        public System.Guid SourceUserId { get; set; }
        public System.Guid DestinationUserId { get; set; }
        public System.Guid MessageId { get; set; }
        public System.Guid JokeMessageId { get; set; }
        public bool IsActive { get; set; }
    }
}
