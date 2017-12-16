var express = require('express');
var mysql = require('mysql');
var app= express();
var Model  = require('./model');
var bodyParser = require('body-parser');

app.use(bodyParser.json()); // support json encoded bodies
app.use(bodyParser.urlencoded({ extended: true })); // support encoded bodies
var connection= mysql.createConnection({

  host:'den1.mysql5.gear.host',
  user:'kritik',
  password:'	Wb79?3E109?v',
  database:'kritik'

});

connection.connect(function(error){

  if(error)
  {
    console.log(error.stack);
  }
  else
  {
    console.log('succeded');
  }
});



//PLACES
app.get('/Places/:name',function(req,res)
{
  var Id  ;
  var SentPlace;
  connection.query(Model.RetrieveWithname(),req.params.name,function(error,rows,field){
    if(error)
    {
      console.log("error reteriving data");
    }
    else
    {

        var Place={};
        Place=rows[0];
        Id=rows[0].PlaceID;
        if(rows[0].Placetype === "1")
      {
        connection.query(Model.RetrieveMenu(),Id,function(error,rows,field){
          if(error)
          {
            console.log("error reteriving data");
          }
          else
          {
            var Key = Object.keys(rows);
            var Num = Key.length;//no. of Item
            var Menu={}
            Place.Menu=Menu;
            for (var counter=0 ; counter < Num ; counter++)// this loop to dynamically a make array of distinct Keys of the menu
            {
              var ItemType = rows[counter].ItemType;
              if(Menu[ItemType])
                continue;
              else
                Menu[ItemType]=[];
            }
            for (var counter=0 ; counter < Num ; counter++)// this loop to dynamically put each row with its ItemType in the Meny's ItemType
            {
                var ItemType = rows[counter].ItemType;
                delete rows[counter].ItemType;
                Menu[ItemType].push(rows[counter]);
            }
          }

        });
      }
      else if (rows[0].Placetype === "2")
      {
        connection.query(Model.RetrieveCinema(),Id,function(error,rows,field){
          if(error)
          {
            console.log("error reteriving data");
          }
          else
          {
            var Cinema={};
            Place.Cinema=Cinema;


            connection.query(Model.RetrieveMovies(),Id,function(error,Movierows,MovieField){
                if(error)
                {
                  console.log("error reteriving data");
                }
                else
                {
                  for (var i = 0; i < 7; i++) {
                    Cinema[i]=[];
                }
                  var arr= ["10->12","12->14","14->16","16->18","18->20","20->22","22->00"]
                  var MovieKey= Object.keys(Movierows);
                  var Num = MovieKey.length;
                  for (var i = 0; i <Num; i++) {
                    for (var j = 0; j < Movierows.length; j++) {
                      if(Movierows[i].ShowTimeNumber === arr[j])
                          Cinema[j]=Movierows[i];
                    }
                  }
                }

            });

          }

        });
      }
      else // rows[0].placetype===3
      {
        connection.query(Model.RetrieveCoworkingArtSpace(),Id,function(error,rows,field){
          if(error)
          {
            console.log("error reteriving data ");
          }
          else
          {
            delete rows[0].PlaceId;
            Place.CowrkingArtSpace=rows[0];
            var Rooms=[];
            Place.Rooms=Rooms;
            connection.query(Model.RetrieveRooms(),Id,function(error,Roomsrows,Roomsfield){
              if(error)
              {
                console.log("error reteriving data");
              }
              else
              {
                var Keys = Object.keys(Roomsrows);
                var Num = Keys.length;
                for (var i = 0; i < Num; i++) {
                    delete Roomsrows[i].PlaceId;
                    Place.Rooms.push(Roomsrows[i]);
                 }

             }
           });
          }
        });
      }


      connection.query(Model.RetrievePhotos(),Id,function(error,rows,field){
        if(error)
        {
          console.log("error reteriving data");
        }
        else
        {
           Place.PhotoPath=rows;

          connection.query(Model.RetrieveReviews(),Id,function(error,rows,field){
            if(error)
            {
                console.log("error reteriving data");
            }
            else
            {
              for (var i = 0; i < rows.length; i++) {
                delete rows[i].PlaceId;
              }
              Place.Reviews=rows;
              res.send(Place);

            }

          });

        }

      });

    }
  });
});




app.get('/SearchBytype/:Type',function(req,res){
  connection.query(Model.RetrievePlaceByType(),req.params.Type,function(error,rows,field){
  if(error)
  {
    console.log("error retrieving data");
  }
  else
  {
    var Place=[];
    for (var i = 0; i < rows.length; i++) {
        Place.push(rows[i]);
    }
      res.send(Place);
  }
  });
});


app.get('/',function(req,res){
  connection.query(Model.RetrieveTop10(),function(error,rows,field){
  if(error)
  {
    console.log("error reteriving data");
  }
  else
  {
    var HighRatingPlaces = [];
    for(var i=0;i<rows.length;i++)
    {
        HighRatingPlaces.push(rows[i]);
    }
    res.send(HighRatingPlaces);

  }
    });

});


//Not working
app.get('/Insert/',function(req,res){

  var Max;
  connection.query(Model.RetrieveLastId(),function(error,rows,field){
    if(error)
    {
      console.log("error u idiot");
    }
    else
    {
        Max = console.log(rows[0].Max);
        Max+=Max;
        connection.query(Model.InsertPlace())
    }

  });

});


app.get('/Places/Address/:address',function(req,res){
  connection.query(Model.RetrieveByAddress(req.params.address),function(error,rows,field){
  if(error)
  {
    console.log("error reteriving data");
  }
  else
  {
      for(var i=0;i<rows.length;i++)
      {
          console.log(rows[i]);
      }

  }
    });

});


app.get('/InsertLike',function(req,res){

  var Inserted = {PlaceId:req.query.PlaceId,ReviewId:req.query.ReviewId,UserId:req.query.UserId,Helpful:req.query.Helpful};

  console.log(Inserted);

  connection.query(Model.InsertLike(),Inserted, function(error,rows,field){
    if(error)
    {
      console.log("error u idiot");
    }
    else
    {
      res.send("Inserted");
    }

  });
});


app.get('/Insert/Comment',function(req,res){

  var today = new Date();
  var date = today.getFullYear()+'-'+(today.getMonth()+1)+'-'+today.getDate();

  var Inserted={PlaceId:req.query.PlaceId,ReviewId:req.query.ReviewId,UserId:req.query.UserId,ContentText:req.query.Content,DateTime:date};


  connection.query(Model.InsertComment(),Inserted,function(error,rows,field){
    if(error)
    {
      console.log("error u idiot");
    }
    else
    {
      res.send("Inserted")
    }
  })



});


app.get('/Insert/Review',function(req,res){

  var today = new Date();
  var date = today.getFullYear()+'-'+(today.getMonth()+1)+'-'+today.getDate();

  var Inserted={PlaceId:req.query.PlaceId,UserId:req.query.UserId,Content:req.query.Content,DateTime:date,Rating:req.query.Rating};

  connection.query(Model.InsertReview(),Inserted,function(error,rows,field){
    if(error)
    {
      console.log("error u idiot");
    }
    else
    {
      res.send("Inserted")
    }
  })



});




app.listen(3000);
