using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text;

using FrikiCode.Care4All.Model;

namespace FrikiCode.Care4All.Api
{
    public class UserService : IUser
    {
        /// <summary>
        /// Input 123123123123123;Jane;ASDQWPOKDOIJUIUu86234b23j423423k42=
        /// 0          1    2
        /// facebookID;Name;Photo
        /// </summary>
        /// <param name="RegisterWithFacebook"></param>
        public User RegisterWithFacebook(string facebook)
        {
            var facebookAsArray = facebook.Split(new char[] { ';' });

            var facebookIdAsString = facebookAsArray[0];
            var name = facebookAsArray[1];
            var photoAsBase64 = facebookAsArray[2];

            var dbContext = new Care4allDatabaseContext();

            var existingUser = from u in dbContext.Users where facebookIdAsString.Equals( u.ThirdPartyId ) select u;

            User user = null;
            if ( existingUser != null && existingUser.ToList().Count > 0 )
            {
                user = existingUser.ToList()[0];
            }
            else
            {
                user = new User() { Id = Guid.NewGuid(), ParentId = Guid.Empty, ThirdPartyId = facebookIdAsString, PinCode = string.Empty, HelperName = name, HelperPhoto = photoAsBase64 };

                dbContext.Users.Add(user);
                dbContext.SaveChanges();
            }

            return user;
        }

