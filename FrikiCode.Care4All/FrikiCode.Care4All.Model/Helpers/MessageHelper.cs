using System;
using System.Collections.Generic;

namespace FrikiCode.Care4All.Model
{
    public class MessageHelper
    {
        public Guid AskingUserId { get; set; }
        public string AskingUserPic { get; set; }
        public Message Message { get; set; }
        public string JokeMessage { get; set; }
    }
}
