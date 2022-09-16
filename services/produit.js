const { PrismaClient } = require('@prisma/client');
const { response } = require('express');
const exp = require('express');
const router = exp.Router()
const prisma = new PrismaClient()

router.get('/', async (req, res)=>{
    let produits = null
    let data = null
    if(req.query.nom != null){
        produits = await prisma.produit.findMany({
            where:{
                nom:{
                    contains: req.query.nom
                }
            }
        })
        data = [...produits]
        for(let produit of produits){
            let ligneProduits = await prisma.ligneproduit.findMany({
                where:{
                    produitId:produit.id,
                    pannierId:null
                }
            })
            if(ligneProduits.length != 0){
                for(let ligneproduit of ligneProduits){
                    let pack = await prisma.packproduit.findFirst({
                        where:{
                            id:ligneproduit.packproduitId,
                        },
                        include:{
                            ligneproduit:true
                        }
                    })
                    
                    let found = data.find((item)=>(item.id == pack.id)&&(item.ligneproduit != null))
                    if(found == undefined){
                        data.push(pack)
                    }
                }
            }
            
        }
        produits = [...data]
        
    }else{
        produits = await prisma.produit.findMany({
            include:{
                producteur_has_produit:true,
                catalogue:true
            }
        })
    }
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
    res.status(200).json(catalogue)
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
    req.body.prix = parseInt(req.body.prix)
    req.body.categorieproduitId = parseInt(req.body.categorieproduitId)
    const photoURL = req.protocol + '://' + req.headers.host + '/' + 'images' + '/' + req.file.filename  
    let {categorieproduitId, ...body} = req.body
    if(isNaN(parseInt(categorieproduitId))){
        categorieproduitId = null
    }
    const produit = await prisma.produit.create({
        data:{
            ...body,
            categorieproduitId,
            photoURL
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
    

    res.status(200).json(catalogue)
})

router.post('/:id', async (req, res)=>{
    let produitUdapted
    if(req.body.categorieproduitId!=undefined){
        req.body.categorieproduitId = parseInt(req.body.categorieproduitId)
    }
    if(req.body.prix != undefined){
        req.body.prix = parseInt(req.body.prix)
    }
    let {catalogue,producteur_has_produit, ...attr}=req.body
    console.log( attr);
    if(req.file != null){
       const photoURL = req.protocol + '://' + req.headers.host + '/' + 'images' + '/' + req.file.filename
       produitUdapted = await prisma.produit.update({
            where:{
                id: parseInt(req.params.id)
            },
            data:{
                ...attr,
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
                ...attr
            }
        }).catch(()=>{
            res.send("echec de mise a jour")
        })
    }
    
    console.log(req.body);
    console.log('====================================');
    console.log(produitUdapted);
    console.log('====================================');
    res.status(200).json(produitUdapted)
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

res.status(200).json(deletedProduct)
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