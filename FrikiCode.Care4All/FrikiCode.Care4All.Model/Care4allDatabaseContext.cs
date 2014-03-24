using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using FrikiCode.Care4All.Model.Mapping;

namespace FrikiCode.Care4All.Model
{
    public class Care4allDatabaseContext : DbContext
    {
        static Care4allDatabaseContext()
        {
            Database.SetInitializer<Care4allDatabaseContext>(null);
        }

		public Care4allDatabaseContext()
			: base("Name=Care4allDatabaseContext")
		{
		}

        public DbSet<Message> Messages { get; set; }
        public DbSet<MessageActivation> MessageActivations { get; set; }
        public DbSet<Response> Responses { get; set; }
        public DbSet<User> Users { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Configurations.Add(new MessageMap());
            modelBuilder.Configurations.Add(new MessageActivationMap());
            modelBuilder.Configurations.Add(new ResponseMap());
            modelBuilder.Configurations.Add(new UserMap());
        }
    }
}
