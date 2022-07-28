const { PrismaClient } = require('@prisma/client');
const exp = require('express');
const router = exp.Router()
const prisma = new PrismaClient()

router.post('/',async (req, res)=>{
    const client = await prisma.client.create({
        data:{
            ...req.body
        }
    })
    res.status(200).json({result:client, message:"client enregistrer avec succes"})
})

router.get('/', async (req, res)=>{
    const clients = await prisma.client.findMany() 
    res.status(200).json(clients)
})


router.get('/:id', async (req,res)=>{
    let id = parseInt(req.params.id)
    let client = await prisma.client.findUnique({
        where:{
            id
        }
    })
    res.status(200).json(client)
})



router.put('/:id', async (req, res)=>{
    let id = parseInt(req.params.id)
    const updatedClient = await prisma.client.update({
        where:{
            id
        },
        data:{
            ...req.body
        }
    })
    res.status(200).json({result:updatedClient, message:"client mis a jour"})
})

router.delete('/:id', async (req,res)=>{
    const result = await prisma.client.delete({
        where:{
            id:parseInt(req.params.id)
        }
    })
    res.status(200).json({result:result, message:"client supprimer"})
})

router.get('/:id/panniers', async (req,res)=>{
    const clientId = parseInt(req.params.id)
    const panniers = await prisma.pannier.findMany({
        where:{
            clientId
        },
        include:{
            ligneproduit:true,
            pointramassage:true
        }
    })
    res.status(200).json(panniers)

})

module.exports = router