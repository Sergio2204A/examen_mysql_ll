🔹 1. Calcular Comisión de Venta
DELIMITER //

CREATE FUNCTION calcular_comision(p_id_contrato INT)
RETURNS DECIMAL(12,2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(12,2);
    DECLARE porcentaje DECIMAL(5,2);

    SELECT c.valor, a.porcentaje_comision
    INTO total, porcentaje
    FROM contrato c
    JOIN agente a ON c.id_agente = a.id_agente
    WHERE c.id_contrato = p_id_contrato
    AND c.tipo_contrato = 'venta';

    RETURN total * (porcentaje / 100);
END //

DELIMITER ;
🔹 2. Calcular Deuda Pendiente (Arriendo)
DELIMITER //

CREATE FUNCTION calcular_deuda(p_id_contrato INT)
RETURNS DECIMAL(12,2)
DETERMINISTIC
BEGIN
    DECLARE total_pagado DECIMAL(12,2);
    DECLARE valor_contrato DECIMAL(12,2);

    SELECT IFNULL(SUM(monto),0)
    INTO total_pagado
    FROM pago
    WHERE id_contrato = p_id_contrato;

    SELECT valor
    INTO valor_contrato
    FROM contrato
    WHERE id_contrato = p_id_contrato;

    RETURN valor_contrato - total_pagado;
END //

DELIMITER ;
🔹 3. Total Propiedades Disponibles por Tipo
DELIMITER //

CREATE FUNCTION total_disponibles(p_id_tipo INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;

    SELECT COUNT(*)
    INTO total
    FROM propiedad
    WHERE id_tipo = p_id_tipo
    AND estado = 'disponible';

    RETURN total;
END //

DELIMITER ;