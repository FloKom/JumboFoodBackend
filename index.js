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
const payment = require('./services/paymentNotif')
const multer = require("./middlewares/multer-config")
const port = 3000
const parser = require('body-parser')
const proposition = require('./services/proposition')
app.use(parser.json())
app.use((req, res, next) => {
    res.setHeader('Access-Control-Allow-Origin', '*');
    res.setHeader('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content, Accept, Content-Type, Authorization');
    res.setHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, PATCH, OPTIONS');
    res.setHeader('Access-Control-Expose-Headers', 'Content-Range');
    next();
  });
app.use('/images', express.static(path.join(__dirname, "images")))
app.use((req, res, next)=>{
    res.header('Content-Range','posts 0-25/100')
    res.header('Content-Length', '99');
    res.append('X-Total-Count', '319');
    res.append('Access-Control-Expose-Headers', 'X-Total-Count');
    next();
})
app.use('/client',client)
app.use('/payment', payment)
app.use('/pannier',pannier)
app.use('/categorie', multer.single('image'),categorie)
app.use('/pointRamassage', multer.single('image'),pointRamassage)
app.use('/proposition', multer.array('image', 8), proposition)
app.use('/produit',multer.single('image') ,produit)
app.use('/packProduit',multer.single('image') ,packProduit)
app.post('/producteur', async function(req, res) {
  const pro = await newProducteur.enregistrerFournisseur(req.body)
  console.log(req.body)
  res.status(200).json(pro)
});
app.get('/producteur', async function(req, res){
  const producteurs = await newProducteur.producteurs(req.query)
  console.log('====================================');
  console.log(req.query);
  console.log('====================================');
  res.status(200).json(producteurs)
});

app.delete('/producteur/:id', async function(req, res){
  let id = parseInt(req.params.id)
  try{
    const deletedSupplier = await newProducteur.deleteFournisseur(id)
  }
  catch(e){
    console.log(e)
  }
  
  res.status(200).json(deletedSupplier)
});


app.post('/producteur/:id/proposer',multer.array('image', 100), async (req, res)=>{
  let photoURL = []
  for(let file of req.files){
    photoURL.push( {photoURL:req.protocol + '://' + req.headers.host + '/' + 'images' + '/' + file.filename})
  }
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
  res.json(producteur)
});

app.get('/producteur/:id/produits', async function(req, res){
  let id = parseInt(req.params.id)
  let produits = await newProducteur.produitsFournisseur(id)
  res.json(produits)
});




app.get('/catalogue', async function(req, res) {
  const catalogues = await catalogue.CatalogueDesProduits()
  res.status(200).json(catalogues)
});


app.put('/catalogue/:id', async function(req, res){
  let id = parseInt(req.params.id)
  let updatedCatalogue = await catalogue.modifierCatalogue(id, req.body)
  res.status(200).json(updatedCatalogue)
});



app.get('/admin', async function(req, res){
  const admins = await admin.admins()
  res.status(200).json(admins)
});




app.put('/admin/:id',async function(req, res){
  let id = parseInt(req.params.id)
  let updatedAdmin = await admin.modifierAdmin(id,req.body)
  res.status(200).json(updatedAdmin)
});

app.post('/admin', async function(req, res){
  let ad = await admin.enregistrerAdmin(req.body)
  res.status(200).json(ad)
});

app.post('/admin/connect', async (req,res)=>{
  let result = await admin.connect(req.body)
  if(result){
    res.status(200).json("mot de passe accepter")
  }
  else{
    res.status(400).json("email ou mot de passe rejecter")
  }
})

app.get('/manager', async function(req, res){
  const managers = await rOpert.ROperations()
  res.status(200).json(managers)  
});



app.put('/manager/:id', async function(req, res){
  let id = parseInt(req.params.id)
  let updatedROpert = await rOpert.modifierRO(id, req.body)
  res.status(200).json(updatedROpert)
});


app.post('/manager', async function(req, res){
  let ro = await rOpert.enregistrerROperations(req.body)
  res.status(200).json(ro)
});


app.delete('/manager/:id', async function(req, res){
  let id = parseInt(req.params.id)
  let ro = await rOpert.supprimerRO(id)
  res.status(200).json(ro)
});

app.post('/manager/connect', async (req,res)=>{
  let result = await rOpert.connect(req.body)
  if(result){
    res.status(200).json("mot de passe accepter")
  }
  else{
    res.status(400).json("mot de passe rejecter")
  }
})

app.get('/bonjour',(req, res)=>{
    res.status(200).json({message:"hello"})
})

app.listen(port, () => console.log("l'application tourne sur le port " + port) )
