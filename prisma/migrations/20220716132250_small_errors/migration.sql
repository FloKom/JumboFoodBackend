-- DropForeignKey
ALTER TABLE `catalogue` DROP FOREIGN KEY `fk_produit`;

-- AddForeignKey
ALTER TABLE `catalogue` ADD CONSTRAINT `fk_produit` FOREIGN KEY (`idProduit`) REFERENCES `produit`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;
