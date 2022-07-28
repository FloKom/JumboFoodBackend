/*
  Warnings:

  - You are about to drop the column `nomClient` on the `client` table. All the data in the column will be lost.
  - You are about to drop the column `quantiteCommande` on the `ligneproduit` table. All the data in the column will be lost.
  - You are about to drop the column `nomPack` on the `packproduit` table. All the data in the column will be lost.
  - You are about to drop the column `nomProducteur` on the `producteur` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE `client` DROP COLUMN `nomClient`,
    ADD COLUMN `nom` VARCHAR(45) NULL,
    ADD COLUMN `prenom` VARCHAR(45) NULL;

-- AlterTable
ALTER TABLE `ligneproduit` DROP COLUMN `quantiteCommande`,
    ADD COLUMN `quantite` INTEGER NULL;

-- AlterTable
ALTER TABLE `packproduit` DROP COLUMN `nomPack`,
    ADD COLUMN `nom` VARCHAR(45) NULL;

-- AlterTable
ALTER TABLE `producteur` DROP COLUMN `nomProducteur`,
    ADD COLUMN `nom` VARCHAR(45) NULL,
    ADD COLUMN `prenom` VARCHAR(45) NULL;

-- AlterTable
ALTER TABLE `ropert` ADD COLUMN `prenom` VARCHAR(45) NULL;
