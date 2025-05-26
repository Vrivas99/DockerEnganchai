-- seed_data.sql: solo INSERTs ordenados y compatibles con Oracle XE
SET DEFINE OFF;
ALTER SESSION SET CONTAINER = XEPDB1;

-- ------------------------------------------------------------------
-- 1) CONFIGURACIONES (padres)
-- ------------------------------------------------------------------
INSERT INTO CONFIGURACIONES (IDCONFIGURACION, SENSIBILIDAD) VALUES (1, 6);
INSERT INTO CONFIGURACIONES (IDCONFIGURACION, SENSIBILIDAD) VALUES (2, 30);
INSERT INTO CONFIGURACIONES (IDCONFIGURACION, SENSIBILIDAD) VALUES (3, 3);

-- ------------------------------------------------------------------
-- 2) USUARIOS (depende de CONFIGURACIONES)
-- ------------------------------------------------------------------
INSERT INTO USUARIOS (IDUSUARIO, NOMBRE, CORREO, CONTRASENNA, CONFIG_IDCONFIGURACION, AVATAR)
VALUES (1, 'Jordan Urzua', 'jor@profesor.duoc.cl',
        '$2a$12$uTVbRw.lgc7QKUbaYUIwdei9U0Fa/5GPc/N0d9PaXIcivNyUU2PIC',
        1,
        'https://objectstorage.sa-saopaulo-1.oraclecloud.com/.../testUserImage.png');
INSERT INTO USUARIOS (IDUSUARIO, NOMBRE, CORREO, CONTRASENNA, CONFIG_IDCONFIGURACION, AVATAR)
VALUES (2, 'Juan Perez', 'correoPerez@prueba.cl',
        '$2a$12$x0SW8zUQ90i7gWIz39KfaOns3unXkuK5YhzNvBeUVSqA44uEzl3/.',
        2,
        NULL);
INSERT INTO USUARIOS (IDUSUARIO, NOMBRE, CORREO, CONTRASENNA, CONFIG_IDCONFIGURACION, AVATAR)
VALUES (3, 'Vicente', 'vice@profesor.duoc.cl',
        '$2a$12$oyeR63095sEvCZYNfaFbpe8c/0MNno9jG.ZO32povUmIUT9v51UBC',
        3,
        NULL);

-- ------------------------------------------------------------------
-- 3) SALAS (independiente)
-- ------------------------------------------------------------------
INSERT INTO SALAS (IDSALA, NOMBRE, LINK) VALUES (1, 'LC12', 'TestVideos/3.mp4');
INSERT INTO SALAS (IDSALA, NOMBRE, LINK) VALUES (2, 'TP1', 'TestVideos/4.mp4');
INSERT INTO SALAS (IDSALA, NOMBRE, LINK) VALUES (3, 'LC01', '0');

-- ------------------------------------------------------------------
-- 4) SECCIONES (independiente)
-- ------------------------------------------------------------------
INSERT INTO SECCIONES (IDSECCION, NOMBRE)
VALUES (1, 'PROGRAMACIÓN DE ALGORITMOS PGY1121-008D');
INSERT INTO SECCIONES (IDSECCION, NOMBRE)
VALUES (2, 'PROGRAMACIÓN DE ALGORITMOS PGY1121-009D');
INSERT INTO SECCIONES (IDSECCION, NOMBRE)
VALUES (3, 'PROGRAMACIÓN DE ALGORITMOS PGY1121-010D');
INSERT INTO SECCIONES (IDSECCION, NOMBRE)
VALUES (4, 'PROGRAMACIÓN WEB PGY3121-005D');
INSERT INTO SECCIONES (IDSECCION, NOMBRE)
VALUES (5, 'PROGRAMACIÓN WEB PGY3121-004D');

-- ------------------------------------------------------------------
-- 5) SALAS_SECCIONES (depende de SALAS y SECCIONES)
-- ------------------------------------------------------------------
INSERT INTO SALAS_SECCIONES (SECCIONES_IDSECCION, SALAS_IDSALA) VALUES (1, 1);
INSERT INTO SALAS_SECCIONES (SECCIONES_IDSECCION, SALAS_IDSALA) VALUES (1, 2);
INSERT INTO SALAS_SECCIONES (SECCIONES_IDSECCION, SALAS_IDSALA) VALUES (1, 3);

-- ------------------------------------------------------------------
-- 6) ASIGNACIONES (depende de USUARIOS y SALAS_SECCIONES)
-- ------------------------------------------------------------------
INSERT INTO ASIGNACIONES (IDASIGNACION, USUARIOS_IDUSUARIO, SALAS_SECCIONES_SECCIONES_IDSECCION, SALAS_SECCIONES_SALAS_IDSALA)
VALUES (1, 1, 1, 1);
INSERT INTO ASIGNACIONES (IDASIGNACION, USUARIOS_IDUSUARIO, SALAS_SECCIONES_SECCIONES_IDSECCION, SALAS_SECCIONES_SALAS_IDSALA)
VALUES (2, 1, 1, 2);
INSERT INTO ASIGNACIONES (IDASIGNACION, USUARIOS_IDUSUARIO, SALAS_SECCIONES_SECCIONES_IDSECCION, SALAS_SECCIONES_SALAS_IDSALA)
VALUES (3, 3, 1, 1);
INSERT INTO ASIGNACIONES (IDASIGNACION, USUARIOS_IDUSUARIO, SALAS_SECCIONES_SECCIONES_IDSECCION, SALAS_SECCIONES_SALAS_IDSALA)
VALUES (4, 3, 1, 2);
INSERT INTO ASIGNACIONES (IDASIGNACION, USUARIOS_IDUSUARIO, SALAS_SECCIONES_SECCIONES_IDSECCION, SALAS_SECCIONES_SALAS_IDSALA)
VALUES (5, 3, 1, 3);

-- ------------------------------------------------------------------
-- 7) METRICAS (depende de ASIGNACIONES)
--    Solo inserciones válidas: REGISTRO no nulo y ASIGNACIONES_IDASIGNACION existente
-- ------------------------------------------------------------------
INSERT INTO METRICAS (IDMETRICA, ASIGNACIONES_IDASIGNACION, FECHA, REGISTRO, PROMEDIO)
VALUES (2, 1, TO_DATE('22/10/24','DD/MM/RR'), '[]', 0);
-- (Añade aquí más INSERTs, asegurándote de no pasar NULL en REGISTRO y de usar IDs de asignación ya creados)

COMMIT;
