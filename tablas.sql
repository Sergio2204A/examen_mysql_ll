-- Primero creamos la base de datos --
CREATE DATABASE inmobiliaria;
USE inmobiliaria;

🔹 Tabla Tipo_Propiedad
CREATE TABLE tipo_propiedad (
    id_tipo INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE
);

🔹 Tabla Propiedad
CREATE TABLE propiedad (
    id_propiedad INT AUTO_INCREMENT PRIMARY KEY,
    direccion VARCHAR(200) NOT NULL,
    ciudad VARCHAR(100) NOT NULL,
    valor DECIMAL(12,2) NOT NULL,
    estado ENUM('disponible','arrendada','vendida') DEFAULT 'disponible',
    id_tipo INT NOT NULL,
    INDEX idx_estado (estado),
    FOREIGN KEY (id_tipo) REFERENCES tipo_propiedad(id_tipo)
);

🔹 Tabla Cliente
CREATE TABLE cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    telefono VARCHAR(20)
);

🔹 Tabla Agente
CREATE TABLE agente (
    id_agente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    porcentaje_comision DECIMAL(5,2) NOT NULL DEFAULT 3.00
);

🔹 Tabla Contrato
CREATE TABLE contrato (
    id_contrato INT AUTO_INCREMENT PRIMARY KEY,
    id_propiedad INT NOT NULL,
    id_cliente INT NOT NULL,
    id_agente INT NOT NULL,
    tipo_contrato ENUM('venta','arriendo') NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NULL,
    valor_total DECIMAL(12,2) NOT NULL,
    estado ENUM('activo','finalizado') DEFAULT 'activo',
    FOREIGN KEY (id_propiedad) REFERENCES propiedad(id_propiedad),
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    FOREIGN KEY (id_agente) REFERENCES agente(id_agente)
);

🔹 Tabla Pago
CREATE TABLE pago (
    id_pago INT AUTO_INCREMENT PRIMARY KEY,
    id_contrato INT NOT NULL,
    fecha_pago DATE NOT NULL,
    monto DECIMAL(12,2) NOT NULL,
    FOREIGN KEY (id_contrato) REFERENCES contrato(id_contrato)
);

🔹 Tablas de Auditoría

CREATE TABLE auditoria_estado_propiedad (
    id_auditoria INT AUTO_INCREMENT PRIMARY KEY,
    id_propiedad INT,
    estado_anterior VARCHAR(20),
    estado_nuevo VARCHAR(20),
    fecha_cambio TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE auditoria_contrato (
    id_auditoria INT AUTO_INCREMENT PRIMARY KEY,
    id_contrato INT,
    accion VARCHAR(50),
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE reporte_pagos_mensual (
    id_reporte INT AUTO_INCREMENT PRIMARY KEY,
    mes YEAR(4),
    total_pendiente DECIMAL(14,2),
    fecha_generado TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);