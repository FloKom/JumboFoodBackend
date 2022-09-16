const { PrismaClient } = require('@prisma/client');
const exp = require('express');
const router = exp.Router()
const prisma = new PrismaClient()

router.get('/', async (req, res)=>{
    let packProduits = null
    if(req.query.nom != null){
        packProduits = await prisma.packproduit.findMany({
            include:{
                ligneproduit:true
            },
            where:{
                nom:{
                    contains: req.query.nom
                }
            }
        })        
    }else{
        packProduits = await prisma.packproduit.findMany({
            include:{
                ligneproduit:true
            }
        })
    }
    
    res.status(200).json(packProduits)
})

router.post('/', async (req,res)=>{
    req.body.prix = parseInt(req.body.prix)
    let {nom, prix, description, ligneProduits} = req.body
    ligneProduits = JSON.parse(ligneProduits)
    prix = parseInt(prix)
    const photoURL = req.protocol + '://' + req.headers.host + '/' + 'images' + '/' + req.file.filename  
    const packProduit = await prisma.packproduit.create({
        data:{
            nom,
            prix,
            description,
            photoURL,
            ligneproduit:{
                create:ligneProduits
            }
        },
        include:{
            ligneproduit:true,
            _count:true
        }
    })
    res.status(200).json({result:packProduit, message:"pack produit cree avec succes"})
})

router.put('/:id', async (req, res)=>{
    console.log(req.body)
    let packProduitUdapted
    if(req.body.prix != undefined){
        req.body.prix = parseInt(req.body.prix)
    }
    let {ligneProduits, ...body} = req.body
    ligneProduits = JSON.parse(ligneProduits)
    const deletedLigneProduits = await prisma.ligneproduit.deleteMany({
        where:{
            packproduitId:parseInt(req.params.id),
            pannierId:null
        }
    })
    ligneProduits = ligneProduits.map((ligne)=>{
        let {packproduitId, ...lignes} = ligne
        return lignes
    })
    if(req.file != null){
       const photoURL = req.protocol + '://' + req.headers.host + '/' + 'images' + '/' + req.file.filename
       packProduitUdapted = await prisma.packproduit.update({
            where:{
                id: parseInt(req.params.id)
            },
            data:{
                ...body,
                photoURL,
                ligneproduit:{
                    create:ligneProduits
                }
            },
            include:{
                ligneproduit:true,
                _count:true
            }

        })
    }
    else{
        packProduitUdapted = await prisma.packproduit.update({
            where:{
                id: parseInt(req.params.id)
            },
            data:{
                ...body,
                ligneproduit:{
                    create:ligneProduits
                }
            },
            include:{
                ligneproduit:true
            }

        }).catch(()=>{
            res.send("echec de mise a jour 2")
        })
    }
    res.status(200).json(packProduitUdapted)
})

router.delete('/:id', async (req, res)=>{
    try{
        const deletedLigne = await prisma.ligneproduit.deleteMany({
            where:{
                packproduitId:parseInt(req.params.id),
                pannierId:null
            }
        })

        const deletePackProduit = await prisma.packproduit.delete({
            where:{
                id:parseInt(req.params.id)                
            }
        })
        res.status(200).json(deletePackProduit)

    }
    catch{
        res.status(500).json({message:"pack produit "+ req.params.id +" n'existe pas"})
    }
   
})

router.get('/:id', async (req,res)=>{
    try{
        
        let id = parseInt(req.params.id)
        let packProduit = await prisma.packproduit.findUnique({
        where:{
            id
        },
        include:{
            ligneproduit:true
        }
    })
    res.status(200).json(packProduit)
    }
    catch{
        res.status(500).json({message:"pack produit "+ req.params.id +" n'existe pas"})
    }
    

})


router.get('/:id/produits', async (req,res)=>{
    try{
        let id = parseInt(req.params.id)
        let ligneProduits = await prisma.ligneproduit.findMany({
        where:{
            packproduitId:id,
            pannierId:null
        },
    })
    let produits = []
    for(let ligneProduit of ligneProduits){
        let pro = await prisma.produit.findUnique({
            where:{
                id:ligneProduit.produitId
            }
        })
        produits.push(pro) 
    }
    res.status(200).json(produits)

    }
    catch{
        res.status(500).json({message:"pack produit "+ req.params.id +" n'existe pas"})
    }
    
})


module.exports = router