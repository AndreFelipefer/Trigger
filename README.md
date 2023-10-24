Trigger <h1 align="center"> Trigger </h1>

## O exercício consiste em reproduzir os dois exemplos de código SQL apresentados em aula, executar as etapas indicadas e verificar os resultados obtidos.

1- REPRODUZA O PRIMEIRO CÓDIGO SUGERIDO NO MYSQL WORKBENCH;
```SQL
CREATE TABLE Pedidos (
IDPedido INT AUTO_INCREMENT PRIMARY KEY,

DataPedido DATETIME,

NomeCliente VARCHAR(100)
);
-- Inserção de dados de exemplo
INSERT INTO Pedidos (DataPedido, NomeCliente) VALUES
(NOW (), 'Josefa'),
(NOW (), 'Carlos'),
(NOW (), 'Joana');

```

2- EXECUTE AS ETAPAS E VERIFIQUE SEUS RESULTADOS;
```SQL
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
```


Comentario sobre o TRIGGER : O trigger criado conforme modelo citado acima, ele define um procedimento que é pré setado para realizar um determinado comando de acordo com o insert criado na qual ele preenche de forma automatica o campo DataPedido ?

3- APÓS A EXECUÇÃO DO PRIMEIRO CÓDIGO REALIZE O SEGUNDO EXEMPLO;
```SQL
create table Filmes(
id int primary key not null auto_increment,
titulo varchar(200),
minutos int
);

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
```

4- FAÇA AS ETAPAS INDICADAS DO SEGUNDO EXEMPLO;
```SQL
INSERT INTO Filmes (titulo, minutos) VALUES ("The terrible trigger", 120);
INSERT INTO Filmes (titulo, minutos) VALUES ("O alto da compadecida", 135);
INSERT INTO Filmes (titulo, minutos) VALUES ("Faroeste caboclo", 246);
INSERT INTO Filmes (titulo, minutos) VALUES ("The matrix", 90);
INSERT INTO Filmes (titulo, minutos) VALUES ("Blade runner", -88);
INSERT INTO Filmes (titulo, minutos) VALUES ("O labirinto do fauno", 110);
INSERT INTO Filmes (titulo, minutos) VALUES ("Metropole", 0);
INSERT INTO Filmes (titulo, minutos) VALUES ("A lista", 120);
```
## Trigger Chk_minutos
```SQL
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
```

### Trigger log_deletions
```SQL
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
```

### Conforme imagem ele pré setou as menor que 0 como NULL

5- VEJA OS RESULTADOS OBTIDOS A CADA TAREFA REALIZADA E TIRE PRINT’S DOS RESULTADOS;
### Resultado Table Pedios - 
![image](https://github.com/AndreFelipefer/Trigger/assets/129207232/86bc2bfd-2c72-4618-a423-2e634d0b03c5)

### Resultado Table Filmes - 

![image](https://github.com/AndreFelipefer/Trigger/assets/129207232/06c147bf-b342-41d7-beaa-f20e7c83ca80)

### Trigger Chk_Minutos

![image](https://github.com/AndreFelipefer/Trigger/assets/129207232/a8624c74-fd26-4e99-a016-fc5e13cec2f8)

### Trigger log_deletions

![image](https://github.com/AndreFelipefer/Trigger/assets/129207232/03ca815a-b69f-4c2f-abb6-fd78e64a1b1b)



# That's ALL



