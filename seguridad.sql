CREATE ROLE administrador;
CREATE ROLE agente_role;
CREATE ROLE contador;

GRANT ALL PRIVILEGES ON inmobiliaria_db.* TO administrador;

GRANT SELECT, INSERT, UPDATE ON inmobiliaria_db.propiedad TO agente_role;
GRANT SELECT, INSERT ON inmobiliaria_db.contrato TO agente_role;

GRANT SELECT ON inmobiliaria_db.* TO contador;
GRANT SELECT ON inmobiliaria_db.pago TO contador;

Asignar usuario:

CREATE USER 'agente1'@'localhost' IDENTIFIED BY '1234';
GRANT agente_role TO 'agente1'@'localhost';



Primero activar scheduler:

SET GLOBAL event_scheduler = ON;

Evento:

DELIMITER //

CREATE EVENT reporte_mensual
ON SCHEDULE EVERY 1 MONTH
DO
BEGIN
    INSERT INTO reporte_mensual_pendientes (fecha_reporte, id_contrato, deuda)
    SELECT CURDATE(), id_contrato, calcular_deuda(id_contrato)
    FROM contrato
    WHERE tipo_contrato = 'arriendo'
    AND calcular_deuda(id_contrato) > 0;
END //

DELIMITER ;