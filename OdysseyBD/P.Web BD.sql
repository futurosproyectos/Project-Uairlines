-- Cerrar conexiones activas a la base de datos
USE master;
ALTER DATABASE Sistema_Reserva_Vuelos SET SINGLE_USER WITH ROLLBACK IMMEDIATE;

-- Eliminar la base de datos si existe
IF DB_ID('Sistema_Reserva_Vuelos') IS NOT NULL  
BEGIN  
    DROP DATABASE Sistema_Reserva_Vuelos;  
    PRINT 'La base de datos Sistema_Reserva_Vuelos fue eliminada.';  
END  
ELSE  
BEGIN  
    PRINT 'La base de datos Sistema_Reserva_Vuelos no existe.';  
END  
GO  

-- Crear la base de datos  
CREATE DATABASE Sistema_Reserva_Vuelos;  
PRINT 'La base de datos Sistema_Reserva_Vuelos fue creada.';  
GO  

-- Usar la base de datos creada  
USE Sistema_Reserva_Vuelos;  
PRINT 'Usando la base de datos Sistema_Reserva_Vuelos.';  
GO  


-- Crear tabla de usuarios  
CREATE TABLE Usuarios (  
    id INT IDENTITY(1,1) PRIMARY KEY,  
    nombre VARCHAR(100) NOT NULL,  
    email VARCHAR(100) NOT NULL UNIQUE,  
    password VARCHAR(255) NOT NULL,  
    fecha_registro DATETIME DEFAULT GETDATE()  
);  
GO  

-- Crear tabla de vuelos  
CREATE TABLE Vuelos (  
    id INT IDENTITY(1,1) PRIMARY KEY,  
    compania VARCHAR(100) NOT NULL,  
    origen VARCHAR(3) NOT NULL,  
    destino VARCHAR(3) NOT NULL,  
    fecha DATE NOT NULL,  
    hora_salida TIME NOT NULL,  
    hora_llegada TIME NOT NULL,  
    duracion TIME NOT NULL,  
    precio_turista DECIMAL(10, 2) NOT NULL CHECK (precio_turista >= 0),  
    precio_business DECIMAL(10, 2) NOT NULL CHECK (precio_business >= 0),  
    precio_primera DECIMAL(10, 2) NOT NULL CHECK (precio_primera >= 0)  
);  
GO  

-- Crear tabla de reservas  
CREATE TABLE Reservas (  
    id INT IDENTITY(1,1) PRIMARY KEY,  
    usuario_id INT NOT NULL,  
    vuelo_id INT NOT NULL,  
    categoria VARCHAR(50) NOT NULL CHECK (categoria IN ('turista', 'business', 'primera')),  
    pasajeros INT NOT NULL CHECK (pasajeros > 0),  
    fecha_reserva DATETIME DEFAULT GETDATE(),  
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(id) ON DELETE CASCADE,  
    FOREIGN KEY (vuelo_id) REFERENCES Vuelos(id) ON DELETE CASCADE  
);  
GO  

-- Crear tabla de pagos  
CREATE TABLE Pagos (  
    id INT IDENTITY(1,1) PRIMARY KEY,  
    reserva_id INT NOT NULL,  
    metodo_pago VARCHAR(50) NOT NULL CHECK (metodo_pago IN ('tarjeta', 'paypal', 'transferencia')),  
    monto DECIMAL(10, 2) NOT NULL CHECK (monto >= 0),  
    fecha_pago DATETIME DEFAULT GETDATE(),  
    FOREIGN KEY (reserva_id) REFERENCES Reservas(id) ON DELETE CASCADE  
);  
GO  

-- Insertar datos de ejemplo en la tabla Vuelos  
INSERT INTO Vuelos (compania, origen, destino, fecha, hora_salida, hora_llegada, duracion, precio_turista, precio_business, precio_primera)  
VALUES   
('Iberia', 'PT', 'MAD', '2024-11-10', '20:30:00', '21:45:00', '01:15:00', 100.50, 250.00, 400.00),  
('Vuela Taco', 'RD', 'PD', '2024-11-10', '22:15:00', '23:30:00', '01:15:00', 113.00, 220.00, 380.00),  
('JET Blue', 'RD', 'BCN', '2024-11-10', '01:45:00', '03:00:00', '01:15:00', 65.80, 190.00, 350.00);  
GO 

IF NOT EXISTS (SELECT * FROM sysobjects WHERE id = OBJECT_ID(N'[dbo].[sysdiagrams]') AND xtype='U')
BEGIN
    CREATE TABLE sysdiagrams (
        diagram_id INT PRIMARY KEY IDENTITY,
        name NVARCHAR(128) NOT NULL,
        principal_id INT NOT NULL,
        version INT,
        definition VARBINARY(MAX)
    );
END;
