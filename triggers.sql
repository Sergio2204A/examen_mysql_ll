🔹 Cambio de Estado
DELIMITER //

CREATE TRIGGER trg_cambio_estado
AFTER UPDATE ON propiedad
FOR EACH ROW
BEGIN
    IF OLD.estado <> NEW.estado THEN
        INSERT INTO auditoria_estado_propiedad
        (id_propiedad, estado_anterior, estado_nuevo)
        VALUES (OLD.id_propiedad, OLD.estado, NEW.estado);
    END IF;
END //

DELIMITER ;


🔹 Registro Nuevo Contrato
DELIMITER //

CREATE TRIGGER trg_nuevo_contrato
AFTER INSERT ON contrato
FOR EACH ROW
BEGIN
    UPDATE propiedad
    SET estado = 
        CASE 
            WHEN NEW.tipo_contrato = 'venta' THEN 'vendida'
            WHEN NEW.tipo_contrato = 'arriendo' THEN 'arrendada'
        END
    WHERE id_propiedad = NEW.id_propiedad;
END //

DELIMITER ;