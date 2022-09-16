/*
  Warnings:

  - A unique constraint covering the columns `[produitId]` on the table `catalogue` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX `catalogue_produitId_key` ON `catalogue`(`produitId`);
