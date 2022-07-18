/*
  Warnings:

  - You are about to alter the column `prix` on the `pannier` table. The data in that column could be lost. The data in that column will be cast from `VarChar(45)` to `Double`.
  - You are about to drop the column `lieu` on the `pointramassage` table. All the data in the column will be lost.
  - You are about to drop the column `localisation` on the `producteur` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE `pannier` MODIFY `prix` DOUBLE NOT NULL;

-- AlterTable
ALTER TABLE `pointramassage` DROP COLUMN `lieu`,
    ADD COLUMN `latitude` DOUBLE NULL,
    ADD COLUMN `longitude` DOUBLE NULL;

-- AlterTable
ALTER TABLE `producteur` DROP COLUMN `localisation`,
    ADD COLUMN `latitude` DOUBLE NULL,
    ADD COLUMN `logitude` DOUBLE NULL;

-- AlterTable
ALTER TABLE `produit` MODIFY `photoURL` VARCHAR(1000) NULL;
