const EXPRESS_PRISMA = require('../middlewares/prismaClient')
const prisma = EXPRESS_PRISMA.prisma;



module.exports.producteurs = prisma.producteur.findMany({
    include:{
        producteur_has_produit:true
    }
})
                           
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
        }
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
    body.produitId = parseInt(body.produitId)
    // body.frequenceProduction = parseInt(body.frequenceProduction)
    return prisma.producteur_has_produit.create({
        data:{
            producteurId,
            photoURL,
            ...body
        }
    })
}

module.exports.produitsProposer = async (producteurId)=>{
    const ps = await prisma.producteur_has_produit.findMany({
        where:{
            producteurId
        }
    })
    console.log(ps)
    let produits = []
    for(let p of ps){
        let produit = await prisma.produit.findUnique({
            where:{
                id:p.produitId
            },
            include:{
                producteur_has_produit:true,
                categorieproduit:true,
                catalogue:true
            }
            
        })
        produits.push(produit)
    }
    return produits
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
            producteur_has_produit:true
        }
    })
    
    
   
}

