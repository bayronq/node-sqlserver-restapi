DROP TABLE IF EXISTS ESB_LOGGING;

CREATE TABLE [dbo].[ESB_LOGGING]
(
    [SERVICIO] VARCHAR (50) NOT NULL,
    [OPERACION] VARCHAR (60) NOT NULL,
    [VERSION] VARCHAR (5) NOT NULL,
    [REINTENTO] INT NOT NULL,
    [USUARIO] VARCHAR (20) NULL,
    [CONSUMIDOR] VARCHAR (30) NULL,
    [ID_TRX_SERVICIO] VARCHAR (50) NOT NULL,
    [ID_TRX_CONSUMIDOR] VARCHAR (50) NULL,
    [ID_TRX_PROCESO] VARCHAR (50) NULL,
    [DATOSREQ] XML NULL,
    [DATOSRESP] XML NULL,
    [CODE] VARCHAR (10) NULL,
    [REASON] VARCHAR (1024) NULL,
    [DETAILRETCODE] XML NULL,
    [TIMESTAMPREQ] DATETIME NULL,
    [TIMESTAMPRESP] DATETIME NULL,
    [ESTADO] VARCHAR (5) NULL,
    CONSTRAINT [PK_ESB_LOGGING] PRIMARY KEY CLUSTERED ([REINTENTO] ASC, [ID_TRX_SERVICIO] ASC)
);



INSERT INTO esbdb.dbo.ESB_LOGGING
    (
    SERVICIO, OPERACION, VERSION, REINTENTO, USUARIO, CONSUMIDOR, ID_TRX_SERVICIO, ID_TRX_CONSUMIDOR,
    ID_TRX_PROCESO, DATOSREQ, DATOSRESP, CODE, REASON, DETAILRETCODE, TIMESTAMPREQ, TIMESTAMPRESP, ESTADO
    )
VALUES
    (
        'ACH',
        'ConsultarCtaTerceroExistencia',
        '1.0',
        0,
        NULL,
        'BV',
        '48545450000000000000587374970f430000000000004151',
        '000000000000000',
        18696,
        '<Datos><cuenta>GT23AGRO01020000004016246517</cuenta><moneda>0</moneda><tipo>4</tipo><banco>AGRO</banco></Datos>',
        '<Datos><status>200</status><message>true</message><name>magda abigail reyes ochoa</name></Datos>',
        0,
        NULL,
        NULL,
        '2025-04-26 18:12:59',
        '2025-04-26 18:13:00',
        'C'
);



INSERT INTO esbdb.dbo.ESB_LOGGING
    (
    SERVICIO, OPERACION, VERSION, REINTENTO, USUARIO, CONSUMIDOR, ID_TRX_SERVICIO, ID_TRX_CONSUMIDOR,
    ID_TRX_PROCESO, DATOSREQ, DATOSRESP, CODE, REASON, DETAILRETCODE, TIMESTAMPREQ, TIMESTAMPRESP, ESTADO
    )
VALUES
    (
        'ACH',
        'ConsultarCtaTerceroExistencia',
        '1.0',
        0,
        NULL,
        'BV',
        '48545450000000000000604875a52ace0000000000004353',
        '000000000000000',
        18696,
        '<Datos><cuenta>GT67TRAJ01020000001920059290</cuenta><moneda>0</moneda><tipo>4</tipo><banco>TRAJ</banco></Datos>',
        '<Datos><status>408</status><message>Intente mas tarde</message><name /></Datos>',
        0,
        NULL,
        NULL,
        '2025-04-26 23:08:01',
        '2025-04-26 23:08:06',
        'C'
);



select *
from ESB_LOGGING

select *
FROM esbdb..ESB_LOGGING with (nolock)
WHERE SERVICIO = 'ACH'
    AND OPERACION = 'ConsultarCtaTerceroExistencia'
    --and  DATOSREQ.exist('(/Datos/cuenta[contains(.,"AMCN")])') = 1
    AND DATOSRESP.exist('(/Datos/status[contains(.,"408")])') = 1
    AND TIMESTAMPREQ >= DATEADD(MINUTE, -60, GETDATE())
ORDER BY TIMESTAMPREQ desc

select getdate()
select DATEADD(MINUTE, -60, GETDATE())

select SERVICIO, OPERACION, DATOSREQ, DATOSRESP, TIMESTAMPREQ, TIMESTAMPRESP, ESTADO
from esbdb..ESB_LOGGING with (nolock)
where SERVICIO = 'ACH' and OPERACION = 'ConsultarCtaTerceroExistencia' AND TIMESTAMPREQ>= DATEADD(MINUTE, -20, GETDATE())
order by TIMESTAMPREQ desc

--todo
SELECT TOP 10
    *
FROM esbdb..ESB_LOGGING WITH (NOLOCK)
WHERE SERVICIO = 'ACH' AND OPERACION = 'ConsultarCtaTerceroExistencia'



----VER ERRORES 408 ORDENADO POR BANCO
WITH
    errores_xml
    AS
    (
        SELECT
            CAST(DATOSREQ AS XML).value('(/Datos/banco)[1]', 'VARCHAR(50)') AS banco
        FROM
            esbdb..ESB_LOGGING WITH (NOLOCK)
        WHERE
        CAST(DATOSRESP AS VARCHAR(MAX)) LIKE '%<status>408</status>%'
            AND TIMESTAMPRESP >= DATEADD(MINUTE, -5, GETDATE())
    )
SELECT
    BANCO,
    COUNT(*) AS ERRORES408
FROM
    errores_xml
GROUP BY
    banco
ORDER BY
    banco ASC;



DROP TABLE IF EXISTS ESB_LOGGING;

CREATE TABLE [dbo].[ESB_LOGGING]
(
    [SERVICIO] VARCHAR (50) NOT NULL,
    [OPERACION] VARCHAR (60) NOT NULL,
    [VERSION] VARCHAR (5) NOT NULL,
    [REINTENTO] INT NOT NULL,
    [USUARIO] VARCHAR (20) NULL,
    [CONSUMIDOR] VARCHAR (30) NULL,
    [ID_TRX_SERVICIO] VARCHAR (50) NOT NULL,
    [ID_TRX_CONSUMIDOR] VARCHAR (50) NULL,
    [ID_TRX_PROCESO] VARCHAR (50) NULL,
    [DATOSREQ] XML NULL,
    [DATOSRESP] XML NULL,
    [CODE] VARCHAR (10) NULL,
    [REASON] VARCHAR (1024) NULL,
    [DETAILRETCODE] XML NULL,
    [TIMESTAMPREQ] DATETIME NULL,
    [TIMESTAMPRESP] DATETIME NULL,
    [ESTADO] VARCHAR (5) NULL,
    CONSTRAINT [PK_ESB_LOGGING] PRIMARY KEY CLUSTERED ([REINTENTO] ASC, [ID_TRX_SERVICIO] ASC)
);








select *
from users;
