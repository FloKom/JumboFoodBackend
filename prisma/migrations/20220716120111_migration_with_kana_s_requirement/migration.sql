-- DropForeignKey
ALTER TABLE `catalogue` DROP FOREIGN KEY `fk_produit`;

-- DropForeignKey
ALTER TABLE `ligneproduit` DROP FOREIGN KEY `idPack`;

-- DropForeignKey
ALTER TABLE `ligneproduit` DROP FOREIGN KEY `idPannier`;

-- DropForeignKey
ALTER TABLE `ligneproduit` DROP FOREIGN KEY `idProduit`;

-- DropForeignKey
ALTER TABLE `pannier` DROP FOREIGN KEY `idClient`;

-- DropForeignKey
ALTER TABLE `pannier` DROP FOREIGN KEY `idPointRamassage`;

-- DropForeignKey
ALTER TABLE `producteur_has_produit` DROP FOREIGN KEY `fk_Producteur_has_Produit_Producteur1`;

-- DropForeignKey
ALTER TABLE `producteur_has_produit` DROP FOREIGN KEY `fk_Producteur_has_Produit_Produit1`;

-- DropForeignKey
ALTER TABLE `produit` DROP FOREIGN KEY `fk_Produit_CategorieProduit1`;

-- CreateTable
CREATE TABLE `Admin` (
    `idAdmin` INTEGER NOT NULL AUTO_INCREMENT,
    `nom` VARCHAR(45) NULL,
    `prenom` VARCHAR(45) NULL,
    `motPasse` VARCHAR(45) NULL,

    PRIMARY KEY (`idAdmin`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `Catalogue` ADD CONSTRAINT `fk_produit` FOREIGN KEY (`idProduit`) REFERENCES `Produit`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `LigneProduit` ADD CONSTRAINT `idPack` FOREIGN KEY (`idPack`) REFERENCES `PackProduit`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `LigneProduit` ADD CONSTRAINT `idPannier` FOREIGN KEY (`idPannier`) REFERENCES `Pannier`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `LigneProduit` ADD CONSTRAINT `idProduit` FOREIGN KEY (`idProduit`) REFERENCES `Produit`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `Pannier` ADD CONSTRAINT `idClient` FOREIGN KEY (`idClient`) REFERENCES `Client`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `Pannier` ADD CONSTRAINT `idPointRamassage` FOREIGN KEY (`idPointRamassage`) REFERENCES `PointRamassage`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `Producteur_has_Produit` ADD CONSTRAINT `fk_Producteur_has_Produit_Producteur1` FOREIGN KEY (`idProducteur`) REFERENCES `Producteur`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `Producteur_has_Produit` ADD CONSTRAINT `fk_Producteur_has_Produit_Produit1` FOREIGN KEY (`idProduit`) REFERENCES `Produit`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `Produit` ADD CONSTRAINT `fk_Produit_CategorieProduit1` FOREIGN KEY (`idCategorieProduit`) REFERENCES `CategorieProduit`(`id`) ON DELETE SET NULL ON UPDATE NO ACTION;
