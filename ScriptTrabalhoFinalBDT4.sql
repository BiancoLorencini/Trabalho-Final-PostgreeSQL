create database TrabalhoFinalBD;


--Tabelas(funcionario,quiz,pergunta,resultado)
create table funcionario
(
	id serial primary key,
	nome varchar (100) not null,
	email varchar (100)unique
	not null check(email ~ '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Z|a-z]{2,}$' )
);

create table quiz
(
	id serial primary key,
	dataInicio date default now(),
	dataTermino date,
	tema varchar (255)
);

create table pergunta
(
	id serial primary key,
	enunciado varchar(255),
	correta varchar(100),
	alternativa1 varchar(50),
	alternativa2 varchar(50),
	alternativa3 varchar(50),
	alternativa4 varchar(50),
	quiz_id int,
	foreign key (quiz_id)references quiz(id)
);

create table resultado
(
	id serial primary key,
	pontuacao int,
	dataHora date,
	quiz_id int,
	foreign key (quiz_id)references quiz(id),
	funcionario_id int,
	foreign key (funcionario_id)references funcionario(id),
	pergunta_id int,
	foreign key (pergunta_id)references pergunta(id)
);
--fim tabelas


--populando funcionarios
insert into funcionario (nome, email) values
('Bianco', 'bianco@email.com');
insert into funcionario (nome, email) values
('Ana', 'yukari@email.com');
insert into funcionario (nome, email) values
('Maria', 'madu@email.com');
insert into funcionario (nome, email) values
('Nicole', 'nicole@email.com');
insert into funcionario (nome, email) values
('Kayke', 'kaike@email.com');
--fim funcionarios


--populando quiz
insert into quiz (dataTermino, tema)values
('2024-04-05', 'Natureza');
insert into quiz (dataTermino, tema)values
('2024-04-05', 'Nova Friburgo');
insert into quiz (dataTermino, tema)values
('2024-04-05', 'Dia da Mulher');
insert into quiz (dataTermino, tema)values
('2024-04-05', 'Matemática');
--fim quiz


--populando pergunta1
insert into pergunta (enunciado, correta, alternativa1,
alternativa2, alternativa3, alternativa4, quiz_id)values
('Qual a cor da folha?', 'Verde', 'Roxo', 'Amarelo', 'Laranja', 'Azul', 1);

--populando pergunta2
insert into pergunta (enunciado, correta, alternativa1,
alternativa2, alternativa3, alternativa4, quiz_id)values
('O que as plantas produzem?', 'Oxigênio', 'Gás Carbonico', 'Nitrogênio', 'Hidrogênio', 'Amônia', 2);

--populando pergunta3
insert into pergunta (enunciado, correta, alternativa1,
alternativa2, alternativa3, alternativa4, quiz_id)values
('Quantos anos Nova Frigurgo tem?', '204', '205', '203', '202', '201', 3);

--populando pergunta4
insert into pergunta (enunciado, correta, alternativa1,
alternativa2, alternativa3, alternativa4, quiz_id)values
('Qual é o dia da mulher?', '08 de Março', '15 de Maio', '12 de Abril', '07 de Agosto', '09 de junho', 4);

--populando pergunta5
insert into pergunta (enunciado, correta, alternativa1,
alternativa2, alternativa3, alternativa4, quiz_id)values
('6 x 8?', '48', '52', '38', '42', '46', 5);

--populando pergunta6
insert into pergunta (enunciado, correta, alternativa1,
alternativa2, alternativa3, alternativa4, quiz_id)values
('15 / 2?', '7.5', '8.5', '6.5', '8', '7', 6);

--populando pergunta7
insert into pergunta (enunciado, correta, alternativa1,
alternativa2, alternativa3, alternativa4, quiz_id)values
('30 + 43?', '73', '63', '83', '93', '66', 7);

/*(depois de ter feito, percebi poderia fazer sem precisar repetir
os inserts)*/


--inserindo dados no resultado
--(restante dos dados deletei O.O)
insert into resultado 
( quiz_id, funcionario_id, pergunta_id, datahora, pontuacao) 
values
( 4, 5, 7, '2024-03-28' , 0);

--corrigindo a chave estrangeira(pergunta)
update pergunta set quiz_id = 1 where id = 1;
update pergunta set quiz_id = 2 where id = 2;

--correção de erro de input
update pergunta set correta = '204' where id = 4;
update pergunta set alternativa1 = '205' where id = 4;
update pergunta set alternativa2 = '203' where id = 4;
update pergunta set alternativa3 = '202' where id = 4;
update pergunta set alternativa4 = '201' where id = 4;

--acrescimo de atributos da tabela pergunta
--(para depois ver que não era necessario..o.O)
alter table pergunta add column alternativa5 varchar(50);
alter table pergunta add column alternativa6 varchar(50);
alter table pergunta add column alternativa7 varchar(50);
alter table pergunta drop column alternativa5;
alter table pergunta drop column alternativa6;
alter table pergunta drop column alternativa7;

--reorganização da posição foreign key 
alter table pergunta drop column quiz_id;
alter table pergunta add column quiz_id int;

--havia colocado Natureza com 'n' minusculo
update quiz set tema = 'Natureza' where id = 1;

--havia esquecido a '?'
update pergunta set enunciado = 'Qual a cor da folha?' where id = 1;
update pergunta set enunciado = 'O que as plantas produzem?' where id = 2;

--query basica
select * from funcionario;
select * from quiz;
select * from pergunta;
select * from resultado;

--query verificação da pontuação(individual e por ID)
select sum(pontuacao) as total_pontuacao
from resultado
where funcionario_id  = 3;

--query para achar quem fez maior pontuação entre os funcionarios
select  funcionario.nome, sum(resultado.pontuacao) as total_pontuacao
from funcionario
inner join resultado on funcionario.id = resultado.funcionario_id
group by funcionario.nome
order by total_pontuacao desc
limit 3;

--query para verificar os dados de um funcionario em especifico
select  *
from funcionario
where id = 1;
