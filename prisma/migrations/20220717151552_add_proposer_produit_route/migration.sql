/*
  Warnings:

  - You are about to drop the column `valide` on the `producteur` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE `producteur` DROP COLUMN `valide`,
    ADD COLUMN `preinscriptionValide` INTEGER NULL;
