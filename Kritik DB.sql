
Create Database KritikAppFinal;




Create Table Users 
(
UserId int not null auto_increment,
Email  varchar(100)  not null ,
FirstName varchar(20) not null,
LastName varchar(20)not null ,
Password varchar(20) not null,
ClearanceLevel varchar(6) default "Normal",
isBanned bool default 0,
NumberofReports smallint,

Primary key(UserId)
);



Create Table Regions 
(
District varchar(50) not null,
Governorate varchar(50) not null,
interestsCount int,
primary key (District,Governorate)
);



Create table Places
(
PlaceID int not null auto_increment,
Name varchar(50) not null,
Placetype char(1) not null,
Rating float  check (Rating > 1 and Rating < 5),
StreetAddress text, 
DescriptionText text,
Links varchar(200),
District varchar(50),
Governorate varchar(50),
NumberOfReviews int,
Telephone int,
OwnerId int,

primary key (PlaceId),
Foreign Key (OwnerId) references Users(UserId) On Delete Set Null on Update Cascade ,
Foreign Key (District,Governorate) references Regions(District,Governorate) On Delete Set Null
);



Create Table Requests 
(
RequestID int not null auto_increment,
District varchar(50),
Governorate varchar(50),
RequestText text,
LegalProof  text,
UserID  int,
DateTime datetime,
StreetAddress text, 
ExternalLinks varChar(200),
PlaceName varchar(50),
Telephone int,

Primary Key (RequestId),
Foreign Key (UserID) references Users(UserId) On Delete Cascade,
Foreign Key (District,Governorate) references Regions(District,Governorate) On Delete Set Null
);


Create Table Reviews
(
ReviewId int not null auto_increment,
PlaceId int  not null,
Content text,
DateTime datetime,
Rating float check(Rating > 1 and Rating < 5),
UserID int,
Primary Key (ReviewId,PlaceId,UserId),
Foreign Key (UserID) references Users(UserID) On Delete Cascade,	
Foreign Key (PlaceID) references Places(PlaceID) On Delete Cascade 
);




Create Table Comments
(
CommentId int not null auto_increment ,
ReviewId int,
PlaceId int,
DateTime datetime,
ContentText text,
UserID int,
Primary Key (CommentId,PlaceId),
Foreign Key (UserId) references Users(UserId) On Delete Cascade,
Foreign Key (ReviewId,PlaceId) references Reviews(ReviewId,PlaceId) on Delete Cascade
);

Create Table Reports
(
ReportId int not null auto_increment,
ReportType char(50),
ReportText text,
ReviewId int,
PlaceId int,
CommentId int,

Primary Key (ReportId),
Foreign Key (ReviewId,PlaceId) references Reviews(ReviewId,PlaceId) On Delete Cascade,
Foreign key (CommentId,PlaceId) references Comments(CommentID,PlaceId) On Delete Cascade
);


Create Table Cinema 
(
PlaceId int not null ,
FirstShowTime varchar(20),
SecondShowTime varchar(20),
ThirdShowTime varchar(20),
FourthShowTime varchar(20),
FifthShowTime varchar(20),
SixthShowTime varchar(20),
SeventhShowTime varchar(20),
Primary Key(PlaceId),
Foreign Key(PlaceId)references Places(PlaceId) On Delete Cascade
);
Create Table CoworkingArtSpaces
(
PlaceId int not null ,
PricingPerHour  varChar(10),
InternetSpeed   varchar(10),
AcInLounge	  bool default 0 ,
Primary Key (PlaceId),
Foreign Key (PlaceId) references Places(PlaceId) On Delete Cascade
);


Create Table CafeRestaurant 
(
PlaceId int not null,
MinimumCharge varchar(50),
Foreign Key (PlaceId) references Places(PlaceId) On Delete Cascade
);

Create Table OperatingHours
(
PlaceId int not null ,
WorkingDay  varchar(10) not null,
WorkingFrom char(5),
WorkingTo char(5),
Primary Key (PlaceId,WorkingDay),
Foreign Key (PlaceId) references Places(PlaceId) On Delete Cascade
);


Create Table Photos
(
PlaceId int not null ,
PhotoPath varchar(300) not null ,

Primary Key(PlaceId,PhotoPath),
Foreign Key(PlaceId) references Places(PlaceId) On Delete Cascade
);


Create Table Menu 
(
PlaceId int not null ,
ItemName varchar(50) not null ,
ItemType varchar(50),
ItemPrice varchar(50),
Primary Key (PlaceId,ItemName),
Foreign key (PlaceId) references Places(PlaceId) On Delete Cascade
);

Create Table Movies
(
FilmName varchar(30),
Price int,
ThreeD bool,
ShowTimeNumber char(6),
FilmId int not null auto_increment,
PlaceId int not null ,
primary key(FilmId,PlaceId),
Foreign Key(PlaceId) references Cinema(PlaceId) On Delete Cascade
);



Create Table Rooms 
(
RoomId int not null auto_increment,
PlaceId int not null,
PerHour int,
PerPerson  char(4),
Ac Char(1),
PeopletoFit char(3),

Primary Key (RoomId,PlaceId),
Foreign Key (PlaceId) references CoworkingArtSpaces (PlaceId) On Delete Cascade
);



