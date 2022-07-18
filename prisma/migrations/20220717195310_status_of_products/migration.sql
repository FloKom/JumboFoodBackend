-- AlterTable
ALTER TABLE `producteur` MODIFY `preinscriptionValide` VARCHAR(191) NULL DEFAULT 'en attente';

-- AlterTable
ALTER TABLE `producteur_has_produit` MODIFY `statut` VARCHAR(45) NULL DEFAULT 'en attente';
