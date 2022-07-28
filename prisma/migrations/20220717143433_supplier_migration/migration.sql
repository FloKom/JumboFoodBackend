/*
  Warnings:

  - You are about to drop the column `conditionnement` on the `producteur` table. All the data in the column will be lost.
  - You are about to drop the column `frequenceProduction` on the `producteur` table. All the data in the column will be lost.
  - You are about to drop the column `saisonnier` on the `producteur` table. All the data in the column will be lost.
  - You are about to drop the column `volumeProduction` on the `producteur` table. All the data in the column will be lost.
  - You are about to drop the column `conditionnement` on the `produit` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE `producteur` DROP COLUMN `conditionnement`,
    DROP COLUMN `frequenceProduction`,
    DROP COLUMN `saisonnier`,
    DROP COLUMN `volumeProduction`;

-- AlterTable
ALTER TABLE `producteur_has_produit` ADD COLUMN `conditionnement` VARCHAR(45) NULL,
    ADD COLUMN `frequenceProduction` INTEGER NULL,
    ADD COLUMN `photoURL` VARCHAR(1000) NULL,
    ADD COLUMN `saisonnier` VARCHAR(45) NULL,
    ADD COLUMN `statut` VARCHAR(45) NULL,
    ADD COLUMN `volumeProduction` INTEGER NULL;

-- AlterTable
ALTER TABLE `produit` DROP COLUMN `conditionnement`;
