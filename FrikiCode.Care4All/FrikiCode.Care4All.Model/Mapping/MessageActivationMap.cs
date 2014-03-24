using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.ModelConfiguration;

namespace FrikiCode.Care4All.Model.Mapping
{
    public class MessageActivationMap : EntityTypeConfiguration<MessageActivation>
    {
        public MessageActivationMap()
        {
            // Primary Key
            this.HasKey(t => t.Id);

            // Properties
            // Table & Column Mappings
            this.ToTable("MessageActivation");
            this.Property(t => t.Id).HasColumnName("Id");
            this.Property(t => t.SourceUserId).HasColumnName("SourceUserId");
            this.Property(t => t.DestinationUserId).HasColumnName("DestinationUserId");
            this.Property(t => t.MessageId).HasColumnName("MessageId");
            this.Property(t => t.JokeMessageId).HasColumnName("JokeMessageId");
            this.Property(t => t.IsActive).HasColumnName("IsActive");
        }
    }
}
