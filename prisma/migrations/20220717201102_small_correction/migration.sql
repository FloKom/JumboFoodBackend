/*
  Warnings:

  - You are about to drop the column `logitude` on the `producteur` table. All the data in the column will be lost.
  - You are about to alter the column `preinscriptionValide` on the `producteur` table. The data in that column could be lost. The data in that column will be cast from `VarChar(191)` to `VarChar(45)`.

*/
-- AlterTable
ALTER TABLE `producteur` DROP COLUMN `logitude`,
    ADD COLUMN `longitude` DOUBLE NULL,
    MODIFY `preinscriptionValide` VARCHAR(45) NULL DEFAULT 'en attente';
