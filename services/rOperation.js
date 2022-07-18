const EXPRESS_PRISMA = require('../middlewares/prismaClient');
const prisma = EXPRESS_PRISMA.prisma;
const bcrypt = require('bcrypt')


/////////////////////////////////////////////////////////////
// Consulter la liste des responsables de opérations
///////////////////////////////////////////////////////////

module.exports.ROperations = prisma.ropert.findMany()
                               

//////////////////////////////////////////
// Créer un responsable des opérations
////////////////////////////////////////
module.exports.enregistrerROperations = async function(body) {
    body.motPasse = await bcrypt.hash(body.motPasse, 10)
    return prisma.ropert.create({
        data: {
            ...body
        }
    })  
}

module.exports.connect = async (body)=>{
    let ad = await prisma.ropert.findFirst({
        where:{
            email:body.email
        }
    })
    return bcrypt.compare(body.motPasse, ad.motPasse)
}



///////////////////////////////////////////////////
// Mofifier un profil responsable des opérations
/////////////////////////////////////////////////
module.exports.modifierRO = function(id, body) {
    
    return prisma.ropert.update({
        where: {
            id
        },
        data: {
            ...body
        }
    })
}



////////////////////////////////////////////////////
// Supprimer un profil responsable des opérations
///////////////////////////////////////////////////
module.exports.supprimerRO = function(id){    
    return prisma.ropert.delete({
        where: {
            id
        }
    })
  
}