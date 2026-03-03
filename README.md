🏢 Sistema de Gestión Inmobiliaria – MySQL II
📌 Descripción del Proyecto

Este proyecto consiste en el diseño e implementación de una base de datos relacional en MySQL para la gestión integral de una inmobiliaria.

El sistema permite administrar:

Portafolio de propiedades (casas, apartamentos y locales comerciales)

Clientes interesados en compra o arriendo

Agentes inmobiliarios

Contratos de venta y arriendo

Historial de pagos

Auditoría de cambios de estado

Reportes automáticos de deudas pendientes

El objetivo es construir una base de datos robusta, segura y optimizada que funcione como prototipo real para un sistema inmobiliario.

🎯 Objetivos del Proyecto

Diseñar un modelo Entidad–Relación normalizado hasta 3FN.

Implementar integridad referencial con claves primarias y foráneas.

Crear funciones personalizadas (UDFs).

Implementar triggers de auditoría automática.

Configurar roles y privilegios por tipo de usuario.

Optimizar consultas mediante índices.

Programar eventos automáticos mensuales.

🧱 Modelo de Base de Datos
📌 Entidades Principales
Entidad	Descripción
Tipo_Propiedad	Clasificación del inmueble
Propiedad	Información general del inmueble
Cliente	Personas que compran o arriendan
Agente	Empleados encargados de gestionar contratos
Contrato	Documento legal de venta o arriendo
Pago	Registro de pagos realizados en arriendos
Auditoria_Estado_Propiedad	Historial de cambios de estado
Reporte_Mensual_Pendientes	Registro automático de deudas
🧠 Normalización (Hasta 3FN)

La base de datos cumple con las tres primeras formas normales:

✅ Primera Forma Normal (1FN)

No existen atributos multivaluados.

Todos los campos contienen valores atómicos.

✅ Segunda Forma Normal (2FN)

Todas las tablas tienen clave primaria simple.

No existen dependencias parciales.

✅ Tercera Forma Normal (3FN)

No existen dependencias transitivas.

El tipo de propiedad está separado en su propia tabla.

No se almacenan valores calculados como deuda o comisión (se calculan con funciones).

⚙️ Instalación
1️⃣ Crear la Base de Datos

Ejecutar el script principal en MySQL Workbench:

SOURCE inmobiliaria_db.sql;

O ejecutar manualmente cada bloque DDL del proyecto.

2️⃣ Activar el Event Scheduler
SET GLOBAL event_scheduler = ON;

Verificar estado:

SHOW VARIABLES LIKE 'event_scheduler';
3️⃣ Crear Roles y Usuarios

El sistema incluye tres roles:

administrador

agente_role

contador

Ejemplo de creación de usuario:

CREATE USER 'agente1'@'localhost' IDENTIFIED BY '1234';
GRANT agente_role TO 'agente1'@'localhost';
🔐 Seguridad y Roles
Rol	Permisos
Administrador	Acceso total a la base de datos
Agente	Insertar y actualizar propiedades y contratos
Contador	Solo lectura y acceso a pagos

Esto garantiza separación de responsabilidades y protección de la información.

🔎 Funciones Implementadas (UDFs)
1️⃣ Calcular Comisión por Venta

Calcula automáticamente la comisión del agente según su porcentaje asignado.

SELECT calcular_comision(1);
2️⃣ Calcular Deuda Pendiente

Determina cuánto dinero falta por pagar en un contrato de arriendo.

SELECT calcular_deuda(2);
3️⃣ Total de Propiedades Disponibles por Tipo

Devuelve el número de propiedades disponibles según tipo.

SELECT total_disponibles(1);
🔄 Triggers Implementados
📌 Trigger: Cambio de Estado de Propiedad

Cada vez que una propiedad cambia de estado (por ejemplo, de disponible a arrendada o vendida), se registra automáticamente en la tabla de auditoría.

Beneficio:

Permite trazabilidad histórica.

Mantiene control administrativo.

📌 Trigger: Registro de Nuevo Contrato

Cuando se inserta un nuevo contrato:

Si es venta → la propiedad pasa a estado "vendida".

Si es arriendo → la propiedad pasa a estado "arrendada".

Evita errores manuales y automatiza el flujo del sistema.

📊 Evento Programado Mensual

Se creó un evento automático que:

Se ejecuta cada mes.

Inserta en la tabla reporte_mensual_pendientes los contratos de arriendo con deuda activa.

Esto permite generar reportes financieros sin intervención manual.

🚀 Optimización Implementada

✔ Índices en:

estado de propiedad

id_contrato en pagos

✔ Claves foráneas correctamente indexadas
✔ Consultas optimizadas con JOIN

Esto mejora el rendimiento en consultas frecuentes como:

Búsqueda de propiedades disponibles

Cálculo de deuda

Reportes administrativos

📌 Ejemplos de Consultas Útiles
Ver propiedades disponibles
SELECT * FROM propiedad
WHERE estado = 'disponible';
Ver historial de cambios
SELECT * FROM auditoria_estado_propiedad
ORDER BY fecha_cambio DESC;
Ver contratos con deuda
SELECT id_contrato, calcular_deuda(id_contrato) AS deuda
FROM contrato
WHERE tipo_contrato = 'arriendo';
🏆 Conclusión Técnica

Este proyecto demuestra:

Diseño relacional correctamente estructurado.

Aplicación de normalización hasta 3FN.

Uso avanzado de funciones personalizadas.

Automatización mediante triggers.

Implementación de seguridad con roles.

Programación de eventos automáticos.

Optimización de consultas mediante índices.

Se desarrolló como prototipo funcional y escalable para un sistema real de gestión inmobiliaria.

enlace para el diagrama UML:
https://lucid.app/lucidchart/0bd7a752-4b89-4a41-b49e-c06a4b4dc260/edit?viewport_loc=-252%2C147%2C2339%2C1108%2CfwQcDkAJnwES&invitationId=inv_2256ebde-38b6-45c2-8e48-7822de77ac7f

👨‍💻 Autor- Sergio Abril

Proyecto desarrollado como trabajo académico para el skill MySQL II.