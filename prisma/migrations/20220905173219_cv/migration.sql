-- CreateTable
CREATE TABLE `catalogue` (
    `quantite` INTEGER NULL,
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `dateApprovisionnement` DATE NULL,
    `updatedAt` DATETIME(3) NOT NULL,
    `produitId` INTEGER NULL,

    INDEX `fk_produit_idx`(`produitId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `categorieproduit` (
    `nom` VARCHAR(1000) NULL,
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `description` VARCHAR(1000) NULL,
    `categorieproduitId` INTEGER NULL,
    `photoURL` VARCHAR(1000) NULL,

    INDEX `categorie_fk_idx`(`categorieproduitId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `client` (
    `numero` VARCHAR(45) NULL,
    `motPasse` VARCHAR(45) NULL,
    `ville` VARCHAR(45) NULL,
    `quartier` VARCHAR(45) NULL,
    `adresse` VARCHAR(45) NULL,
    `preference` VARCHAR(45) NULL,
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `nom` VARCHAR(45) NULL,
    `prenom` VARCHAR(45) NULL,
    `sexe` VARCHAR(45) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ligneproduit` (
    `prix` INTEGER NULL,
    `quantite` INTEGER NULL,
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `pannierId` INTEGER NULL,
    `produitId` INTEGER NULL,
    `packproduitId` INTEGER NULL,

    INDEX `idPack_idx`(`packproduitId`),
    INDEX `idPannier_idx`(`pannierId`),
    INDEX `idProduit_idx`(`produitId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `packproduit` (
    `prix` INTEGER NULL,
    `description` VARCHAR(1000) NULL,
    `photoURL` VARCHAR(1000) NULL,
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `nom` VARCHAR(45) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `pannier` (
    `prix` DOUBLE NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `moyenPaiement` VARCHAR(45) NOT NULL,
    `statut` VARCHAR(45) NULL,
    `numPayeur` VARCHAR(45) NULL,
    `numBeneficiaire` VARCHAR(45) NULL,
    `nomBeneficiaire` VARCHAR(100) NULL,
    `nomPayeur` VARCHAR(100) NULL,
    `latitude` DOUBLE NULL,
    `longitude` DOUBLE NULL,
    `nomLieu` VARCHAR(1000) NULL,
    `id` INTEGER NOT NULL,
    `clientId` INTEGER NULL,
    `pointramassageId` INTEGER NULL,

    INDEX `idClient_idx`(`clientId`),
    INDEX `idPointRamassage_idx`(`pointramassageId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `pointramassage` (
    `nom` VARCHAR(45) NULL,
    `numero` VARCHAR(45) NULL,
    `motPasse` VARCHAR(10000) NULL,
    `latitude` DOUBLE NULL,
    `longitude` DOUBLE NULL,
    `ville` VARCHAR(45) NULL,
    `photoURL` VARCHAR(1000) NULL,
    `description` VARCHAR(1000) NULL,
    `id` INTEGER NOT NULL AUTO_INCREMENT,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `producteur` (
    `numero` VARCHAR(45) NULL,
    `motPasse` VARCHAR(45) NULL,
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `nom` VARCHAR(45) NULL,
    `prenom` VARCHAR(45) NULL,
    `description` VARCHAR(1000) NULL,
    `preinscriptionValide` VARCHAR(45) NULL DEFAULT 'en attente',
    `nomStructure` VARCHAR(45) NULL,

    FULLTEXT INDEX `producteur_nomStructure_idx`(`nomStructure`),
    FULLTEXT INDEX `producteur_nomStructure_nom_idx`(`nomStructure`, `nom`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `producteur_has_produit` (
    `producteurId` INTEGER NOT NULL AUTO_INCREMENT,
    `produitId` INTEGER NOT NULL,
    `conditionnement` VARCHAR(45) NULL,

    INDEX `fk_Producteur_has_Produit_Producteur1_idx`(`producteurId`),
    INDEX `fk_Producteur_has_Produit_Produit1_idx`(`produitId`),
    PRIMARY KEY (`producteurId`, `produitId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `produit` (
    `nom` VARCHAR(45) NULL,
    `prix` INTEGER NULL,
    `photoURL` VARCHAR(1000) NULL,
    `description` VARCHAR(1000) NULL,
    `conditionnement` VARCHAR(45) NULL,
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `categorieproduitId` INTEGER NULL,
    `statut` VARCHAR(1000) NULL,

    INDEX `fk_Produit_CategorieProduit1_idx`(`categorieproduitId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ropert` (
    `nom` VARCHAR(45) NULL,
    `motPasse` VARCHAR(1000) NULL,
    `prenom` VARCHAR(45) NULL,
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `email` VARCHAR(45) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `admin` (
    `nom` VARCHAR(45) NULL,
    `prenom` VARCHAR(45) NULL,
    `motPasse` VARCHAR(1000) NULL,
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `email` VARCHAR(45) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `photo` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `photoURL` VARCHAR(1000) NULL,
    `produitproposeId` INTEGER NULL,

    INDEX `fk_photo_produitpropose1_idx`(`produitproposeId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `plantation` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `lieu` VARCHAR(80) NULL,
    `producteurId` INTEGER NOT NULL,

    INDEX `fk_plantation_producteur1_idx`(`producteurId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `produitpropose` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `nomProduit` VARCHAR(45) NULL,
    `prix` VARCHAR(45) NULL,
    `conditionnement` VARCHAR(45) NULL,
    `description` VARCHAR(1000) NULL,
    `periodicteAnnuel` VARCHAR(45) NULL,
    `saisonnier` VARCHAR(45) NULL,
    `producteurId` INTEGER NULL,
    `statut` VARCHAR(45) NULL DEFAULT 'en attente',
    `updatedAt` DATETIME(3) NULL,

    INDEX `fk_produitpropose_producteur1_idx`(`producteurId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `catalogue` ADD CONSTRAINT `fk_produit` FOREIGN KEY (`produitId`) REFERENCES `produit`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `categorieproduit` ADD CONSTRAINT `categorie_fk` FOREIGN KEY (`categorieproduitId`) REFERENCES `categorieproduit`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `ligneproduit` ADD CONSTRAINT `packproduitId` FOREIGN KEY (`packproduitId`) REFERENCES `packproduit`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ligneproduit` ADD CONSTRAINT `pannierId` FOREIGN KEY (`pannierId`) REFERENCES `pannier`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `ligneproduit` ADD CONSTRAINT `produitId` FOREIGN KEY (`produitId`) REFERENCES `produit`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `pannier` ADD CONSTRAINT `clientId` FOREIGN KEY (`clientId`) REFERENCES `client`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `pannier` ADD CONSTRAINT `pointramassageId` FOREIGN KEY (`pointramassageId`) REFERENCES `pointramassage`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `producteur_has_produit` ADD CONSTRAINT `fk_Producteur_has_Produit_Producteur1` FOREIGN KEY (`producteurId`) REFERENCES `producteur`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `producteur_has_produit` ADD CONSTRAINT `fk_Producteur_has_Produit_Produit1` FOREIGN KEY (`produitId`) REFERENCES `produit`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `produit` ADD CONSTRAINT `fk_Produit_CategorieProduit1` FOREIGN KEY (`categorieproduitId`) REFERENCES `categorieproduit`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `photo` ADD CONSTRAINT `fk_photo_produitpropose1` FOREIGN KEY (`produitproposeId`) REFERENCES `produitpropose`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `plantation` ADD CONSTRAINT `fk_plantation_producteur1` FOREIGN KEY (`producteurId`) REFERENCES `producteur`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `produitpropose` ADD CONSTRAINT `fk_produitpropose_producteur1` FOREIGN KEY (`producteurId`) REFERENCES `producteur`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;
