CREATE DATABASE IF NOT EXISTS EjemplosAct2;
USE EjemplosAct2;
 
CREATE TABLE tbUsuarios(
id_usuario INT PRIMARY KEY AUTO_INCREMENT,
nombre VARCHAR (100),
correo VARCHAR (100),
clave VARCHAR (100),
direccion TEXT, 
telefono VARCHAR (20)
);
 
CREATE TABLE tbAdministradores(
id_administrador INT PRIMARY KEY AUTO_INCREMENT,
nombre_administrador VARCHAR (50),
apellido_administrador VARCHAR (50),
correo_administrador VARCHAR (50),
clave_administrador VARCHAR (50),
fecha_registro DATE 
);
 
 
CREATE TABLE tbClasificaciones(
id_clasificacion INT PRIMARY KEY AUTO_INCREMENT,
nombre VARCHAR(20),
descripcion TEXT
);
 
CREATE TABLE tbAutores(
id_autor INT PRIMARY KEY AUTO_INCREMENT,
nombre VARCHAR (30),
biografia TEXT
);
 
CREATE TABLE tbEditoriales(
id_editorial INT PRIMARY KEY AUTO_INCREMENT,
nombre VARCHAR(20)
);
 
CREATE TABLE tbLibros(
id_libro INT PRIMARY KEY AUTO_INCREMENT,
titulo VARCHAR (100),
id_autor INT,
precio DECIMAL (10,2),
descripcion TEXT,
imagen VARCHAR(25),
id_clasificacion INT,
id_editorial INT,
id_administrador INT, 
FOREIGN KEY (id_administrador) REFERENCES tbAdministradores(id_administrador),
FOREIGN KEY (id_autor) REFERENCES tbAutores(id_autor),
FOREIGN KEY (id_clasificacion) REFERENCES tbClasificaciones(id_clasificacion),
FOREIGN KEY (id_editorial) REFERENCES tbEditoriales(id_editorial)
);
CREATE TABLE tbMetodosPagos(
id_metodo_pago INT PRIMARY KEY AUTO_INCREMENT,
nombre VARCHAR(20)
);
CREATE TABLE tbPedidos(
id_pedido INT PRIMARY KEY AUTO_INCREMENT,
fecha_pedido DATETIME,
id_usuario INT, 
estado ENUM('FINALIZADO', 'PENDIENTE', 'ENTREGADO', 'CANCELADO' ),
id_metodo_pago INT, 
FOREIGN KEY (id_usuario) REFERENCES tbUsuarios(id_usuario),
FOREIGN KEY (id_metodo_pago) REFERENCES tbMetodosPagos(id_metodo_pago)
);
CREATE TABLE tbDetallePedido(
id_detalle INT PRIMARY KEY AUTO_INCREMENT,
id_pedido INT,
id_libro INT, 
cantidad INT, 
FOREIGN KEY (id_pedido) REFERENCES tbPedidos(id_pedido),
FOREIGN KEY (id_libro) REFERENCES tbLibros(id_libro)
);
 
CREATE TABLE tbResena(
id_resena INT PRIMARY KEY AUTO_INCREMENT,
id_libro INT,
id_usuario INT,
titulo VARCHAR (50),
contenido VARCHAR (250),
puntuacion INT, 
FOREIGN KEY (id_libro) REFERENCES tbLibros(id_libro),
FOREIGN KEY (id_usuario) REFERENCES tbUsuarios(id_usuario)
);

--Funciones de agregado en MYSQL--

SELECT COUNT(id_libro) AS total_libros FROM tbLibros;

SELECT AVG(precio) AS precio_promedio FROM tbLibros;

--Tipos de JOIN en MySQL--
SELECT l.titulo, a.nombre AS autor
FROM tbLibros l
INNER JOIN tbAutores a ON l.id_autor = a.id_autor;

SELECT l.titulo, a.nombre AS autor
FROM tbLibros l
LEFT JOIN tbAutores a ON l.id_autor = a.id_autor;

--Subconsultas en MySQL--
SELECT titulo, precio
FROM tbLibros
WHERE precio > (SELECT AVG(precio) FROM tbLibros);
