const { PrismaClient } = require('@prisma/client');
const exp = require('express');
const router = exp.Router()
const prisma = new PrismaClient()

router.put('/',async(req,res)=>{
    if(req.body.status === 'Success'){
        let pannier = await prisma.pannier.findFirst({
            where:{
                numPayeur:req.body.operator_user_id,
                prix:req.body.amount,
                statut:'non paye'
            }
        })
        await prisma.pannier.update({
            where:{
                id:pannier.id
            },
            data:{
                statut:'non livre'
            }

        })
    }
})

module.exports = router