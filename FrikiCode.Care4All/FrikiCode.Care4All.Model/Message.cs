using System;
using System.Collections.Generic;

namespace FrikiCode.Care4All.Model
{
    public class Message
    {
        public System.Guid Id { get; set; }
        public string Content { get; set; }
        public int Type { get; set; }
    }
}
