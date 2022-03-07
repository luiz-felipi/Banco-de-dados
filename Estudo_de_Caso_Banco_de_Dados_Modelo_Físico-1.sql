-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema BD_faculdade
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema BD_faculdade
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `BD_faculdade` DEFAULT CHARACTER SET utf8 COLLATE utf8_swedish_ci ;
USE `BD_faculdade` ;

-- -----------------------------------------------------
-- Table `BD_faculdade`.`departamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BD_faculdade`.`departamento` (
  `Cod_departamento` INT NOT NULL AUTO_INCREMENT,
  `Nome_departamento` VARCHAR(40) NOT NULL,
  PRIMARY KEY (`Cod_departamento`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `BD_faculdade`.`curso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BD_faculdade`.`curso` (
  `Cod_curso` INT NOT NULL,
  `Nome_curso` VARCHAR(50) NOT NULL,
  `Cod_departamento` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`Cod_curso`),
  INDEX `Cod_departamento_idx` (`Cod_departamento` ASC),
  CONSTRAINT `fk_Cod_departamento`
    FOREIGN KEY (`Cod_departamento`)
    REFERENCES `BD_faculdade`.`departamento` (`Cod_departamento`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `BD_faculdade`.`turma`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BD_faculdade`.`turma` (
  `Cod_turma` INT NOT NULL,
  `Cod_curso` INT NOT NULL,
  `Num_alunos` INT NULL DEFAULT NULL,
  `Periodo` VARCHAR(45) NULL DEFAULT NULL,
  `Data_inicio` VARCHAR(45) NULL DEFAULT NULL,
  `Data_fim` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`Cod_turma`),
  INDEX `Cod_curso_idx` (`Cod_curso` ASC),
  CONSTRAINT `fk_cod_curso`
    FOREIGN KEY (`Cod_curso`)
    REFERENCES `BD_faculdade`.`curso` (`Cod_curso`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `BD_faculdade`.`aluno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BD_faculdade`.`aluno` (
  `Cod_aluno` INT NOT NULL,
  `Nome_aluno` VARCHAR(50) NOT NULL,
  `Sobrenome_aluno` VARCHAR(50) NOT NULL,
  `Cpf` VARCHAR(11) NOT NULL,
  `Status` TINYINT NOT NULL,
  `Sexo` CHAR(1) NOT NULL,
  `Cod_turma` INT NOT NULL,
  `Cod_curso` INT NOT NULL,
  `Nome_mãe` VARCHAR(50) NOT NULL,
  `Nome_pai` VARCHAR(50) NULL DEFAULT NULL,
  `Email` VARCHAR(45) NULL DEFAULT NULL,
  `Whatsapp` VARCHAR(10) CHARACTER SET 'utf8' COLLATE 'utf8_swedish_ci' NOT NULL,
  PRIMARY KEY (`Cod_aluno`),
  UNIQUE INDEX `Cpf_UNIQUE` (`Cpf` ASC),
  INDEX `Cod_turma_idx` (`Cod_turma` ASC),
  INDEX `Cod_curso_idx` (`Cod_curso` ASC),
  CONSTRAINT `Cod_turma`
    FOREIGN KEY (`Cod_turma`)
    REFERENCES `BD_faculdade`.`turma` (`Cod_turma`),
  CONSTRAINT `fks_cod_curso`
    FOREIGN KEY (`Cod_curso`)
    REFERENCES `BD_faculdade`.`curso` (`Cod_curso`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `BD_faculdade`.`disciplina`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BD_faculdade`.`disciplina` (
  `Cod_disciplina` INT NOT NULL,
  `Nome_disciplina` VARCHAR(45) NOT NULL,
  `Cod_departamento` INT NOT NULL AUTO_INCREMENT,
  `Num_alunos` INT NULL DEFAULT NULL,
  `Carga_horaria` INT NOT NULL,
  `Descrição` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`Cod_disciplina`),
  INDEX `fk_cod__departamento_idx` (`Cod_departamento` ASC),
  CONSTRAINT `fk_cod__departamento`
    FOREIGN KEY (`Cod_departamento`)
    REFERENCES `BD_faculdade`.`departamento` (`Cod_departamento`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `BD_faculdade`.`aluno_disciplina`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BD_faculdade`.`aluno_disciplina` (
  `Cod_aluno` INT NOT NULL AUTO_INCREMENT,
  `Cod_disciplina` INT NOT NULL,
  PRIMARY KEY (`Cod_aluno`),
  INDEX `Cod_disciplina_idx` (`Cod_disciplina` ASC),
  CONSTRAINT `fk1_cod_disciplina`
    FOREIGN KEY (`Cod_disciplina`)
    REFERENCES `BD_faculdade`.`disciplina` (`Cod_disciplina`),
  CONSTRAINT `Ra`
    FOREIGN KEY (`Cod_aluno`)
    REFERENCES `BD_faculdade`.`aluno` (`Cod_aluno`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `BD_faculdade`.`curso_disciplina`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BD_faculdade`.`curso_disciplina` (
  `Cod_disciplina` INT NOT NULL AUTO_INCREMENT,
  `Cod_curso` INT NOT NULL,
  PRIMARY KEY (`Cod_disciplina`),
  INDEX `Cod_curso_idx` (`Cod_curso` ASC),
  CONSTRAINT `Cod_curso`
    FOREIGN KEY (`Cod_curso`)
    REFERENCES `BD_faculdade`.`curso` (`Cod_curso`),
  CONSTRAINT `fk_cod_disciplina`
    FOREIGN KEY (`Cod_disciplina`)
    REFERENCES `BD_faculdade`.`disciplina` (`Cod_disciplina`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `BD_faculdade`.`depende`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BD_faculdade`.`depende` (
  `Cod_disciplina` INT NOT NULL,
  `Possui_cod_disciplina` INT NOT NULL,
  PRIMARY KEY (`Cod_disciplina`),
  CONSTRAINT `fk3_cod_disciplina`
    FOREIGN KEY (`Cod_disciplina`)
    REFERENCES `BD_faculdade`.`disciplina` (`Cod_disciplina`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `BD_faculdade`.`historico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BD_faculdade`.`historico` (
  `Cod_historico` INT NOT NULL,
  `Cod_aluno` INT NOT NULL AUTO_INCREMENT,
  `Data_inicio` DATE NULL DEFAULT NULL,
  `Data_final` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`Cod_historico`),
  INDEX `Ra_idx` (`Cod_aluno` ASC),
  CONSTRAINT `fk2_cod_aluno`
    FOREIGN KEY (`Cod_aluno`)
    REFERENCES `BD_faculdade`.`aluno` (`Cod_aluno`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `BD_faculdade`.`disc_historico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BD_faculdade`.`disc_historico` (
  `Cod_historico` INT NOT NULL,
  `Cod_disciplina` INT NOT NULL AUTO_INCREMENT,
  `Nota` FLOAT NOT NULL,
  `Frequencia` INT NOT NULL,
  PRIMARY KEY (`Cod_historico`),
  INDEX `Cod_disciplina_idx` (`Cod_disciplina` ASC),
  CONSTRAINT `fk1_cod_historico`
    FOREIGN KEY (`Cod_historico`)
    REFERENCES `BD_faculdade`.`historico` (`Cod_historico`),
  CONSTRAINT `fk5_cod_disciplina`
    FOREIGN KEY (`Cod_disciplina`)
    REFERENCES `BD_faculdade`.`disciplina` (`Cod_disciplina`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `BD_faculdade`.`endereço_aluno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BD_faculdade`.`endereço_aluno` (
  `Cod_endereco_aluno` INT NOT NULL,
  `Cod_aluno` INT NOT NULL AUTO_INCREMENT,
  `Cod_tipo_logradouro` INT NOT NULL,
  `Nome_rua` VARCHAR(45) NOT NULL,
  `Num_rua` INT NULL DEFAULT NULL,
  `Complemento` VARCHAR(45) NULL DEFAULT NULL,
  `Cep` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Cod_endereco_aluno`),
  INDEX `Ra_idx` (`Cod_aluno` ASC) ,
  CONSTRAINT `fk_cod_aluno`
    FOREIGN KEY (`Cod_aluno`)
    REFERENCES `BD_faculdade`.`aluno` (`Cod_aluno`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `BD_faculdade`.`professor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BD_faculdade`.`professor` (
  `Cod_professor` INT NOT NULL,
  `Nome_professor` VARCHAR(50) NOT NULL,
  `Sobrenome_professor` VARCHAR(50) NOT NULL,
  `Status` TINYINT NULL DEFAULT NULL,
  `Cod_departamento` INT NOT NULL,
  PRIMARY KEY (`Cod_professor`),
  INDEX `Cod_departamento_idx` (`Cod_departamento` ASC),
  CONSTRAINT `Cod_departamento`
    FOREIGN KEY (`Cod_departamento`)
    REFERENCES `BD_faculdade`.`departamento` (`Cod_departamento`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `BD_faculdade`.`professor_disc`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BD_faculdade`.`professor_disc` (
  `Cod_professor` INT NOT NULL AUTO_INCREMENT,
  `Cod_disciplina` INT NOT NULL,
  PRIMARY KEY (`Cod_professor`),
  INDEX `Cod_disciplina_idx` (`Cod_disciplina` ASC),
  CONSTRAINT `Cod_disciplina`
    FOREIGN KEY (`Cod_disciplina`)
    REFERENCES `BD_faculdade`.`disciplina` (`Cod_disciplina`),
  CONSTRAINT `Cod_professor`
    FOREIGN KEY (`Cod_professor`)
    REFERENCES `BD_faculdade`.`professor` (`Cod_professor`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `BD_faculdade`.`tipo_telefone`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BD_faculdade`.`tipo_telefone` (
  `Cod_tipo_telefone` INT NOT NULL,
  `Tipo_telefone` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`Cod_tipo_telefone`),
  CONSTRAINT `Cod_tipo_telefone`
    FOREIGN KEY (`Cod_tipo_telefone`)
    REFERENCES `BD_faculdade`.`telefone_aluno` (`Cod_telefone_aluno`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `BD_faculdade`.`telefone_aluno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BD_faculdade`.`telefone_aluno` (
  `Cod_telefone_aluno` INT NOT NULL,
  `Cod_aluno` INT NOT NULL,
  `Cod_tipo_telefone` INT NOT NULL,
  `Num_telefone` VARCHAR(11) NOT NULL,
  PRIMARY KEY (`Cod_telefone_aluno`),
  INDEX `Ra_idx` (`Cod_aluno` ASC),
  INDEX `Cod_tipo_telefone_idx` (`Cod_tipo_telefone` ASC),
  CONSTRAINT `Cod_aluno`
    FOREIGN KEY (`Cod_aluno`)
    REFERENCES `BD_faculdade`.`aluno` (`Cod_aluno`),
  CONSTRAINT `fk_cod_tipo_telefone`
    FOREIGN KEY (`Cod_tipo_telefone`)
    REFERENCES `BD_faculdade`.`tipo_telefone` (`Cod_tipo_telefone`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `BD_faculdade`.`tipo_logradouro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BD_faculdade`.`tipo_logradouro` (
  `Cod_tipo_logradouro` INT NOT NULL,
  `Tipo_logradouroco` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`Cod_tipo_logradouro`),
  CONSTRAINT `Cod_tipo_logradouro`
    FOREIGN KEY (`Cod_tipo_logradouro`)
    REFERENCES `BD_faculdade`.`endereço_aluno` (`Cod_endereco_aluno`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
