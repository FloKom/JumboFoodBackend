const { PrismaClient } = require('@prisma/client');
const exp = require('express');
const router = exp.Router()
const prisma = new PrismaClient()

router.post('/', async (req, res)=>{
    req.body.prix = parseInt(req.body.prix)
    req.body.clientId = parseInt(req.body.clientId)
    req.body.pointramassageId = parseInt(req.body.pointramassageId)
    
    let {ligneProduits, lignePacks, ...body} = req.body
    let lignePannierProduits = []

    if(ligneProduits != null){

        ligneProduits = ligneProduits.map((ligneProduit)=>{
            ligneProduit.produitId = parseInt(ligneProduit.produitId)
            ligneProduit.quantite = parseInt(ligneProduit.quantite)
            return ligneProduit
        })

        lignePannierProduits = [...ligneProduits]
        
        for(let ligneProduit of ligneProduits){
            let {produitId, quantite} = ligneProduit
            let updatedCatalogue = await prisma.catalogue.updateMany({
                where:{
                    produitId,
                },
                data:{
                    quantite:{
                        decrement:quantite
                    }
                }
            })
            console.log(updatedCatalogue)
        }
    }
    
    if(lignePacks != null){
        lignePacks = lignePacks.map((lignePack)=>{
            lignePack.packproduitId = parseInt(lignePack.packproduitId)
            lignePack.quantite = parseInt(lignePack.quantite)
            return lignePack
        })
        lignePannierProduits = [...lignePannierProduits, ...lignePacks]
        for(let lignePack of lignePacks){
            let {packproduitId} = lignePack
            let produitsPack = await prisma.ligneproduit.findMany({
                where:{
                    packproduitId
                },
                select:{
                    produitId:true,
                    quantite:true
                }
                
            }) 

            for(let produitPack of produitsPack){
                let updatedCatalogue = await prisma.catalogue.updateMany({
                    where:{
                        produitId:produitPack.produitId,
                    },
                    data:{
                        quantite:{
                            decrement:produitPack.quantite*lignePack.quantite
                        }
                    }
    
                })
            }
        }
    }


    let result = await prisma.pannier.create({
        data:{
            ...body,
            date: new Date(),
            ligneproduit:{
                create: lignePannierProduits
            }
        },
        include:{
            ligneproduit:true
        }
    })

    res.status(200).json({result,message:"pannier enregistrer"})
})

router.get('/', async (req,res)=>{
    const panniers = await prisma.pannier.findMany({
        include:{
            ligneproduit:true,
            client:true
        }
    })
    res.status(200).json(panniers)
})

router.get('/:id', async (req,res)=>{
    let id = parseInt(req.params.id)
    let pannier = await prisma.pannier.findUnique({
        where:{
            id
        },
        include:{
            ligneproduit:true,
            client:true
        }
    })
    res.status(200).json(pannier)
})


router.put('/:id', async (req,res)=>{
    const updatedState = prisma.pannier.update({
        where:{
            id:parseInt(req.params.id)
        },
        data:{
            ...req.body
        },
        include:{
            ligneproduit:true,
            client:true
        }
    })
    res.status(200).json({result:updatedState, message:"etat du pannier mis a jour avec succes"})
})

module.exports = router


