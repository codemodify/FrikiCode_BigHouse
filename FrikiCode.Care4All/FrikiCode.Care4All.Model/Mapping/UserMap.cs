using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.ModelConfiguration;

namespace FrikiCode.Care4All.Model.Mapping
{
    public class UserMap : EntityTypeConfiguration<User>
    {
        public UserMap()
        {
            // Primary Key
            this.HasKey(t => t.Id);

            // Properties
            // Table & Column Mappings
            this.ToTable("User");
            this.Property(t => t.Id).HasColumnName("Id");
            this.Property(t => t.ParentId).HasColumnName("ParentId");
            this.Property(t => t.ThirdPartyId).HasColumnName("ThirdPartyId");
            this.Property(t => t.PinCode).HasColumnName("PinCode");
            this.Property(t => t.HelperName).HasColumnName("HelperName");
            this.Property(t => t.HelperPhoto).HasColumnName("HelperPhoto");
        }
    }
}
