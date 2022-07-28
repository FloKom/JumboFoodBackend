/*
  Warnings:

  - You are about to drop the column `idProduit` on the `catalogue` table. All the data in the column will be lost.
  - You are about to drop the column `idPack` on the `ligneproduit` table. All the data in the column will be lost.
  - You are about to drop the column `idPannier` on the `ligneproduit` table. All the data in the column will be lost.
  - You are about to drop the column `idProduit` on the `ligneproduit` table. All the data in the column will be lost.
  - You are about to drop the column `idClient` on the `pannier` table. All the data in the column will be lost.
  - You are about to drop the column `idPointRamassage` on the `pannier` table. All the data in the column will be lost.
  - You are about to alter the column `date` on the `pannier` table. The data in that column could be lost. The data in that column will be cast from `VarChar(45)` to `DateTime(3)`.
  - The primary key for the `producteur_has_produit` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `idProducteur` on the `producteur_has_produit` table. All the data in the column will be lost.
  - You are about to drop the column `idProduit` on the `producteur_has_produit` table. All the data in the column will be lost.
  - You are about to drop the column `idCategorieProduit` on the `produit` table. All the data in the column will be lost.
  - Added the required column `producteurId` to the `producteur_has_produit` table without a default value. This is not possible if the table is not empty.
  - Added the required column `produitId` to the `producteur_has_produit` table without a default value. This is not possible if the table is not empty.

*/
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

-- AlterTable
ALTER TABLE `catalogue` DROP COLUMN `idProduit`,
    ADD COLUMN `produitId` INTEGER NULL;

-- AlterTable
ALTER TABLE `ligneproduit` DROP COLUMN `idPack`,
    DROP COLUMN `idPannier`,
    DROP COLUMN `idProduit`,
    ADD COLUMN `packId` INTEGER NULL,
    ADD COLUMN `pannierId` INTEGER NULL,
    ADD COLUMN `produitId` INTEGER NULL;

-- AlterTable
ALTER TABLE `pannier` DROP COLUMN `idClient`,
    DROP COLUMN `idPointRamassage`,
    ADD COLUMN `clientId` INTEGER NULL,
    ADD COLUMN `pointramassageId` INTEGER NULL,
    MODIFY `date` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3);

-- AlterTable
ALTER TABLE `producteur_has_produit` DROP PRIMARY KEY,
    DROP COLUMN `idProducteur`,
    DROP COLUMN `idProduit`,
    ADD COLUMN `producteurId` INTEGER NOT NULL AUTO_INCREMENT,
    ADD COLUMN `produitId` INTEGER NOT NULL,
    ADD PRIMARY KEY (`producteurId`, `produitId`);

-- AlterTable
ALTER TABLE `produit` DROP COLUMN `idCategorieProduit`,
    ADD COLUMN `categorieproduitId` INTEGER NULL;

-- CreateIndex
CREATE INDEX `fk_produit_idx` ON `catalogue`(`produitId`);

-- CreateIndex
CREATE INDEX `idPack_idx` ON `ligneproduit`(`packId`);

-- CreateIndex
CREATE INDEX `idPannier_idx` ON `ligneproduit`(`pannierId`);

-- CreateIndex
CREATE INDEX `idProduit_idx` ON `ligneproduit`(`produitId`);

-- CreateIndex
CREATE INDEX `idClient_idx` ON `pannier`(`clientId`);

-- CreateIndex
CREATE INDEX `idPointRamassage_idx` ON `pannier`(`pointramassageId`);

-- CreateIndex
CREATE INDEX `fk_Producteur_has_Produit_Producteur1_idx` ON `producteur_has_produit`(`producteurId`);

-- CreateIndex
CREATE INDEX `fk_Producteur_has_Produit_Produit1_idx` ON `producteur_has_produit`(`produitId`);

-- CreateIndex
CREATE INDEX `fk_Produit_CategorieProduit1_idx` ON `produit`(`categorieproduitId`);

-- AddForeignKey
ALTER TABLE `catalogue` ADD CONSTRAINT `fk_produit` FOREIGN KEY (`produitId`) REFERENCES `produit`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `ligneproduit` ADD CONSTRAINT `packId` FOREIGN KEY (`packId`) REFERENCES `packproduit`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

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
