const { PrismaClient } = require('@prisma/client');
const exp = require('express');
const router = exp.Router()
const prisma = new PrismaClient()
const bcrypt = require('bcrypt')

router.get('/', async (req, res)=>{
    const pointRamassages = await prisma.pointramassage.findMany()
    res.status(200).json(pointRamassages)
})

router.post('/', async (req, res)=>{
    let pointRamassage
    req.body.latitude = parseFloat(req.body.latitude)
    req.body.longitude = parseFloat(req.body.longitude)
    console.log('====================================');
    console.log(req.body);
    console.log('====================================');
    req.body.motPasse = await bcrypt.hash(req.body.motPasse, 10)
    if(req.file != null){
        const photoURL = req.protocol + '://' + req.headers.host + '/' + 'images' + '/' + req.file.filename
        pointRamassage = await prisma.pointramassage.create({
            data:{
                ...req.body,
                photoURL
            }
        })
    }
    else{
        pointRamassage = await prisma.pointramassage.create({
            data:{
                ...req.body,
            }
        })
    }
    console.log('====================================');
    console.log(pointRamassage);
    console.log('====================================');
    res.status(200).json(pointRamassage)
})

router.post('/connect', async(req,res)=>{
    let ad = await prisma.pointramassage.findFirst({
        where:{
            numero:req.body.numero
        }
    })
    if(ad != null){
        if(await bcrypt.compare(req.body.motPasse, ad.motPasse)){
            res.status(200).json("mot de passe accepter")
        }else{
            res.status(400).json("numero ou mot de passe rejecter")
        }
    }
    else{
        res.status(400).json("numero ou mot de passe rejecter")
    }
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
    let updatedPoint = null
    if(req.file != null){
        const photoURL = req.protocol + '://' + req.headers.host + '/' + 'images' + '/' + req.file.filename
        updatedPoint = await prisma.pointramassage.update({
            where:{
                id:parseInt(req.params.id)
            },
            data:{
                photoURL,
                ...req.body
            }
        })
    }else{
        updatedPoint = await prisma.pointramassage.update({
            where:{
                id:parseInt(req.params.id)
            },
            data:{
                ...req.body
            }
        })
    }
    
    res.status(200).json(updatedPoint)
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
        res.status(200).json(deletePointRamassage)
    }
    
})

module.exports = router