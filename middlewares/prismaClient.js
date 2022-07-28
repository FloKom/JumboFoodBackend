const { PrismaClient } = require('@prisma/client');
const exp = require('express');
const router = exp.Router()
const prisma = new PrismaClient()

module.exports = {
    exp,
    prisma,
    router
};