const { PrismaClient } = require('@prisma/client');
const exp = require('express');
const router = exp.Router()
const prisma = new PrismaClient()


router.get('/', async (req,res)=>{
        const shModernOffset = new Date()
    const shHistoricalOffset = new Date('2020-01-01')

    if(req.query.date_gte){
        var date_gte = new Date(req.query.date_gte)
    }else{
        var date_gte =  shHistoricalOffset
    }
    if(req.query.date_lte){
        var date_lte = new Date(req.query.date_lte)
    }else{
        var date_lte = shModernOffset 
    } 


    const propositions = await prisma.produitpropose.findMany({
        include:{
            producteur:true,
            photo:true
        },
        where:{
            statut:{
                contains:"approuve"
            },
            updatedAt:{
                lte:date_lte,
                gte:date_gte
            }
        }
    })
    res.status(200).json(propositions)
})

router.get('/:id', async (req,res)=>{
    const id = parseInt(req.params.id)
    const produitPropose = await prisma.produitpropose.findUnique({
        where:{
            id,
        },
        include:{
            producteur:true,
            photo:true,
        }
    })
    res.status(200).json(produitPropose)
})

router.post('/:id',async (req, res)=>{
    let id = parseInt(req.params.id)
    console.log(id);
    console.log(req.body)
    const updatedproduitProposer = await prisma.produitpropose.update({
        where:{
            id
        },
        data:{
            ...req.body
        }
    })
    res.status(200).json(updatedproduitProposer)
})


router.put('/:id', async (req, res)=>{
    let id = parseInt(req.params.id)
    console.log(id);
    console.log(req.body)
    const updatedproduitProposer = await prisma.produitpropose.update({
        where:{
            id
        },
        data:{
            ...req.body
        }
    })
    res.status(200).json(updatedproduitProposer)
})


router.delete('/:id', async (req, res)=>{
    let id = parseInt(req.params.id)
    const proposition = await prisma.produitpropose.delete({
        where:{
            id
        }
    })
    res.status(200).json(proposition)
})

module.exports = router