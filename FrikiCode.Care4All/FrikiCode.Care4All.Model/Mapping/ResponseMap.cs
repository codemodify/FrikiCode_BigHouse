using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.ModelConfiguration;

namespace FrikiCode.Care4All.Model.Mapping
{
    public class ResponseMap : EntityTypeConfiguration<Response>
    {
        public ResponseMap()
        {
            // Primary Key
            this.HasKey(t => t.Id);

            // Properties
            this.Property(t => t.Content)
                .IsRequired();

            // Table & Column Mappings
            this.ToTable("Response");
            this.Property(t => t.Id).HasColumnName("Id");
            this.Property(t => t.AskingUserId).HasColumnName("AskingUserId");
            this.Property(t => t.RespondingUserId).HasColumnName("RespondingUserId");
            this.Property(t => t.MessageId).HasColumnName("MessageId");
            this.Property(t => t.Content).HasColumnName("Content");
        }
    }
}
