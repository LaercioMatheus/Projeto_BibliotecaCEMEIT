-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 05-Nov-2024 às 21:55
-- Versão do servidor: 10.4.22-MariaDB
-- versão do PHP: 8.1.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `base_data_bibliocemeit`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `administrador_bibliotecario`
--

CREATE TABLE `administrador_bibliotecario` (
  `codAdminBiblio` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `telefone` varchar(11) NOT NULL,
  `turno` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `administrador_bibliotecario`
--

INSERT INTO `administrador_bibliotecario` (`codAdminBiblio`, `nome`, `telefone`, `turno`) VALUES
(1, 'Admin Raquel Gomes', '6123456765', 'Matutino'),
(2, 'Admin Gustavo Santos', '6135964098', 'Vespertino'),
(3, 'Admin Maria Lopes', '6130746286', 'Matutino'),
(4, 'Admin Arthur Costa', '6198523940', 'Vespertino');

-- --------------------------------------------------------

--
-- Estrutura da tabela `alunos`
--

CREATE TABLE `alunos` (
  `cpf` int(15) NOT NULL,
  `matricula` varchar(20) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `idade` int(11) NOT NULL,
  `data_nascimento` date NOT NULL,
  `email` varchar(60) NOT NULL,
  `telefone` varchar(11) NOT NULL,
  `turma` char(1) NOT NULL,
  `serie` int(11) NOT NULL,
  `turno` varchar(20) NOT NULL,
  `tipo` enum('1° ano','2° ano','3° ano') NOT NULL,
  `pendencia` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `autores`
--

CREATE TABLE `autores` (
  `idAutor` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `cpf` int(11) NOT NULL,
  `endereco` varchar(100) NOT NULL,
  `data_nascimento` date NOT NULL,
  `nacionalidade` varchar(45) NOT NULL,
  `biografia` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `e-books`
--

CREATE TABLE `e-books` (
  `idE-book` int(11) NOT NULL,
  `arquivo_ebook` varchar(100) NOT NULL,
  `qr_code_ebook` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `editoras`
--

CREATE TABLE `editoras` (
  `idEditora` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `endereco` varchar(100) NOT NULL,
  `cnpj` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `emprestimos`
--

CREATE TABLE `emprestimos` (
  `idEmprestimo` int(11) NOT NULL,
  `data_emprestimo` date NOT NULL,
  `data_prevista_devolucao` date NOT NULL,
  `data_retorno` date NOT NULL,
  `multa_acumulada` decimal(10,0) NOT NULL,
  `status` enum('No acervo','Emprestado','Devolvido','Atrasado') NOT NULL,
  `Alunos_cpf` int(15) NOT NULL,
  `Livros_Ebook_idlivro` int(11) NOT NULL,
  `E-books_idE-book` int(11) NOT NULL,
  `cod_AdminBiblio` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `livrosebook_autores`
--

CREATE TABLE `livrosebook_autores` (
  `idLivro_Ebook` int(11) NOT NULL,
  `idAutor` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `livros_ebook`
--

CREATE TABLE `livros_ebook` (
  `idLivro_ebook` int(11) NOT NULL,
  `titulo` varchar(100) NOT NULL,
  `autor` varchar(45) NOT NULL,
  `genero` varchar(45) NOT NULL,
  `tipo` enum('literario','didatico') NOT NULL,
  `qr_code_livro` int(11) NOT NULL,
  `isbn` varchar(13) NOT NULL,
  `quantidade_acervo` int(11) NOT NULL,
  `quantidade_disponivel` int(11) NOT NULL,
  `versao_digital` tinyint(4) NOT NULL,
  `data_recebimento` date NOT NULL,
  `Editoras_idEditora` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `login`
--

CREATE TABLE `login` (
  `idLogin` int(11) NOT NULL,
  `login` int(11) NOT NULL,
  `password` varchar(45) NOT NULL,
  `cod_AdminBiblio` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `sugestoes_livros_e_feedbacks`
--

CREATE TABLE `sugestoes_livros_e_feedbacks` (
  `idSugestao_feedback` int(11) NOT NULL,
  `titulo_sugerido` varchar(100) NOT NULL,
  `autor_sugerido` varchar(45) NOT NULL,
  `data_sugestao` date NOT NULL,
  `feedbacks` varchar(255) DEFAULT NULL,
  `Alunos_cpf` int(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `administrador_bibliotecario`
--
ALTER TABLE `administrador_bibliotecario`
  ADD PRIMARY KEY (`codAdminBiblio`);

--
-- Índices para tabela `alunos`
--
ALTER TABLE `alunos`
  ADD PRIMARY KEY (`cpf`),
  ADD UNIQUE KEY `cpf_UNIQUE` (`cpf`);

--
-- Índices para tabela `autores`
--
ALTER TABLE `autores`
  ADD PRIMARY KEY (`idAutor`);

--
-- Índices para tabela `e-books`
--
ALTER TABLE `e-books`
  ADD PRIMARY KEY (`idE-book`);

--
-- Índices para tabela `editoras`
--
ALTER TABLE `editoras`
  ADD PRIMARY KEY (`idEditora`);

--
-- Índices para tabela `emprestimos`
--
ALTER TABLE `emprestimos`
  ADD PRIMARY KEY (`idEmprestimo`),
  ADD KEY `fk_Emprestimos_Alunos1_idx` (`Alunos_cpf`),
  ADD KEY `fk_Emprestimos_Livros_Ebook1_idx` (`Livros_Ebook_idlivro`),
  ADD KEY `fk_Emprestimos_E-books1_idx` (`E-books_idE-book`),
  ADD KEY `fk_Emprestimos_Administrador_bibliotecario1_idx` (`cod_AdminBiblio`);

--
-- Índices para tabela `livrosebook_autores`
--
ALTER TABLE `livrosebook_autores`
  ADD PRIMARY KEY (`idLivro_Ebook`,`idAutor`),
  ADD KEY `fk_Livros_Ebook_has_autores_autores1_idx` (`idAutor`),
  ADD KEY `fk_Livros_Ebook_has_autores_Livros_Ebook1_idx` (`idLivro_Ebook`);

--
-- Índices para tabela `livros_ebook`
--
ALTER TABLE `livros_ebook`
  ADD PRIMARY KEY (`idLivro_ebook`),
  ADD KEY `titulo` (`titulo`),
  ADD KEY `autor` (`autor`),
  ADD KEY `genero` (`genero`),
  ADD KEY `tipo` (`tipo`),
  ADD KEY `fk_Livros_Ebook_Editoras1_idx` (`Editoras_idEditora`);

--
-- Índices para tabela `login`
--
ALTER TABLE `login`
  ADD PRIMARY KEY (`idLogin`),
  ADD KEY `fk_Login_Administrador_bibliotecario1_idx` (`cod_AdminBiblio`);

--
-- Índices para tabela `sugestoes_livros_e_feedbacks`
--
ALTER TABLE `sugestoes_livros_e_feedbacks`
  ADD PRIMARY KEY (`idSugestao_feedback`),
  ADD KEY `fk_Sugestoes_Livros_e_Feedbacks_Alunos1_idx` (`Alunos_cpf`);

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `administrador_bibliotecario`
--
ALTER TABLE `administrador_bibliotecario`
  MODIFY `codAdminBiblio` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de tabela `autores`
--
ALTER TABLE `autores`
  MODIFY `idAutor` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `e-books`
--
ALTER TABLE `e-books`
  MODIFY `idE-book` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `editoras`
--
ALTER TABLE `editoras`
  MODIFY `idEditora` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `emprestimos`
--
ALTER TABLE `emprestimos`
  MODIFY `idEmprestimo` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `livros_ebook`
--
ALTER TABLE `livros_ebook`
  MODIFY `idLivro_ebook` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `login`
--
ALTER TABLE `login`
  MODIFY `idLogin` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `sugestoes_livros_e_feedbacks`
--
ALTER TABLE `sugestoes_livros_e_feedbacks`
  MODIFY `idSugestao_feedback` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `emprestimos`
--
ALTER TABLE `emprestimos`
  ADD CONSTRAINT `fk_Emprestimos_Administrador_bibliotecario1` FOREIGN KEY (`cod_AdminBiblio`) REFERENCES `administrador_bibliotecario` (`codAdminBiblio`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Emprestimos_Alunos1` FOREIGN KEY (`Alunos_cpf`) REFERENCES `alunos` (`cpf`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_Emprestimos_E-books1` FOREIGN KEY (`E-books_idE-book`) REFERENCES `e-books` (`idE-book`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_Emprestimos_Livros_Ebook1` FOREIGN KEY (`Livros_Ebook_idlivro`) REFERENCES `livros_ebook` (`idLivro_ebook`) ON UPDATE CASCADE;

--
-- Limitadores para a tabela `livrosebook_autores`
--
ALTER TABLE `livrosebook_autores`
  ADD CONSTRAINT `fk_Livros_Ebook_has_autores_Livros_Ebook1` FOREIGN KEY (`idLivro_Ebook`) REFERENCES `livros_ebook` (`idLivro_ebook`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_Livros_Ebook_has_autores_autores1` FOREIGN KEY (`idAutor`) REFERENCES `autores` (`idAutor`) ON UPDATE CASCADE;

--
-- Limitadores para a tabela `livros_ebook`
--
ALTER TABLE `livros_ebook`
  ADD CONSTRAINT `fk_Livros_Ebook_Editoras1` FOREIGN KEY (`Editoras_idEditora`) REFERENCES `editoras` (`idEditora`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `login`
--
ALTER TABLE `login`
  ADD CONSTRAINT `fk_Login_Administrador_bibliotecario1` FOREIGN KEY (`cod_AdminBiblio`) REFERENCES `administrador_bibliotecario` (`codAdminBiblio`) ON UPDATE CASCADE;

--
-- Limitadores para a tabela `sugestoes_livros_e_feedbacks`
--
ALTER TABLE `sugestoes_livros_e_feedbacks`
  ADD CONSTRAINT `fk_Sugestoes_Livros_e_Feedbacks_Alunos1` FOREIGN KEY (`Alunos_cpf`) REFERENCES `alunos` (`cpf`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
