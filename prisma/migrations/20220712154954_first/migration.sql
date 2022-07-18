-- CreateTable
CREATE TABLE `catalogue` (
    `idCatalogue` INTEGER NOT NULL AUTO_INCREMENT,
    `quantite` INTEGER NULL,
    `date` DATE NULL,
    `idProduit` INTEGER NULL,

    INDEX `fk_produit_idx`(`idProduit`),
    PRIMARY KEY (`idCatalogue`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `categorieproduit` (
    `idCategorieProduit` INTEGER NOT NULL AUTO_INCREMENT,
    `nom` VARCHAR(1000) NULL,

    PRIMARY KEY (`idCategorieProduit`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `client` (
    `idClient` INTEGER NOT NULL AUTO_INCREMENT,
    `nomClient` VARCHAR(45) NULL,
    `numero` VARCHAR(45) NULL,
    `motPasse` VARCHAR(45) NULL,

    PRIMARY KEY (`idClient`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ligneproduit` (
    `idLigneProduit` INTEGER NOT NULL AUTO_INCREMENT,
    `quantiteCommande` INTEGER NULL,
    `prix` INTEGER NULL,
    `idProduit` INTEGER NULL,
    `idPack` INTEGER NULL,
    `idPannier` INTEGER NULL,

    INDEX `idPack_idx`(`idPack`),
    INDEX `idPannier_idx`(`idPannier`),
    INDEX `idProduit_idx`(`idProduit`),
    PRIMARY KEY (`idLigneProduit`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `packproduit` (
    `idPackProduit` INTEGER NOT NULL AUTO_INCREMENT,
    `nomPack` VARCHAR(45) NULL,
    `prix` INTEGER NULL,
    `description` VARCHAR(1000) NULL,

    PRIMARY KEY (`idPackProduit`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `pannier` (
    `idpannier` INTEGER NOT NULL AUTO_INCREMENT,
    `prix` VARCHAR(45) NOT NULL,
    `date` VARCHAR(45) NOT NULL,
    `idPointRamassage` INTEGER NULL,
    `idClient` INTEGER NULL,
    `moyenPaiement` VARCHAR(45) NOT NULL,
    `statut` VARCHAR(45) NULL,

    INDEX `idClient_idx`(`idClient`),
    INDEX `idPointRamassage_idx`(`idPointRamassage`),
    PRIMARY KEY (`idpannier`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `pointramassage` (
    `idPointRamassage` INTEGER NOT NULL AUTO_INCREMENT,
    `nom` VARCHAR(45) NULL,
    `lieu` point NULL,

    PRIMARY KEY (`idPointRamassage`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `producteur` (
    `idProducteur` INTEGER NOT NULL AUTO_INCREMENT,
    `nomProducteur` VARCHAR(45) NULL,
    `localisation` point NULL,
    `frequenceProduction` INTEGER NULL,
    `volumeProduction` INTEGER NULL,
    `conditionnement` VARCHAR(45) NULL,
    `saisonnier` VARCHAR(45) NULL,
    `valide` INTEGER NULL,
    `numero` VARCHAR(45) NULL,
    `motPasse` VARCHAR(45) NULL,

    PRIMARY KEY (`idProducteur`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `producteur_has_produit` (
    `Producteur_idProducteur` INTEGER NOT NULL AUTO_INCREMENT,
    `Produit_idProduit` INTEGER NOT NULL,

    INDEX `fk_Producteur_has_Produit_Producteur1_idx`(`Producteur_idProducteur`),
    INDEX `fk_Producteur_has_Produit_Produit1_idx`(`Produit_idProduit`),
    PRIMARY KEY (`Producteur_idProducteur`, `Produit_idProduit`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `produit` (
    `idProduit` INTEGER NOT NULL AUTO_INCREMENT,
    `nom` VARCHAR(45) NULL,
    `prix` INTEGER NULL,
    `photoURL` VARCHAR(45) NULL,
    `description` VARCHAR(1000) NULL,
    `conditionnement` VARCHAR(45) NULL,
    `idCategorieProduit` INTEGER NULL,

    INDEX `fk_Produit_CategorieProduit1_idx`(`idCategorieProduit`),
    PRIMARY KEY (`idProduit`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ropert` (
    `idManager` INTEGER NOT NULL AUTO_INCREMENT,
    `nom` VARCHAR(45) NULL,
    `motPasse` VARCHAR(45) NULL,

    PRIMARY KEY (`idManager`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `catalogue` ADD CONSTRAINT `fk_produit` FOREIGN KEY (`idProduit`) REFERENCES `produit`(`idProduit`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `ligneproduit` ADD CONSTRAINT `idPack` FOREIGN KEY (`idPack`) REFERENCES `packproduit`(`idPackProduit`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ligneproduit` ADD CONSTRAINT `idPannier` FOREIGN KEY (`idPannier`) REFERENCES `pannier`(`idpannier`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `ligneproduit` ADD CONSTRAINT `idProduit` FOREIGN KEY (`idProduit`) REFERENCES `produit`(`idProduit`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `pannier` ADD CONSTRAINT `idClient` FOREIGN KEY (`idClient`) REFERENCES `client`(`idClient`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `pannier` ADD CONSTRAINT `idPointRamassage` FOREIGN KEY (`idPointRamassage`) REFERENCES `pointramassage`(`idPointRamassage`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `producteur_has_produit` ADD CONSTRAINT `fk_Producteur_has_Produit_Producteur1` FOREIGN KEY (`Producteur_idProducteur`) REFERENCES `producteur`(`idProducteur`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `producteur_has_produit` ADD CONSTRAINT `fk_Producteur_has_Produit_Produit1` FOREIGN KEY (`Produit_idProduit`) REFERENCES `produit`(`idProduit`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `produit` ADD CONSTRAINT `fk_Produit_CategorieProduit1` FOREIGN KEY (`idCategorieProduit`) REFERENCES `categorieproduit`(`idCategorieProduit`) ON DELETE NO ACTION ON UPDATE NO ACTION;
