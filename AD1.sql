-- MySQL Script generated by MySQL Workbench
-- Thu Sep 24 19:18:56 2020
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Pesquisa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pesquisa` (
  `idPesquisa` INT NOT NULL,
  `status` VARCHAR(45) NULL,
  `nome` VARCHAR(45) NULL,
  `dataAgendada` DATETIME NULL,
  `prazo` VARCHAR(45) NULL,
  PRIMARY KEY (`idPesquisa`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Perfil`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Perfil` (
  `nome` VARCHAR(45) NULL,
  `cpf` INT NOT NULL,
  `email` VARCHAR(45) NULL,
  `telefone` INT NULL,
  `tipoUsuario` VARCHAR(45) NULL,
  PRIMARY KEY (`cpf`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`LogUsuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`LogUsuario` (
  `idLogUsuario` INT NOT NULL,
  `descricao` VARCHAR(45) NULL,
  `acao` VARCHAR(45) NULL,
  `data` VARCHAR(45) NULL,
  PRIMARY KEY (`idLogUsuario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Usuario` (
  `nomeUsuario` VARCHAR(45) NOT NULL,
  `senha` VARCHAR(45) NULL,
  `Perfil_idPerfil` INT NOT NULL,
  `LogUsuario_idLogUsuario` INT NOT NULL,
  PRIMARY KEY (`nomeUsuario`, `Perfil_idPerfil`, `LogUsuario_idLogUsuario`),
  INDEX `fk_Usuario_Perfil_idx` (`Perfil_idPerfil` ASC) VISIBLE,
  INDEX `fk_Usuario_LogUsuario1_idx` (`LogUsuario_idLogUsuario` ASC) VISIBLE,
  CONSTRAINT `fk_Usuario_Perfil`
    FOREIGN KEY (`Perfil_idPerfil`)
    REFERENCES `mydb`.`Perfil` (`nome`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuario_LogUsuario1`
    FOREIGN KEY (`LogUsuario_idLogUsuario`)
    REFERENCES `mydb`.`LogUsuario` (`idLogUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Questoes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Questoes` (
  `idQuestoes` INT NOT NULL,
  `tipo` VARCHAR(45) NULL,
  `pergunta` VARCHAR(45) NULL,
  `resposta` VARCHAR(45) NULL,
  PRIMARY KEY (`idQuestoes`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Questionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Questionario` (
  `idQuestionario` INT NOT NULL,
  `descricao` VARCHAR(45) NULL,
  `titulo` VARCHAR(45) NULL,
  PRIMARY KEY (`idQuestionario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Usuario_gerencia_Questionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Usuario_gerencia_Questionario` (
  `Usuario_nomeUsuario` VARCHAR(45) NOT NULL,
  `Usuario_Perfil_idPerfil` INT NOT NULL,
  `Questionario_idQuestionario` INT NOT NULL,
  PRIMARY KEY (`Usuario_nomeUsuario`, `Usuario_Perfil_idPerfil`, `Questionario_idQuestionario`),
  INDEX `fk_Usuario_has_Questionario_Questionario1_idx` (`Questionario_idQuestionario` ASC) VISIBLE,
  INDEX `fk_Usuario_has_Questionario_Usuario1_idx` (`Usuario_nomeUsuario` ASC, `Usuario_Perfil_idPerfil` ASC) VISIBLE,
  CONSTRAINT `fk_Usuario_has_Questionario_Usuario1`
    FOREIGN KEY (`Usuario_nomeUsuario` , `Usuario_Perfil_idPerfil`)
    REFERENCES `mydb`.`Usuario` (`nomeUsuario` , `Perfil_idPerfil`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuario_has_Questionario_Questionario1`
    FOREIGN KEY (`Questionario_idQuestionario`)
    REFERENCES `mydb`.`Questionario` (`idQuestionario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Questionario_tem_Questoes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Questionario_tem_Questoes` (
  `Questionario_idQuestionario` INT NOT NULL,
  `Questoes_idQuestoes` INT NOT NULL,
  PRIMARY KEY (`Questionario_idQuestionario`, `Questoes_idQuestoes`),
  INDEX `fk_Questionario_has_Questoes_Questoes1_idx` (`Questoes_idQuestoes` ASC) VISIBLE,
  INDEX `fk_Questionario_has_Questoes_Questionario1_idx` (`Questionario_idQuestionario` ASC) VISIBLE,
  CONSTRAINT `fk_Questionario_has_Questoes_Questionario1`
    FOREIGN KEY (`Questionario_idQuestionario`)
    REFERENCES `mydb`.`Questionario` (`idQuestionario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Questionario_has_Questoes_Questoes1`
    FOREIGN KEY (`Questoes_idQuestoes`)
    REFERENCES `mydb`.`Questoes` (`idQuestoes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pesquisa_tem_Questionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pesquisa_tem_Questionario` (
  `Pesquisa_idPesquisa` INT NOT NULL,
  `Questionario_idQuestionario` INT NOT NULL,
  PRIMARY KEY (`Pesquisa_idPesquisa`, `Questionario_idQuestionario`),
  INDEX `fk_Pesquisa_has_Questionario_Questionario1_idx` (`Questionario_idQuestionario` ASC) VISIBLE,
  INDEX `fk_Pesquisa_has_Questionario_Pesquisa1_idx` (`Pesquisa_idPesquisa` ASC) VISIBLE,
  CONSTRAINT `fk_Pesquisa_has_Questionario_Pesquisa1`
    FOREIGN KEY (`Pesquisa_idPesquisa`)
    REFERENCES `mydb`.`Pesquisa` (`idPesquisa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pesquisa_has_Questionario_Questionario1`
    FOREIGN KEY (`Questionario_idQuestionario`)
    REFERENCES `mydb`.`Questionario` (`idQuestionario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Clientes_Consultores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Clientes_Consultores` (
  `cpf` INT NOT NULL,
  `cnpj` VARCHAR(45) NULL,
  `nome` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `telefone` INT NULL,
  PRIMARY KEY (`cpf`, `cnpj`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Clientes_Consultores_respondem_Pesquisa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Clientes_Consultores_respondem_Pesquisa` (
  `Clientes_Consultores_cpf` INT NOT NULL,
  `Clientes_Consultores_cnpj` VARCHAR(45) NOT NULL,
  `Pesquisa_idPesquisa` INT NOT NULL,
  PRIMARY KEY (`Clientes_Consultores_cpf`, `Clientes_Consultores_cnpj`, `Pesquisa_idPesquisa`),
  INDEX `fk_Clientes_Consultores_has_Pesquisa_Pesquisa1_idx` (`Pesquisa_idPesquisa` ASC) VISIBLE,
  INDEX `fk_Clientes_Consultores_has_Pesquisa_Clientes_Consultores1_idx` (`Clientes_Consultores_cpf` ASC, `Clientes_Consultores_cnpj` ASC) VISIBLE,
  CONSTRAINT `fk_Clientes_Consultores_has_Pesquisa_Clientes_Consultores1`
    FOREIGN KEY (`Clientes_Consultores_cpf` , `Clientes_Consultores_cnpj`)
    REFERENCES `mydb`.`Clientes_Consultores` (`cpf` , `cnpj`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Clientes_Consultores_has_Pesquisa_Pesquisa1`
    FOREIGN KEY (`Pesquisa_idPesquisa`)
    REFERENCES `mydb`.`Pesquisa` (`idPesquisa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
