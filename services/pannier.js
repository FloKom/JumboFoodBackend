const { PrismaClient } = require('@prisma/client');
const exp = require('express');
const router = exp.Router()
const prisma = new PrismaClient()
const CodeGenerator = require('node-code-generator')
const generator = new CodeGenerator();
const pattern = '#####';
const howMany = 1;
const payment = require('./payment')

router.post('/', async (req, res)=>{
    let codes = await prisma.pannier.findMany({
        select:{
            id:true
        }
    })
    codes = codes.map((item)=>item.id)
    const code = generator.generateCodes(
        pattern, 
        howMany, 
        {
            existingCodesLoader:()=>{
                return codes
            },
            numericChars:'123456789'
        }
    );
    req.body.prix = parseInt(req.body.prix)
    req.body.clientId = parseInt(req.body.clientId)
    if(req.body.pointramassageId != null){
        req.body.pointramassageId = parseInt(req.body.pointramassageId)
    }
    if(req.body.longitude != null){
        req.body.longitude = parseFloat(req.body.longitude)
        req.body.latitude = parseFloat(req.body.latitude)
    }
    let {ligneProduits, lignePacks, pay_token, ...body} = req.body
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
            statut:"non paye",
            ...body,
            id:parseInt(code[0]),
            ligneproduit:{
                create: lignePannierProduits
            }
        },
        include:{
            ligneproduit:true
        }
    })
    console.log(result)
    // const {token} = await payment.getToken()
    // if(body.moyenPaiement == 'Mobile Money'){
    //     const timer = setInterval(async ()=>{
    //         let status = await payment.getPaymentStatus(token, pay_token)
    //         console.log(status)
            // if(status === "Failed"){
                // clearTimeout(timeOut)
                // clearInterval(timer)
            // }
            // if(status === "Success"){
            //     console.log('id', result.id)
            //     let res = await prisma.pannier.update({
            //         where:{
            //             id:result.id
            //         },
            //         data:{
            //             statut:"non livre"
            //         }
            //     })
            //     clearTimeout(timeOut)
            //     clearInterval(timer)
            // }
        // },1500)
    
        // let timeOut = setTimeout(()=>clearInterval(timer), 20000)
    // }
    res.status(200).json(result)
})

router.get('/', async (req,res)=>{
    console.log('====================================');
    console.log(req.query);
    console.log('====================================');
    const panniers = await prisma.pannier.findMany({
        include:{
            ligneproduit:true,
            client:true
        },where:{
            statut:req.query.statut
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
        },
    
    })
    res.status(200).json(pannier)
})


router.post('/:id', async (req,res)=>{
    console.log(req.body)
    const updatedState = await prisma.pannier.update({
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
    res.status(200).json(updatedState)
})

module.exports = router


