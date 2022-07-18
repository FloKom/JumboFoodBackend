/*
  Warnings:

  - The primary key for the `catalogue` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `date` on the `catalogue` table. All the data in the column will be lost.
  - You are about to drop the column `idProduit` on the `catalogue` table. All the data in the column will be lost.
  - You are about to alter the column `prix` on the `ligneproduit` table. The data in that column could be lost. The data in that column will be cast from `Int` to `Double`.
  - You are about to alter the column `prix` on the `packproduit` table. The data in that column could be lost. The data in that column will be cast from `Int` to `Double`.
  - You are about to alter the column `prix` on the `produit` table. The data in that column could be lost. The data in that column will be cast from `Int` to `Double`.
  - Added the required column `produit_idProduit` to the `catalogue` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updatedAt` to the `catalogue` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE `catalogue` DROP FOREIGN KEY `fk_produit`;

-- AlterTable
ALTER TABLE `catalogue` DROP PRIMARY KEY,
    DROP COLUMN `date`,
    DROP COLUMN `idProduit`,
    ADD COLUMN `produit_idProduit` INTEGER NOT NULL,
    ADD COLUMN `updatedAt` DATETIME(3) NOT NULL,
    ADD PRIMARY KEY (`idCatalogue`, `produit_idProduit`);

-- AlterTable
ALTER TABLE `client` ADD COLUMN `visible` VARCHAR(45) NULL;

-- AlterTable
ALTER TABLE `ligneproduit` MODIFY `prix` DOUBLE NULL;

-- AlterTable
ALTER TABLE `packproduit` ADD COLUMN `visible` VARCHAR(45) NULL,
    MODIFY `prix` DOUBLE NULL;

-- AlterTable
ALTER TABLE `pointramassage` ADD COLUMN `visible` VARCHAR(45) NULL;

-- AlterTable
ALTER TABLE `producteur` ADD COLUMN `visible` VARCHAR(45) NULL;

-- AlterTable
ALTER TABLE `produit` ADD COLUMN `visible` VARCHAR(45) NULL,
    MODIFY `prix` DOUBLE NULL;

-- CreateTable
CREATE TABLE `admin` (
    `idAdmin` INTEGER NOT NULL,
    `nom` VARCHAR(1000) NULL,
    `motPasse` VARCHAR(1000) NULL,

    PRIMARY KEY (`idAdmin`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateIndex
CREATE INDEX `fk_catalogue_produit1_idx` ON `catalogue`(`produit_idProduit`);

-- AddForeignKey
ALTER TABLE `catalogue` ADD CONSTRAINT `fk_catalogue_produit1` FOREIGN KEY (`produit_idProduit`) REFERENCES `produit`(`idProduit`) ON DELETE NO ACTION ON UPDATE NO ACTION;
