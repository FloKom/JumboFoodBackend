const EXPRESS_PRISMA = require('../middlewares/prismaClient');
const prisma = EXPRESS_PRISMA.prisma;
const bcrypt = require('bcrypt')


module.exports.enregistrerAdmin = async function(body) {
    body.motPasse = await bcrypt.hash(body.motPasse, 10)
    return prisma.admin.create({
        data: {
            ...body
        }
    })  
}

module.exports.connect = async (body)=>{
    let ad = await prisma.admin.findFirst({
        where:{
            email:body.email
        }
    })
    if(ad != null){
        return bcrypt.compare(body.motPasse, ad.motPasse)
    }
    return false
    
    
}

module.exports.admins = async function () {
    return prisma.admin.findMany()
}
   

module.exports.modifierAdmin = (id,body) => {
    
    return prisma.admin.update({
        where: {
            id
        },
        data: {
            ...body
        }
    })
    
}

module.exports.deleteAdmin = (id) => {
    
    async function deleteAdmin() {
        await prisma.admin.delete({
            where: {
                id
            }
        })
    }
    deleteAdmin()
        .catch((e) => {
        throw e
        })
}