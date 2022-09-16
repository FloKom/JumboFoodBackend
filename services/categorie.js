const { PrismaClient } = require('@prisma/client');
const exp = require('express');
const router = exp.Router()
const prisma = new PrismaClient()

router.get('/', async (req, res)=>{
    let categories = await prisma.categorieproduit.findMany({
        where:{
            categorieproduitId:null
        },
        include:{
            produit:true,
            other_categorieproduit:{
                include:{
                    produit:true
                }
            }
        }
    })
    res.status(200).json(categories)
})

router.post('/:id', async (req, res)=>{
    let id = parseInt(req.params.id)
    console.log(id);
    if(req.body.categorieproduitId!=undefined){
        req.body.categorieproduitId = parseInt(req.body.categorieproduitId)
    }
    let updatedCategorie = null
    if(req.file != null){
        const photoURL = req.protocol + '://' + req.headers.host + '/' + 'images' + '/' + req.file.filename
        updatedCategorie = await prisma.categorieproduit.update({
            where:{
                id
            },
            data:{
                ...req.body,
                photoURL
            }
        })
    }else{
        updatedCategorie = await prisma.categorieproduit.update({
            where:{
                id
            },
            data:{
                ...req.body
            }
        }) 
    }
    res.status(200).json(updatedCategorie)
})

router.delete('/:id', async (req,res)=>{
    let id = parseInt(req.params.id)
    console.log(id);
    const result = await prisma.categorieproduit.delete({
        where:{
            id
        }
    })
    res.status(200).json(result)
})

router.get('/all', async (req,res)=>{
    const allcatgerorie = await prisma.categorieproduit.findMany()
    console.log(allcatgerorie);
    res.status(200).json(allcatgerorie)
})

router.post('/', async (req, res)=>{
    if(req.body.categorieproduitId!=undefined){
        req.body.categorieproduitId = parseInt(req.body.categorieproduitId)
    }
    let categorie = null
    if(isNaN(parseInt(req.body.categorieproduitId))){
        req.body.categorieproduitId = null
    }
    if(req.file != null){
        const photoURL = req.protocol + '://' + req.headers.host + '/' + 'images' + '/' + req.file.filename
        categorie = await prisma.categorieproduit.create({
            data:{
                ...req.body,
                photoURL
            }
        })
        
    }
    else{
        categorie = await prisma.categorieproduit.create({
            data:{
                ...req.body
            }
        })
    }
    console.log(categorie);
    res.status(200).json(categorie)
})

router.get('/:id', async (req,res)=>{
    let id = parseInt(req.params.id)
    let categorie = await prisma.categorieproduit.findUnique({
        where:{
            id
        }
    })
    res.status(200).json(categorie)
})

router.get('/:id/categories', async (req,res)=>{
    let id = parseInt(req.params.id)
    const categories = prisma.categorieproduit.findMany({
        where:{
            categorieproduitId:id
        }
    })
    res.status(200).json(categories) 
})

router.get('/:id/produits', async (req,res)=>{
    let id =  parseInt(req.params.id)
    const produits = prisma.produit.findMany({
        where:{
            categorieproduitId:id
        }
    })
    res.status(200).json(produits)
})

module.exports = router