 create schema alke_wallet;

 use alke_wallet;

create table usuarios(
 user_id int primary key auto_increment,
 nombre varchar(200) NOT NULL ,
 correo varchar(100) not null,
 clave varchar(100) default null,
 saldo int not null,
 fecha_de_creacion datetime not null
);
create table transaccion(
	transaction_id int primary key auto_increment,
    sender_user_id int not null,
    receiver_user_id int not null,
	valor int not null,
    transaction_date datetime not null,
    foreign key(sender_user_id)
		references usuarios(user_id),
    foreign key(receiver_user_id)
		references usuarios(user_id)
);
-- permite definir que un campo sea único
-- unique(currency_name)

create table moneda(
	currency_id int primary key auto_increment,
    currency_name varchar(50) not null,
    currency_symbol varchar(50) not null
);

-- Inserto transacciones
insert into transaccion (sender_user_id,receiver_user_id,valor,transaction_date) 
VALUES (1,2,5000,'2024-03-08 20:26:01'),(3,2,9000,'2024-03-08 20:26:06'),(2,3,25000,'2024-03-08 20:26:13');

-- Inserto usuarios
insert into usuarios (nombre,correo,saldo,fecha_de_creacion)
VALUES ('valentina','vale_98@gmail.com',NULL,10000,'2024-03-08 20:25:48'),('ambar','ambar_95@gmail.com',NULL,30000,'2024-03-08 20:25:52'),('gabriel','gabo_99@gmail.com',NULL,50000,'2024-03-08 20:25:56');


INSERT INTO `alke_wallet`.`moneda`
(`currency_name`,
`currency_symbol`)
VALUES
('Peso CLP',
'$');

-- Agrego campo moneda a transacciones 
alter table transaccion
add column currency_id int not null

-- Agrego llave foranea de moneda a transacciones
alter table transaccion 
add constraint fkcurrency foreign key (currency_id)
references moneda (currency_id) on delete cascade


-- Consulta para obtener el nombre de la moneda elegida por un usuario específico
SELECT US.nombre,MON.CURRENCY_NAME FROM MONEDA AS MON 
INNER JOIN TRANSACCION AS TRANS ON MON.CURRENCY_ID= TRANS.CURRENCY_ID
INNER JOIN usuarios AS US ON TRANS.SENDER_USER_ID=US.user_id
WHERE US.NOMBRE='valentina'

-- Consulta para obtener todas las transacciones registradas
SELECT US.nombre AS 'USUARIO QUE ENVIA', USU2.NOMBRE AS 'USUARIO QUE RECIBE',MON.CURRENCY_NAME,TRANS.VALOR, TRANS.TRANSACCION_DATE FROM MONEDA AS MON 
INNER JOIN TRANSACCION AS TRANS ON MON.CURRENCY_ID= TRANS.CURRENCY_ID
INNER JOIN usuarios AS US ON TRANS.SENDER_USER_ID=US.user_id
INNER JOIN USUARIOS AS USU2 ON TRANS.RECEIVER_USER_ID=USU2.USER_ID

-- Consulta para obtener todas las transacciones realizadas por un usuario específico
SELECT US.nombre AS 'USUARIO QUE ENVIA', USU2.NOMBRE AS 'USUARIO QUE RECIBE',MON.CURRENCY_NAME,TRANS.VALOR, TRANS.TRANSACCION_DATE FROM MONEDA AS MON 
INNER JOIN TRANSACCION AS TRANS ON MON.CURRENCY_ID= TRANS.CURRENCY_ID
INNER JOIN usuarios AS US ON TRANS.SENDER_USER_ID=US.user_id
INNER JOIN USUARIOS AS USU2 ON TRANS.RECEIVER_USER_ID=USU2.USER_ID
WHERE US.NOMBRE='valentina'

-- Sentencia DML para modificar el campo correo electrónico de un usuario específico
update usuarios set correo= 'gabriel_90@gmail.com' where user_id=3


-- Sentencia para eliminar los datos de una transacción (eliminado de la fila completa)
delete from transaccion 
where transaccion_id= 2 
