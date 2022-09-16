const EXPRESS_PRISMA = require('../middlewares/prismaClient');
const prisma = EXPRESS_PRISMA.prisma;



module.exports.CatalogueDesProduits = async function(){
    return prisma.catalogue.findMany()
}
                            
                          
module.exports.supprimerCatalogue = function(id){
    
    async function supCatalogue(){
        await prisma.catalogue.delete({
            where: {
                id
            }
        })
    }
    supCatalogue()
        .catch((e) => {
        throw e
        })
}


module.exports.ajouterCatalogue = function(_quantite, _date, _idProduit){

    async function addCatalogue() {
        
        await prisma.catalogue.create({
            data: {
                quantite: _quantite,
                date: _date,
                idProduit: _idProduit
            }
        })
    }

    addCatalogue()
        .catch((e) => {
        throw e
        })
}

module.exports.modifierCatalogue = async function(id, body) {
    
    return prisma.catalogue.update({
        where: {
            id
        },
        data: {
            dateApprovisionnement: new Date(),
            ...body
        }
    })
}
