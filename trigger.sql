CREATE TABLE Pedidos (
IDPedido INT AUTO_INCREMENT PRIMARY KEY,

DataPedido DATETIME,

NomeCliente VARCHAR(100)
);
-- Inserção de dados de exemplo
INSERT INTO Pedidos (DataPedido, NomeCliente) VALUES
(NOW(), 'Josefa'),
(NOW(), 'Carlos'),
(NOW(), 'Joana');

select * from pedidos;

DELIMITER $
CREATE TRIGGER RegistroDataCriacaoPedido
BEFORE INSERT ON Pedidos
FOR EACH ROW
BEGIN
SET NEW. DataPedido = NOW();
END;
$
DELIMITER ;

insert into pedidos (NomeCliente) values ('Candida');

select * from pedidos;

create table Filmes(
id int primary key not null auto_increment,
titulo varchar(200),
minutos int
);

-- Definição do Delimitador
delimiter $

-- Criação de um Trigger
-- Este trigger será acionado antes de uma inserção na tabela "filmes"
-- "before insert" indica que o gatilho será executado antes de uma nova linha ser inserida na tabela
create trigger check_minutos before insert on filmes

-- O gatilho vai iterar por cada linha afetada pela inserção
for each row

-- Início do bloco do gatilho
begin
    -- Condição: Verificar se o valor da coluna "minutos" na nova linha ("new.minutos") é menor que 0
    if new.minutos < 0 then
        -- Se a condição for atendida, o gatilho será acionado
        -- Ele define o valor da coluna "minutos" como NULL
        set new.minutos = null;
    end if;
-- Fim do bloco do gatilho
end$

-- Restauração do Delimitador padrão
delimiter ;

INSERT INTO Filmes (titulo, minutos) VALUES ("The terrible trigger", 120);
INSERT INTO Filmes (titulo, minutos) VALUES ("O alto da compadecida", 135);
INSERT INTO Filmes (titulo, minutos) VALUES ("Faroeste caboclo", 246);
INSERT INTO Filmes (titulo, minutos) VALUES ("The matrix", 90);
INSERT INTO Filmes (titulo, minutos) VALUES ("Blade runner", -88);
INSERT INTO Filmes (titulo, minutos) VALUES ("O labirinto do fauno", 110);
INSERT INTO Filmes (titulo, minutos) VALUES ("Metropole", 0);
INSERT INTO Filmes (titulo, minutos) VALUES ("A lista", 120);

select * from Filmes;

-- Definição do Delimitador
DELIMITER $
-- Criação do Trigger
CREATE TRIGGER chk_minutos BEFORE INSERT ON Filmes
FOR EACH ROW
BEGIN
    DECLARE custom_message VARCHAR(255);

    IF new.minutos <= 0 THEN
        -- Atribuir a mensagem de erro personalizada à variável
        SET custom_message = "Valor inválido para minutos";

        -- Lançar um Erro com mensagem personalizada e código de erro
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = custom_message;
    END IF;
END$
-- Restauração do Delimitador Padrão
DELIMITER ;

insert into filmes (titulo, minutos) values ('Arca de Noé', 0);

select * from filmes;

create table Log_deletions (
id int primary key not null auto_increment,
titulo varchar(60),
quando datetime,
quem varchar(40)
);

delimiter $
create trigger log_deletions after delete on Filmes
	for each row 
    begin
		insert into log_deletions values (null, old.titulo, sysdate(), user());
	end$
delimiter ;

delete from filmes where id = 2;
delete from filmes where id = 3;

select * from log_deletions;