Create table IndoorEvents 
(
PlaceId int not null,
EventId int not null,
DateOfEvent datetime,
StartFrom  char(5),
EndAt char(5),
Description text,
Primary Key(PlaceId,EventId),
Foreign Key(PlaceId) references CoworkingArtSpaces (PlaceId) On Delete Cascade

);


Create Table Likes
(
Helpful bool not null Default False,
ReviewId int not null,
PlaceId int not null,
UserId int not null,

primary Key(PlaceId,ReviewId,UserId),
Foreign Key(PlaceId,ReviewId,UserId) references Reviews(PlaceId,ReviewId,UserId) On Delete cascade

);


Insert Into Regions(District,Governorate) values ("Dokki","Giza");
Insert Into Users(Email,FirstName,LastName,Password,ClearanceLevel) values ("walidashraf423@gmail.com","waleed","ashraf",123,"ADMIN");
Insert Into Users(Email,FirstName,LastName,Password,ClearanceLevel) values ("whatever@gmail.com","ahmed","mohmaaed",123,"NORMAL");
Insert Into Places (Name,Placetype,StreetAddress,DescriptionText,Links,District,Governorate,Telephone,OwnerId)  values ("Cilantro",1, "5 mesa7a square","its a wonderfullplace to waste money","www.cilantro.com","Dokki","Giza",01118489180,1);
Insert Into Places (Name,Placetype,StreetAddress,DescriptionText,Links,District,Governorate,Telephone,OwnerId)  values ("StarBucks",1, " 7 mesa7a square","its a wonderfullplace to waste money","www.starbuckx.com","Dokki","Giza",01118489180,2);
Insert Into Places (Name,Placetype,StreetAddress,DescriptionText,Links,District,Governorate,Telephone,OwnerId)  values ("Galaxy",2, "8 mesa7a square","its a wonderfullplace to waste money","www.Galaxy.com","Dokki","Giza",01118489180,1);
Insert Into Places (Name,Placetype,StreetAddress,DescriptionText,Links,District,Governorate,Telephone)  values ("Creativo",3, "9 mesa7a square","its a wonderfullplace to waste money","www.Creativo.com","Dokki","Giza",01118489180);
Insert Into CoworkingArtSpaces (PlaceId,PricingPerHour,InternetSpeed,AcInLounge) values(4,5,0,1);
Insert Into Cinema(PlaceId,FirstShowTime,SecondShowTime,ThirdShowtime,FourthShowTime,FifthShowTime,SixthShowTime,SeventhShowTime) values (3,"10->12","12->14","14->16","16->18","18->20","20->22","22->00");
Insert Into CafeRestaurant(PlaceId,MinimumCharge) values(1,20);
Insert Into CafeRestaurant(PlaceId,MinimumCharge) values(2,30);
Insert Into Menu (ItemName,ItemPrice,ItemType,PlaceId) values ("ay7aga1",20,"Macrona",1);
Insert Into Menu (ItemName,ItemPrice,ItemType,PlaceId) values ("ay7aga2",30,"Macrona",1);
Insert Into Menu (ItemName,ItemPrice,ItemType,PlaceId) values ("ay7aga3",40,"Sushi",1);
Insert Into Menu (ItemName,ItemPrice,ItemType,PlaceId) values ("ay7aga4",50,"Sushi",1);
Insert Into Movies(FilmName,Price,ThreeD,ShowTimeNumber,PlaceId) values ("thor",30,0,"10->20",3);
Insert Into Movies(FilmName,Price,ThreeD,ShowTimeNumber,PlaceId) values ("Avengers",30,0,"12->14",3);
Insert Into Movies(FilmName,Price,ThreeD,ShowTimeNumber,PlaceId) values ("Wonder",30,0,"10->20",3);
Insert Into Photos(PhotoPath,PlaceId) values("imgur.com",1);
Insert Into Rooms (PlaceId,PerHour,PerPerson,Ac,PeopletoFit) values (4,20,10,0,500);
Insert Into IndoorEvents(PlaceId,EventId,DateOfEvent,StartFrom,EndAt,Description) values  (4,1,12/5/20,"10:00","17:00","good gathering of nerd");
Insert Into OperatingHours(PlaceId,WorkingDay,WorkingFrom,WorkingTo) values(1,"Monday","10:00","20:22");
Insert Into Requests(District,Governorate,RequestText,LegalProof,UserId,DateTime,StreetAddress,ExternalLinks,PlaceName,Telephone) values("Dokki","Giza", "thanksman", "thanskverymuch",1,"today","55 mo7y street","www.whatever.com","7bebytslm",01118489180);
Insert Into Reviews(ReviewId,PlaceId,Content,Datetime,Rating,UserId) values(1,1,"this place is very good","10:00",5.5,1);
Insert Into Comments(CommentId,PlaceId,ReviewId,Datetime,ContentText,UserId) values (1,1,1,"10:00","ya gmalo ya gmalo",2);
Insert Into Likes (ReviewId,PlaceId,UserId,Helpful) Values (1,1,1,1);
Insert Into Reports (ReportType,ReportText,ReviewId,PlaceId,CommentId) values ("harrasment","sucks",1,1,null);