        /// <summary>
        /// Input {xxxx-xxxx-xxxx-xxxx};1401;Jane;ASDQWPOKDOIJUIUu86234b23j423423k42=
        /// 0        1   2           3
        /// parentID;pin;GrandmaName;Photo
        /// </summary>
        /// <param name="parentIdWithPinAndDetails"></param>
        public void PreparePin(string parentIdWithPinAndDetails)
        {
            var parentIdWithPinAndDetailsAsArray = parentIdWithPinAndDetails.Split(new char[] { ';' });

            #region Get Parent Id

            var parentIdAsString = parentIdWithPinAndDetailsAsArray[0];
            Guid parentId = Guid.Empty;
            Guid.TryParse( parentIdAsString, out parentId );
            
            #endregion

            #region Get Grand Ma-s details

            var pin = parentIdWithPinAndDetailsAsArray[1];
            var grandmaName = parentIdWithPinAndDetailsAsArray[2];
            var photoAsBase64 = parentIdWithPinAndDetailsAsArray[3];

            var user = new User() { Id = Guid.NewGuid(), ParentId = parentId, PinCode = pin, HelperName=grandmaName, HelperPhoto=photoAsBase64 };

            var dbContext = new Care4allDatabaseContext();
                dbContext.Users.Add(user);
                dbContext.SaveChanges();

            #endregion

            #region Generate Default Settings

            var dictionary = new Dictionary<string,string>();
                dictionary.Add( "c1d80f1c-3c08-4b10-8df1-2ad0b05f8cc4", "77227f63-76c9-498c-82ac-5f71e88c9eb0" );
                dictionary.Add( "fbe2807a-de4e-4cb2-8bec-7c875d97aff0", "00000000-0000-0000-0000-000000000000" );
                dictionary.Add( "e99a2ab8-b239-4920-a074-f33aa0da4967", "fd7a4513-e93c-41db-b54f-86cdda3bffbc" );
                dictionary.Add( "ff9c94b2-c28c-444a-bb4c-10eb8b3c6731", "00000000-0000-0000-0000-000000000000" );
                dictionary.Add( "a3ebd50c-35ec-4f2c-a00f-9151d2fff8a3", "fc1109a3-e73d-47b5-8bda-ddcdcbee154b" );
                dictionary.Add( "a92d978c-4a9a-4c5b-a128-08b8ff02d86e", "992b7cd3-83be-47c5-8abd-a9d3b8424d8b" );
                dictionary.Add( "9ecd3f15-d0e3-4329-be35-9b0992d622a9", "a15f8ae7-92c4-4b27-bf88-582d829cc5a9" );
                dictionary.Add( "76e2b960-4f9a-4b0b-9e33-4c49b24113e9", "00000000-0000-0000-0000-000000000000" );

            foreach( string key in dictionary.Keys )
            {
                var value = dictionary[ key ];

                dbContext.MessageActivations.Add
                (
                    new MessageActivation()
                    {
                        Id = Guid.NewGuid(),
                        SourceUserId = parentId,
                        DestinationUserId = user.Id,
                        MessageId = Guid.Parse( key ),
                        JokeMessageId = Guid.Parse( value ),
                        IsActive = true
                    }
                );

            }
            dbContext.SaveChanges();

            

//82594a4e-dcd1-4d53-84a7-0bc8791ea244	45ca8921-a116-4a99-817d-36c6a64c2f52	86207dc0-b3c8-4d96-8546-49c258d5b638	c1d80f1c-3c08-4b10-8df1-2ad0b05f8cc4	77227f63-76c9-498c-82ac-5f71e88c9eb0	True
//90769f17-6b45-436f-9e73-3509a8621251	45ca8921-a116-4a99-817d-36c6a64c2f52	86207dc0-b3c8-4d96-8546-49c258d5b638	fbe2807a-de4e-4cb2-8bec-7c875d97aff0	00000000-0000-0000-0000-000000000000	True
//b5357955-592f-400b-bf8a-3a0e5a910c90	45ca8921-a116-4a99-817d-36c6a64c2f52	86207dc0-b3c8-4d96-8546-49c258d5b638	e99a2ab8-b239-4920-a074-f33aa0da4967	fd7a4513-e93c-41db-b54f-86cdda3bffbc	True
//77227f63-76c9-498c-82ac-5f71e88c9eb0	45ca8921-a116-4a99-817d-36c6a64c2f52	86207dc0-b3c8-4d96-8546-49c258d5b638	ff9c94b2-c28c-444a-bb4c-10eb8b3c6731	00000000-0000-0000-0000-000000000000	True
//fd7a4513-e93c-41db-b54f-86cdda3bffbc	45ca8921-a116-4a99-817d-36c6a64c2f52	86207dc0-b3c8-4d96-8546-49c258d5b638	a3ebd50c-35ec-4f2c-a00f-9151d2fff8a3	fc1109a3-e73d-47b5-8bda-ddcdcbee154b	True
//a20f5b8d-9b26-40b6-bfc6-a7e3bf860a05	45ca8921-a116-4a99-817d-36c6a64c2f52	86207dc0-b3c8-4d96-8546-49c258d5b638	a92d978c-4a9a-4c5b-a128-08b8ff02d86e	992b7cd3-83be-47c5-8abd-a9d3b8424d8b	True
//2fab1b19-2e3b-4e83-905c-b97ab311af89	45ca8921-a116-4a99-817d-36c6a64c2f52	86207dc0-b3c8-4d96-8546-49c258d5b638	9ecd3f15-d0e3-4329-be35-9b0992d622a9	a15f8ae7-92c4-4b27-bf88-582d829cc5a9	True
//e99a2ab8-b239-4920-a074-f33aa0da4967	45ca8921-a116-4a99-817d-36c6a64c2f52	86207dc0-b3c8-4d96-8546-49c258d5b638	76e2b960-4f9a-4b0b-9e33-4c49b24113e9	00000000-0000-0000-0000-000000000000	True



            #endregion
        }

        public User RegisterWithPin(string pin)
        {
            var dbContext = new Care4allDatabaseContext();

            var arrayOfValues = from u in dbContext.Users where u.PinCode == pin select u;
            
            var user = arrayOfValues.ToArray()[0];

            dbContext.Users.Remove( user );
            dbContext.SaveChanges();

            user.PinCode = string.Empty;
            dbContext.Users.Add(user);
            dbContext.SaveChanges();
            
            return user;
        }
    }
}
