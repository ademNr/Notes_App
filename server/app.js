
const express = require("express");
const mongoose = require("mongoose"); 
app = express(); 
const bodyParser = require("body-parser");
const dotenv = require("dotenv");
dotenv.config() ;


// gloabal middlewares
app.use(express.json());
app.use(bodyParser.urlencoded({ extended: true }));


// importing routes
const noteRoute = require("./routes/noteRoute"); 


//using routes
app.use('/api/notes', noteRoute); 




// DB connection 
mongoose.connect(process.env.DB, 
    
    {  useNewUrlParser : true } , 
    ()=>{
      console.log("connected to DB ");
    }
  
  );
  
// server connection 
app.listen(process.env.PORT,()=>{
    console.log("lintening on port ", process.env.PORT);
    
} );

