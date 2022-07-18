const { PrismaClient } = require('@prisma/client');
const exp = require('express');
const router = exp.Router()
const prisma = new PrismaClient()

router.get('/', async (req, res)=>{
    const categories = await prisma.categorieproduit.findMany()
    res.status(200).json(categories)
})

router.put('/:id', async (req, res)=>{
    let id = parseInt(req.params.id)
    const updatedCategorie = await prisma.categorieproduit.update({
        where:{
            id
        },
        data:{
            ...req.body
        }
    })
    res.status(200).json({result:updatedCategorie, message:"categorie mis a jour"})
})

router.delete('/:id', async (req,res)=>{
    let id = parseInt(req.params.id)
    const result = await prisma.categorieproduit.delete({
        where:{
            id
        }
    })
    res.status(200).json({result:result, message:"categorie supprimer"})
})

router.post('/', async (req, res)=>{
    const categorie = await prisma.categorieproduit.create({
        data:{
            ...req.body
        }
    })
    res.status(200).json({result:categorie, message:"categorie cree avec succes"})
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


router.get('/:id/produits', async (req,res)=>{
    let id = req.params.id
    const produits = prisma.produit.findMany({
        where:{
            categorieproduitId:id
        }
    })
    res.status(200).json(produits)
})

module.exports = router