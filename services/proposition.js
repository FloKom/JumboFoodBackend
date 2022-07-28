const { PrismaClient } = require('@prisma/client');
const exp = require('express');
const router = exp.Router()
const prisma = new PrismaClient()

router.get('/', async (req,res)=>{
    const propositions = await prisma.proposition.findMany({
        include:{
            producteur:true
        }
    })
    res.status(200).json(propositions)
})

router.delete('/:id', async (req, res)=>{
    let id = parseInt(req.params.id)
    const proposition = await prisma.proposition.delete({
        where:{
            id
        }
    })
    res.status(200).json(proposition)
})

module.exports = router