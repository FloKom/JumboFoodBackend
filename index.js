const pannier = require("./services/pannier")
const client = require("./services/client")
const produit = require("./services/produit")
const packProduit = require("./services/packProduit")
const pointRamassage = require("./services/pointRamassage")
const categorie = require("./services/categorie")
const catalogue = require('./services/catalogue')
const newProducteur = require('./services/fournisseur');
const admin = require('./services/admin')
const rOpert = require('./services/rOperation')
const express = require('express')
const path = require('path');
const app = express()
const multer = require("./middlewares/multer-config")
const port = 3000
const parser = require('body-parser')
const { prisma } = require("@prisma/client")
const proposition = require('./services/proposition')

app.use(parser.json())

app.use((req, res, next) => {
    res.setHeader('Access-Control-Allow-Origin', '*');
    res.setHeader('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content, Accept, Content-Type, Authorization');
    res.setHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, PATCH, OPTIONS');
    res.setHeader('Access-Control-Expose-Headers', 'Content-Range');
    res.header('Content-Range','posts 0-25/100')
    console.log(req.body)
    next();
  });

app.use('/client',client)
app.use('/pannier',pannier)
app.use('/categorie',categorie)
app.use('/pointRamassage',pointRamassage)
app.use('/proposition', proposition)
app.use('/produit',multer.single('image') ,produit)
app.use('/packProduit',multer.single('image') ,packProduit)
app.use('/images', express.static(path.join(__dirname, "images")))




app.post('/producteur', async function(req, res) {
  const pro = await newProducteur.enregistrerFournisseur(req.body)
  console.log(req.body)
  res.status(200).json({pro, message:"producteur cree avec succes"})
});


app.get('/producteur', async function(req, res){
  res.status(200).json(await newProducteur.producteurs)
});


app.delete('/producteur/:id', async function(req, res){
  let id = parseInt(req.params.id)
  res.status(200).json({producteur:await newProducteur.deleteFournisseur(id), message:"producteur supprimer avec succes"})
});


app.post('/producteur/:id/proposer',multer.array('image', 8), async (req, res)=>{
  let photoURL = []
  for(let file of req.files){
    photoURL.push( {photoURL:req.protocol + '://' + req.headers.host + '/' + 'images' + '/' + file.filename})
  }
  console.log(photoURL)
  console.log(req.files)
  const proposerProduit = await newProducteur.proposerProduit(parseInt(req.params.id), req.body, photoURL )
  res.status(200).json(proposerProduit)
})

app.get('/producteur/:id/proposer', async (req,res)=>{
  const produitsProposer = await newProducteur.produitsProposer(parseInt(req.params.id))
  res.status(200).json(produitsProposer)
})

app.get('/producteur/:id', async (req,res)=>{
  let id = parseInt(req.params.id)
  let producteur = await newProducteur.oneFournisseur(id)
  res.status(200).json(producteur)
})

app.put('/producteur/:id', async function(req, res){
  let id = parseInt(req.params.id)
  let producteur = await newProducteur.modifierFournisseur(id, req.body)

  res.json({
    producteur,
    message:"producteur modifie avec succes" 
  })
});

app.get('/producteur/:id/produits', async function(req, res){
  let id = parseInt(req.params.id)
  let produits = await newProducteur.produitsFournisseur(id)
  res.json(produits)
});




app.get('/catalogue', async function(req, res) {
  res.status(200).json(await catalogue.CatalogueDesProduits)
});


app.put('/catalogue/:id', async function(req, res){
  let id = parseInt(req.params.id)
  let updatedCatalogue = await catalogue.modifierCatalogue(id, req.body)
  res.status(200).json({result:updatedCatalogue, message:"catalogue mis a jour avec succes"})
});



app.get('/admin', async function(req, res){
  res.status(200).json(await admin.admins)
});




app.put('/admin/:id',async function(req, res){
  let id = parseInt(req.params.id)
  let updatedAdmin = await admin.modifierAdmin(id,req.body)
  res.status(200).json({result:updatedAdmin, message:"admin mis a jour avec succes"})
});

app.post('/admin', async function(req, res){
  let ad = await admin.enregistrerAdmin(req.body)
  res.status(200).json({result:ad, message:"admin cree avec succes"})
});

app.post('/admin/connect', async (req,res)=>{
  let result = await admin.connect(req.body)
  if(result){
    res.status(200).json("mot de passe accepter")
  }
  else{
    res.status(200).json("mot de passe rejecter")
  }
})

app.get('/manager', async function(req, res){
  res.status(200).json(await rOpert.ROperations)  
});



app.put('/manager/:id', async function(req, res){
  let id = parseInt(req.params.id)
  let updatedROpert = await rOpert.modifierRO(id, req.body)
  res.status(200).json({result:updatedROpert, message:"RO mis a jour avec succes"})
});


app.post('/manager', async function(req, res){
  let ro = await rOpert.enregistrerROperations(req.body)
  res.status(200).json({result:ro, message:"ro cree avec succes"})
});


app.delete('/manager/:id', async function(req, res){
  let id = parseInt(req.params.id)
  let ro = await rOpert.supprimerRO(id)
  res.status(200).json({result:ro, message:"ro supprimer avec succes"})
});

app.post('/manager/connect', async (req,res)=>{
  let result = await rOpert.connect(req.body)
  if(result){
    res.status(200).json("mot de passe accepter")
  }
  else{
    res.status(200).json("mot de passe rejecter")
  }
})

app.get('/bonjour',(req, res)=>{
    res.status(200).json({message:"hello"})
})

app.listen(port, () => console.log("l'application tourne sur le port " + port) )
