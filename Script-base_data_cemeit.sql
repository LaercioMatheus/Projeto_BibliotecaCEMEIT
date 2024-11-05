-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema base_data_biblioCemeit
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema base_data_biblioCemeit
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `base_data_biblioCemeit` DEFAULT CHARACTER SET utf8 ;
USE `base_data_biblioCemeit` ;

-- -----------------------------------------------------
-- Table `base_data_biblioCemeit`.`Editoras`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `base_data_biblioCemeit`.`Editoras` (
  `idEditora` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `endereco` VARCHAR(100) NOT NULL,
  `cnpj` INT NOT NULL,
  PRIMARY KEY (`idEditora`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `base_data_biblioCemeit`.`Livros_Ebook`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `base_data_biblioCemeit`.`Livros_Ebook` (
  `idLivro_ebook` INT NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(100) NOT NULL,
  `autor` VARCHAR(45) NOT NULL,
  `genero` VARCHAR(45) NOT NULL,
  `tipo` ENUM('literario', 'didatico') NOT NULL,
  `qr_code_livro` INT NOT NULL,
  `isbn` VARCHAR(13) NOT NULL,
  `quantidade_acervo` INT NOT NULL,
  `quantidade_disponivel` INT NOT NULL,
  `versao_digital` TINYINT NOT NULL,
  `data_recebimento` DATE NOT NULL,
  `Editoras_idEditora` INT NOT NULL,
  PRIMARY KEY (`idLivro_ebook`),
  INDEX `titulo` (`titulo` ASC) ,
  INDEX `autor` (`autor` ASC) ,
  INDEX `genero` (`genero` ASC) ,
  INDEX `tipo` (`tipo` ASC) ,
  INDEX `fk_Livros_Ebook_Editoras1_idx` (`Editoras_idEditora` ASC) ,
  CONSTRAINT `fk_Livros_Ebook_Editoras1`
    FOREIGN KEY (`Editoras_idEditora`)
    REFERENCES `base_data_biblioCemeit`.`Editoras` (`idEditora`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `base_data_biblioCemeit`.`Alunos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `base_data_biblioCemeit`.`Alunos` (
  `cpf` INT(15) NOT NULL,
  `matricula` VARCHAR(20) NOT NULL,
  `nome` VARCHAR(100) NOT NULL,
  `idade` INT NOT NULL,
  `data_nascimento` DATE NOT NULL,
  `email` VARCHAR(60) NOT NULL,
  `telefone` VARCHAR(11) NOT NULL,
  `turma` CHAR(1) NOT NULL,
  `serie` INT(11) NOT NULL,
  `turno` VARCHAR(20) NOT NULL,
  `tipo` ENUM('1° ano', '2° ano', '3° ano') NOT NULL,
  `pendencia` TINYINT NULL,
  PRIMARY KEY (`cpf`),
  UNIQUE INDEX `cpf_UNIQUE` (`cpf` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `base_data_biblioCemeit`.`E-books`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `base_data_biblioCemeit`.`E-books` (
  `idE-book` INT NOT NULL AUTO_INCREMENT,
  `arquivo_ebook` VARCHAR(100) NOT NULL,
  `qr_code_ebook` INT NOT NULL,
  PRIMARY KEY (`idE-book`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `base_data_biblioCemeit`.`Administrador_bibliotecario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `base_data_biblioCemeit`.`Administrador_bibliotecario` (
  `codAdminBiblio` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `telefone` VARCHAR(11) NOT NULL,
  `turno` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`codAdminBiblio`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `base_data_biblioCemeit`.`Emprestimos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `base_data_biblioCemeit`.`Emprestimos` (
  `idEmprestimo` INT NOT NULL AUTO_INCREMENT,
  `data_emprestimo` DATE NOT NULL,
  `data_prevista_devolucao` DATE NOT NULL,
  `data_retorno` DATE NOT NULL,
  `multa_acumulada` DECIMAL NOT NULL,
  `status` ENUM('No acervo', 'Emprestado', 'Devolvido', 'Atrasado') NOT NULL,
  `Alunos_cpf` INT(15) NOT NULL,
  `Livros_Ebook_idlivro` INT NOT NULL,
  `E-books_idE-book` INT NOT NULL,
  `cod_AdminBiblio` INT NOT NULL,
  PRIMARY KEY (`idEmprestimo`),
  INDEX `fk_Emprestimos_Alunos1_idx` (`Alunos_cpf` ASC) ,
  INDEX `fk_Emprestimos_Livros_Ebook1_idx` (`Livros_Ebook_idlivro` ASC) ,
  INDEX `fk_Emprestimos_E-books1_idx` (`E-books_idE-book` ASC) ,
  INDEX `fk_Emprestimos_Administrador_bibliotecario1_idx` (`cod_AdminBiblio` ASC) ,
  CONSTRAINT `fk_Emprestimos_Alunos1`
    FOREIGN KEY (`Alunos_cpf`)
    REFERENCES `base_data_biblioCemeit`.`Alunos` (`cpf`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Emprestimos_Livros_Ebook1`
    FOREIGN KEY (`Livros_Ebook_idlivro`)
    REFERENCES `base_data_biblioCemeit`.`Livros_Ebook` (`idLivro_ebook`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Emprestimos_E-books1`
    FOREIGN KEY (`E-books_idE-book`)
    REFERENCES `base_data_biblioCemeit`.`E-books` (`idE-book`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Emprestimos_Administrador_bibliotecario1`
    FOREIGN KEY (`cod_AdminBiblio`)
    REFERENCES `base_data_biblioCemeit`.`Administrador_bibliotecario` (`codAdminBiblio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `base_data_biblioCemeit`.`Sugestoes_Livros_e_Feedbacks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `base_data_biblioCemeit`.`Sugestoes_Livros_e_Feedbacks` (
  `idSugestao_feedback` INT NOT NULL AUTO_INCREMENT,
  `titulo_sugerido` VARCHAR(100) NOT NULL,
  `autor_sugerido` VARCHAR(45) NOT NULL,
  `data_sugestao` DATE NOT NULL,
  `feedbacks` VARCHAR(255) NULL,
  `Alunos_cpf` INT(15) NOT NULL,
  PRIMARY KEY (`idSugestao_feedback`),
  INDEX `fk_Sugestoes_Livros_e_Feedbacks_Alunos1_idx` (`Alunos_cpf` ASC) ,
  CONSTRAINT `fk_Sugestoes_Livros_e_Feedbacks_Alunos1`
    FOREIGN KEY (`Alunos_cpf`)
    REFERENCES `base_data_biblioCemeit`.`Alunos` (`cpf`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `base_data_biblioCemeit`.`Autores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `base_data_biblioCemeit`.`Autores` (
  `idAutor` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `cpf` INT NOT NULL,
  `endereco` VARCHAR(100) NOT NULL,
  `data_nascimento` DATE NOT NULL,
  `nacionalidade` VARCHAR(45) NOT NULL,
  `biografia` TEXT(255) NOT NULL,
  PRIMARY KEY (`idAutor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `base_data_biblioCemeit`.`LivrosEbook_Autores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `base_data_biblioCemeit`.`LivrosEbook_Autores` (
  `idLivro_Ebook` INT NOT NULL,
  `idAutor` INT NOT NULL,
  PRIMARY KEY (`idLivro_Ebook`, `idAutor`),
  INDEX `fk_Livros_Ebook_has_autores_autores1_idx` (`idAutor` ASC) ,
  INDEX `fk_Livros_Ebook_has_autores_Livros_Ebook1_idx` (`idLivro_Ebook` ASC) ,
  CONSTRAINT `fk_Livros_Ebook_has_autores_Livros_Ebook1`
    FOREIGN KEY (`idLivro_Ebook`)
    REFERENCES `base_data_biblioCemeit`.`Livros_Ebook` (`idLivro_ebook`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Livros_Ebook_has_autores_autores1`
    FOREIGN KEY (`idAutor`)
    REFERENCES `base_data_biblioCemeit`.`Autores` (`idAutor`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `base_data_biblioCemeit`.`Login`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `base_data_biblioCemeit`.`Login` (
  `idLogin` INT NOT NULL AUTO_INCREMENT,
  `login` INT NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `cod_AdminBiblio` INT NOT NULL,
  PRIMARY KEY (`idLogin`),
  INDEX `fk_Login_Administrador_bibliotecario1_idx` (`cod_AdminBiblio` ASC) ,
  CONSTRAINT `fk_Login_Administrador_bibliotecario1`
    FOREIGN KEY (`cod_AdminBiblio`)
    REFERENCES `base_data_biblioCemeit`.`Administrador_bibliotecario` (`codAdminBiblio`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
