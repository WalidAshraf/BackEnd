


// Places
module.exports.RetrieveTop10 = function (){ return "Select * From Places Where Rating = 5 "};

module.exports.RetrieveCinema = function(){return "Select * From Cinema where PlaceId=?"};

module.exports.RetrieveMovies= function(){return "Select * From Movies Where PlaceId=?"};

module.exports.RetrieveCoworkingArtSpace= function(){return "Select * from coworkingartspaces where PlaceId=?"};// the name of the table is wrong

module.exports.RetrieveRooms = function(){return "Select * from Rooms Where PlaceId=?"};

module.exports.RetrieveWithname = function(){return "Select* From Places Where Name=?"};

module.exports.RetrieveLastId= function(){return "Select Max(PlaceId) as Max from Places "};

module.exports.RetrieveByAddress = function(name){return "Select* From Places Where StreetAddress Like'%"+name+"%'"};

module.exports.RetrievePhotos = function(){return "Select PhotoPath from Photos where PlaceId =?" };

module.exports.RetrieveMenu = function(){return "Select ItemName,ItemType,ItemPrice From Menu where PlaceID=? Order By ItemType "}

module.exports.RetrieveReviews = function(){ return "Select* from Reviews where PlaceId=?" };

module.exports.RetrievePlaceByType = function(){return "Select PlaceID,Name,Rating,District,Governorate,Telephone From Places where PlaceType=? Order By Rating "};//Avatar should be added in database

module.exports.InsertLike = function(){return "Insert Into likes set ? "};

module.exports.InsertComment = function(){return "Insert Into comments set ?"};


module.exports.InsertReview= function(){return "Insert into Reviews set ?"};

module.exports.InsertPlace = function( Name, Placetype, Rating=null, StreetAddress=null, DescriptionText=null, Links = null,  District=null,
 Governorate=null,  NumberOfReviews=null,  Telephone=null,  OwnerId=null){return "Insert into Places values("+Name+","+PlaceType+","+Rating+","
+StreetAddress+","+DescriptionText+","+Links+","+District+","+Governorate+","+NumberOfReviews+","+Telephone+","+OwnerId+")"};










module.exports.RetrieveComments = function(Id){return "Select* from Comments,Places Where PlaceId="+Id };
