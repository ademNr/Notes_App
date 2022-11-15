
const Note = require("../models/Notes"); 

const getNotes = async(req,res)=>{
    try{
        const notes = await Note.find(); 
        res.status(200).json(notes); 
    }catch(err){
        res.status(400).send(err)

    }

}


const createNote = async(req,res)=>{
     const note =  new Note(req.body); 
    try{
        const savedProduct = await note.save(); 
        res.status(200).json(savedProduct); 

    }catch(err){
        res.status(400).send(err)
    }
}


const updateNote = async(req,res)=>{
    try{
        const updatedNote = await Note.findByIdAndUpdate(req.params.id, {$set: req.body}, {new: true}); 
        res.status(200).json(updatedNote); 

    }catch(err){
        res.status(400).send(err)
    }

}


const deleteNote = async(req,res)=>{
    try{
         await Note.findByIdAndDelete(req.params.id ); 
        res.status(200).send("note deleted"); 

    }catch(err){
        res.status(400).send(err) 
      }
}

module.exports = {getNotes, createNote, updateNote, deleteNote};
