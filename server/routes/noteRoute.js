const router = require("express").Router(); 
const noteController = require("../controllers/noteController")



router.post("/",noteController.createNote ); 

router.get("/",noteController.getNotes);

router.put("/:id", noteController.updateNote); 

router.delete("/:id", noteController.deleteNote); 


module.exports = router; 