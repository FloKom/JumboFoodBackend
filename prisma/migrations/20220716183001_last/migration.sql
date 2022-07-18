/*
  Warnings:

  - You are about to drop the column `packId` on the `ligneproduit` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE `ligneproduit` DROP FOREIGN KEY `packId`;

-- AlterTable
ALTER TABLE `ligneproduit` DROP COLUMN `packId`,
    ADD COLUMN `packproduitId` INTEGER NULL;

-- CreateIndex
CREATE INDEX `idPack_idx` ON `ligneproduit`(`packproduitId`);

-- AddForeignKey
ALTER TABLE `ligneproduit` ADD CONSTRAINT `packproduitId` FOREIGN KEY (`packproduitId`) REFERENCES `packproduit`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;
