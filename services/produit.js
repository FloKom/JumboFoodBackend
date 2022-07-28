const { PrismaClient } = require('@prisma/client');
const { response } = require('express');
const exp = require('express');
const router = exp.Router()
const prisma = new PrismaClient()

router.get('/', async (req, res)=>{
    const produits = await prisma.produit.findMany({
        include:{
            producteur_has_produit:true,
            categorieproduit:true,
            catalogue:true
        }
    })
    res.status(200).json(produits)
})

router.get('/:id', async (req,res)=>{
    let id = parseInt(req.params.id)
    let produit = await prisma.produit.findUnique({
        where:{
            id
        },
        include:{
            producteur_has_produit:true,
            categorieproduit:true,
            catalogue:true
        }
    })
    res.status(200).json(produit)
})


router.put('/:id/catalogue', async (req,res)=>{
    let id = parseInt(req.params.id)
    let catalogue = await prisma.catalogue.updateMany({
        where:{
            produitId:id
        },
        data:{
            dateApprovisionnement:new Date(),
            ...req.body
        }
    })
    res.status(200).json({result:catalogue, message:"catalogue mis a jour avec succes"})
})


router.get('/:id/catalogue', async (req,res)=>{
    let id = parseInt(req.params.id)
    let catalogue = await prisma.catalogue.findFirst({
        where:{
            produitId:id
        }
    })
    res.status(200).json(catalogue)
})



router.post('/', async (req,res)=>{
    let {nom, prix, description} = req.body
    prix = parseInt(prix)
    const photoURL = req.protocol + '://' + req.headers.host + '/' + 'images' + '/' + req.file.filename  
    
    const produit = await prisma.produit.create({
        data:{
            nom,
            prix,
            photoURL,
            description
        },
    })

    const catalogue = await prisma.catalogue.create({
        data:{
            dateApprovisionnement: new Date(),
            quantite:0,
            produitId:produit.id
        },
        include:{
            produit:true
        }
    })
    

    res.status(200).json({result:catalogue, message:"produit cree avec succes"})
})

router.post('/:id', async (req, res)=>{
    let produitUdapted
    if(req.body.prix != undefined){
        req.body.prix = parseInt(req.body.prix)
    }
    if(req.file != null){
       const photoURL = req.protocol + '://' + req.headers.host + '/' + 'images' + '/' + req.file.filename
       produitUdapted = await prisma.produit.update({
            where:{
                id: parseInt(req.params.id)
            },
            data:{
                ...req.body,
                photoURL
            }
        })
    }
    else{
        produitUdapted = await prisma.produit.update({
            where:{
                id: parseInt(req.params.id)
            },
            data:{
                ...req.body
            }
        }).catch(()=>{
            res.send("echec de mise a jour")
        })
    }
    res.status(200).json({result:produitUdapted, message:"produit modifie avec succes"})
})

router.delete('/:id', async (req, res)=>{
    const deletedLigne = await prisma.ligneproduit.deleteMany({
        where:{
            produitId:parseInt(req.params.id),
            pannierId:null
        }
    })

    const deletedProduct = await prisma.produit.delete({
        where:{
            id: parseInt(req.params.id)
        }
    })

res.status(200).json({result:deletedProduct, message:"produit supprimer avec succes"})
})

router.get('/:id/producteurs', async (req,res)=>{
    let id = parseInt(req.params.id)
    let ps = await prisma.producteur_has_produit.findMany({
        where:{
            produitId:id
        }
    })
    let producteurs = []
    for(let p of ps){
        let pro = await prisma.producteur.findUnique({
            where:{
                id:p.producteurId
            }
        })
        producteurs.push(pro) 
    }
    res.status(200).json(producteurs)
})


module.exports = router