const { PrismaClient } = require('@prisma/client');
const exp = require('express');
const router = exp.Router()
const prisma = new PrismaClient()

router.get('/', async (req, res)=>{
    const pointRamassages = await prisma.pointramassage.findMany()
    res.status(200).json(pointRamassages)
})

router.post('/', async (req, res)=>{
    const pointRamassage = await prisma.pointramassage.create({
        data:{
            ...req.body,
        }
    }).catch(()=>{
        res.send("erreur")
    })
    res.status(200).json({result:pointRamassage, message:"point de ramassage cree avec succes"})
})

router.get('/:id/panniers', async (req,res)=>{
    let id = parseInt(req.params.id)
    const panniers = await prisma.pannier.findMany({
        where:{
            pointramassageId: id
        }
    })
    res.status(200).json(panniers)
})

router.get('/:id', async (req,res)=>{
    let id = parseInt(req.params.id)
    let pointRamassage = await prisma.pointramassage.findUnique({
        where:{
            id
        }
    })
    res.status(200).json(pointRamassage)
})


router.put('/:id', async (req, res)=>{
    const updatedPoint = await prisma.pointramassage.update({
        where:{
            id:parseInt(req.params.id)
        },
        data:{
            ...req.body
        }
    })
    res.status(200).json({result:updatedPoint, message:"point de ramassage mis a jour avec succes"})
})

router.delete('/:id', async (req, res)=>{

    const pannierPtramsage = await prisma.pannier.findMany({
        where:{
            pointramassageId:parseInt(req.params.id),
            statut:"non livre"
        }
    })
    if(pannierPtramsage.length > 0){
        res.status(500).json({message:"le point de ramasage avec l'ID " + req.params.id + " doit terminer ses livraisons avant d'etre supprime"})
    }
    else{
        const deletePointRamassage = await prisma.pointramassage.delete({
            where:{
                id:parseInt(req.params.id)
            }
        })
        res.status(200).json({result:deletePointRamassage, message:"point de ramassage supprimer avec succes"})
    }
    
})

module.exports = router