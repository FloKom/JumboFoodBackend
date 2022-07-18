/*
  Warnings:

  - The primary key for the `admin` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `idAdmin` on the `admin` table. All the data in the column will be lost.
  - You are about to drop the column `date` on the `catalogue` table. All the data in the column will be lost.
  - The primary key for the `ligneproduit` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `idLigneProduit` on the `ligneproduit` table. All the data in the column will be lost.
  - The primary key for the `ropert` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `idManager` on the `ropert` table. All the data in the column will be lost.
  - Added the required column `id` to the `admin` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updatedAt` to the `catalogue` table without a default value. This is not possible if the table is not empty.
  - Added the required column `id` to the `ligneproduit` table without a default value. This is not possible if the table is not empty.
  - Added the required column `id` to the `ropert` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `admin` DROP PRIMARY KEY,
    DROP COLUMN `idAdmin`,
    ADD COLUMN `id` INTEGER NOT NULL AUTO_INCREMENT,
    ADD PRIMARY KEY (`id`);

-- AlterTable
ALTER TABLE `catalogue` DROP COLUMN `date`,
    ADD COLUMN `dateApprovisionnement` DATE NULL,
    ADD COLUMN `updatedAt` DATETIME(3) NOT NULL;

-- AlterTable
ALTER TABLE `ligneproduit` DROP PRIMARY KEY,
    DROP COLUMN `idLigneProduit`,
    ADD COLUMN `id` INTEGER NOT NULL AUTO_INCREMENT,
    ADD PRIMARY KEY (`id`);

-- AlterTable
ALTER TABLE `ropert` DROP PRIMARY KEY,
    DROP COLUMN `idManager`,
    ADD COLUMN `id` INTEGER NOT NULL AUTO_INCREMENT,
    ADD PRIMARY KEY (`id`);
