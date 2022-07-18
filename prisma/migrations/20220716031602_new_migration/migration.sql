/*
  Warnings:

  - The primary key for the `catalogue` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `idCatalogue` on the `catalogue` table. All the data in the column will be lost.
  - You are about to drop the column `produit_idProduit` on the `catalogue` table. All the data in the column will be lost.
  - You are about to drop the column `updatedAt` on the `catalogue` table. All the data in the column will be lost.
  - The primary key for the `categorieproduit` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `idCategorieProduit` on the `categorieproduit` table. All the data in the column will be lost.
  - The primary key for the `client` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `idClient` on the `client` table. All the data in the column will be lost.
  - You are about to drop the column `visible` on the `client` table. All the data in the column will be lost.
  - The primary key for the `packproduit` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `idPackProduit` on the `packproduit` table. All the data in the column will be lost.
  - You are about to drop the column `visible` on the `packproduit` table. All the data in the column will be lost.
  - The primary key for the `pannier` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `idpannier` on the `pannier` table. All the data in the column will be lost.
  - The primary key for the `pointramassage` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `idPointRamassage` on the `pointramassage` table. All the data in the column will be lost.
  - You are about to drop the column `visible` on the `pointramassage` table. All the data in the column will be lost.
  - The primary key for the `producteur` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `idProducteur` on the `producteur` table. All the data in the column will be lost.
  - You are about to drop the column `visible` on the `producteur` table. All the data in the column will be lost.
  - The primary key for the `producteur_has_produit` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `Producteur_idProducteur` on the `producteur_has_produit` table. All the data in the column will be lost.
  - You are about to drop the column `Produit_idProduit` on the `producteur_has_produit` table. All the data in the column will be lost.
  - The primary key for the `produit` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `idProduit` on the `produit` table. All the data in the column will be lost.
  - You are about to drop the column `visible` on the `produit` table. All the data in the column will be lost.
  - You are about to drop the `admin` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `id` to the `catalogue` table without a default value. This is not possible if the table is not empty.
  - Added the required column `id` to the `categorieproduit` table without a default value. This is not possible if the table is not empty.
  - Added the required column `id` to the `client` table without a default value. This is not possible if the table is not empty.
  - Added the required column `id` to the `packproduit` table without a default value. This is not possible if the table is not empty.
  - Added the required column `id` to the `pannier` table without a default value. This is not possible if the table is not empty.
  - Added the required column `id` to the `pointramassage` table without a default value. This is not possible if the table is not empty.
  - Added the required column `id` to the `producteur` table without a default value. This is not possible if the table is not empty.
  - Added the required column `idProducteur` to the `producteur_has_produit` table without a default value. This is not possible if the table is not empty.
  - Added the required column `idProduit` to the `producteur_has_produit` table without a default value. This is not possible if the table is not empty.
  - Added the required column `id` to the `produit` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE `catalogue` DROP FOREIGN KEY `fk_catalogue_produit1`;

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

-- AlterTable
ALTER TABLE `catalogue` DROP PRIMARY KEY,
    DROP COLUMN `idCatalogue`,
    DROP COLUMN `produit_idProduit`,
    DROP COLUMN `updatedAt`,
    ADD COLUMN `date` DATE NULL,
    ADD COLUMN `id` INTEGER NOT NULL AUTO_INCREMENT,
    ADD COLUMN `idProduit` INTEGER NULL,
    ADD PRIMARY KEY (`id`);

-- AlterTable
ALTER TABLE `categorieproduit` DROP PRIMARY KEY,
    DROP COLUMN `idCategorieProduit`,
    ADD COLUMN `id` INTEGER NOT NULL AUTO_INCREMENT,
    ADD PRIMARY KEY (`id`);

-- AlterTable
ALTER TABLE `client` DROP PRIMARY KEY,
    DROP COLUMN `idClient`,
    DROP COLUMN `visible`,
    ADD COLUMN `id` INTEGER NOT NULL AUTO_INCREMENT,
    ADD PRIMARY KEY (`id`);

-- AlterTable
ALTER TABLE `ligneproduit` MODIFY `prix` INTEGER NULL;

-- AlterTable
ALTER TABLE `packproduit` DROP PRIMARY KEY,
    DROP COLUMN `idPackProduit`,
    DROP COLUMN `visible`,
    ADD COLUMN `id` INTEGER NOT NULL AUTO_INCREMENT,
    MODIFY `prix` INTEGER NULL,
    ADD PRIMARY KEY (`id`);

-- AlterTable
ALTER TABLE `pannier` DROP PRIMARY KEY,
    DROP COLUMN `idpannier`,
    ADD COLUMN `id` INTEGER NOT NULL AUTO_INCREMENT,
    ADD PRIMARY KEY (`id`);

-- AlterTable
ALTER TABLE `pointramassage` DROP PRIMARY KEY,
    DROP COLUMN `idPointRamassage`,
    DROP COLUMN `visible`,
    ADD COLUMN `id` INTEGER NOT NULL AUTO_INCREMENT,
    ADD PRIMARY KEY (`id`);

-- AlterTable
ALTER TABLE `producteur` DROP PRIMARY KEY,
    DROP COLUMN `idProducteur`,
    DROP COLUMN `visible`,
    ADD COLUMN `id` INTEGER NOT NULL AUTO_INCREMENT,
    ADD PRIMARY KEY (`id`);

-- AlterTable
ALTER TABLE `producteur_has_produit` DROP PRIMARY KEY,
    DROP COLUMN `Producteur_idProducteur`,
    DROP COLUMN `Produit_idProduit`,
    ADD COLUMN `idProducteur` INTEGER NOT NULL AUTO_INCREMENT,
    ADD COLUMN `idProduit` INTEGER NOT NULL,
    ADD PRIMARY KEY (`idProducteur`, `idProduit`);

-- AlterTable
ALTER TABLE `produit` DROP PRIMARY KEY,
    DROP COLUMN `idProduit`,
    DROP COLUMN `visible`,
    ADD COLUMN `id` INTEGER NOT NULL AUTO_INCREMENT,
    MODIFY `prix` INTEGER NULL,
    ADD PRIMARY KEY (`id`);

-- DropTable
DROP TABLE `admin`;

-- CreateIndex
CREATE INDEX `fk_produit_idx` ON `catalogue`(`idProduit`);

-- CreateIndex
CREATE INDEX `fk_Producteur_has_Produit_Producteur1_idx` ON `producteur_has_produit`(`idProducteur`);

-- CreateIndex
CREATE INDEX `fk_Producteur_has_Produit_Produit1_idx` ON `producteur_has_produit`(`idProduit`);

-- AddForeignKey
ALTER TABLE `catalogue` ADD CONSTRAINT `fk_produit` FOREIGN KEY (`idProduit`) REFERENCES `produit`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `ligneproduit` ADD CONSTRAINT `idPack` FOREIGN KEY (`idPack`) REFERENCES `packproduit`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ligneproduit` ADD CONSTRAINT `idPannier` FOREIGN KEY (`idPannier`) REFERENCES `pannier`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `ligneproduit` ADD CONSTRAINT `idProduit` FOREIGN KEY (`idProduit`) REFERENCES `produit`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `pannier` ADD CONSTRAINT `idClient` FOREIGN KEY (`idClient`) REFERENCES `client`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `pannier` ADD CONSTRAINT `idPointRamassage` FOREIGN KEY (`idPointRamassage`) REFERENCES `pointramassage`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `producteur_has_produit` ADD CONSTRAINT `fk_Producteur_has_Produit_Producteur1` FOREIGN KEY (`idProducteur`) REFERENCES `producteur`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `producteur_has_produit` ADD CONSTRAINT `fk_Producteur_has_Produit_Produit1` FOREIGN KEY (`idProduit`) REFERENCES `produit`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `produit` ADD CONSTRAINT `fk_Produit_CategorieProduit1` FOREIGN KEY (`idCategorieProduit`) REFERENCES `categorieproduit`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
