/*
  Warnings:

  - You are about to drop the column `frequenceProduction` on the `producteur_has_produit` table. All the data in the column will be lost.
  - You are about to drop the column `photoURL` on the `producteur_has_produit` table. All the data in the column will be lost.
  - You are about to drop the column `saisonnier` on the `producteur_has_produit` table. All the data in the column will be lost.
  - You are about to drop the column `statut` on the `producteur_has_produit` table. All the data in the column will be lost.
  - You are about to drop the column `volumeProduction` on the `producteur_has_produit` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE `categorieproduit` ADD COLUMN `photoURL` VARCHAR(1000) NULL;

-- AlterTable
ALTER TABLE `producteur` ADD COLUMN `nomStructure` VARCHAR(45) NULL;

-- AlterTable
ALTER TABLE `producteur_has_produit` DROP COLUMN `frequenceProduction`,
    DROP COLUMN `photoURL`,
    DROP COLUMN `saisonnier`,
    DROP COLUMN `statut`,
    DROP COLUMN `volumeProduction`;

-- CreateTable
CREATE TABLE `photo` (
    `idphoto` INTEGER NOT NULL AUTO_INCREMENT,
    `photoURL` VARCHAR(1000) NULL,
    `proposition_id` INTEGER NOT NULL,

    INDEX `fk_photo_proposition1_idx`(`proposition_id`),
    PRIMARY KEY (`idphoto`, `proposition_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `proposition` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `nomProduit` VARCHAR(45) NULL,
    `prix` FLOAT NULL,
    `periodiciteAnnuel` VARCHAR(45) NULL,
    `producteurId` INTEGER NULL,
    `conditionnement` VARCHAR(45) NULL,
    `saisonnier` VARCHAR(45) NULL,
    `statut` VARCHAR(45) NULL,
    `date` DATETIME(3) NULL,

    INDEX `fk_proposition_producteur1_idx`(`producteurId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `photo` ADD CONSTRAINT `fk_photo_proposition1` FOREIGN KEY (`proposition_id`) REFERENCES `proposition`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `proposition` ADD CONSTRAINT `fk_proposition_producteur1` FOREIGN KEY (`producteurId`) REFERENCES `producteur`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
