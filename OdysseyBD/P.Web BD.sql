
CREATE DATABASE SistemaReservasVuelos;

USE SistemaReservasVuelos;

CREATE TABLE Usuarios (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Vuelos (
    id INT IDENTITY(1,1) PRIMARY KEY,
    compania VARCHAR(100) NOT NULL,
    origen VARCHAR(3) NOT NULL,
    destino VARCHAR(3) NOT NULL,
    fecha DATE NOT NULL,
    hora_salida TIME NOT NULL,
    hora_llegada TIME NOT NULL,
    duracion TIME NOT NULL,
    precio_turista DECIMAL(10, 2) NOT NULL,
    precio_business DECIMAL(10, 2) NOT NULL,
    precio_primera DECIMAL(10, 2) NOT NULL
);

-- Crear tabla de reservas
CREATE TABLE Reservas (
    id INT IDENTITY(1,1) PRIMARY KEY,
    usuario_id INT NOT NULL,
    vuelo_id INT NOT NULL,
    categoria VARCHAR(50) NOT NULL,
    pasajeros INT NOT NULL,
    fecha_reserva DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(id),
    FOREIGN KEY (vuelo_id) REFERENCES Vuelos(id)
);

CREATE TABLE Pagos (
    id INT IDENTITY(1,1) PRIMARY KEY,
    reserva_id INT NOT NULL,
    metodo_pago VARCHAR(50) NOT NULL,
    monto DECIMAL(10, 2) NOT NULL,
    fecha_pago DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (reserva_id) REFERENCES Reservas(id)
);

INSERT INTO Vuelos (compania, origen, destino, fecha, hora_salida, hora_llegada, duracion, precio_turista, precio_business, precio_primera)
VALUES 
('Iberia', 'PT', 'MAD', '2024-11-10', '20:30:00', '21:45:00', '01:15:00', 100.50, 250.00, 400.00),
('Vuela Tazo', 'RD', 'PD', '2024-11-10', '22:15:00', '23:30:00', '01:15:00', 113.00, 220.00, 380.00),
('JET Blue', 'RD', 'BCN', '2024-11-10', '01:45:00', '03:00:00', '01:15:00', 65.80, 190.00, 350.00);

