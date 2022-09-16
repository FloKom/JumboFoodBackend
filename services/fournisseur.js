const { query } = require('express');
const EXPRESS_PRISMA = require('../middlewares/prismaClient')
const prisma = EXPRESS_PRISMA.prisma;


module.exports.producteurs = async function(body){
    console.log('====================================');
    console.log(body);
    console.log('====================================');
    return prisma.producteur.findMany({
        include:{
            producteur_has_produit:true,
            produitpropose:true,
            plantation:true
            
        },
        where:{
            nomStructure:{
                contains:body.q
            },
           preinscriptionValide:{
            contains:body.opt
           },
          
            
        },

        
    })
}
                  
module.exports.enregistrerFournisseur = function(body) {
    
    return prisma.producteur.create({
        data: {
            ...body
        }
    })
    
}


module.exports.deleteFournisseur = (id)=>{
    return prisma.producteur.delete({
        where:{
            id
        }, 
    })
}


module.exports.modifierFournisseur = async function(id, body) {
    
    return prisma.producteur.update({
        where: {
            id
        },
        data: {
            ...body
        }
    })
    
}


module.exports.proposerProduit = async (producteurId, body, photoURL)=>{
    return new Promise(async(resolve, reject) => {
        let {plantation, produits, ...attr} = body
        produits = JSON.parse(produits)
        let results = []
        for(let produit of produits){
            produit = await prisma.produitpropose.create({
                data:{
                    photo:{
                        create:photoURL
                    },
                    ...produit,
                    producteurId
                }
            })
            results.push(produit)
        }
        if(body.plantation != undefined){
            plantation = JSON.parse(plantation)
            plantation = plantation.map((plant)=>{
                plant.producteurId = producteurId
                return plant
        })  
            await prisma.producteur.update({
                where:{
                    id:producteurId
                },
                data:{
                    description:body.description
                }

            })
            for(let plant of plantation){
                await prisma.plantation.createMany({
                    data:plantation
                })
            }
        }   
        resolve(results)
    });
    
}

module.exports.produitsProposer = async (producteurId)=>{
    return prisma.produitpropose.findMany({
        where:{
            producteurId
        },
        include:{
            photo:true 
        }
    })
}

module.exports.produitsFournisseur = async function(id) {
    let ps = await prisma.producteur_has_produit.findMany({
        where:{
            producteurId:id
        }
    })
    
    let produits = []
    for(let p of ps){
        let pro = await prisma.produit.findUnique({
            where:{
                id:p.produitId
            }
        })
        produits.push(pro) 
    }
    console.log(produits)
    return produits           
}





module.exports.oneFournisseur = function(id) {

    return prisma.producteur.findUnique({
        where:{
            id
        },
        include:{
            producteur_has_produit:true,
            produitpropose:true,
            plantation:true
        }
    })
    
    
   
}

