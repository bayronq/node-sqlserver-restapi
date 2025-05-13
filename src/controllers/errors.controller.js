import { getConnection, sql } from "../database/connection.js";


export const getData = async (req, res) => {
  try {
    const pool = await getConnection();
    const result = await pool.request().query("select SERVICIO, OPERACION, DATOSREQ, DATOSRESP, TIMESTAMPREQ, TIMESTAMPRESP, ESTADO from esbdb..ESB_LOGGING with (nolock) where SERVICIO = 'ACH' and OPERACION = 'ConsultarCtaTerceroExistencia' AND TIMESTAMPREQ >= DATEADD(MINUTE, -10, GETDATE()) order by TIMESTAMPREQ desc");

    res.json(result.recordset);
  } catch (error) {
    res.status(500);
    res.send(error.message);
  }
};

export const getErrors = async (req, res) => {
  try {
    const pool = await getConnection();
    //const result = await pool.request().query("SELECT TOP 10 * FROM esbdb..ESB_LOGGING WITH (NOLOCK) WHERE SERVICIO = 'ACH' AND OPERACION = 'ConsultarCtaTerceroExistencia'")
    const result = await pool.request().query("WITH errores_xml AS (SELECT CAST(DATOSREQ AS XML).value('(/Datos/banco)[1]', 'VARCHAR(50)') AS banco FROM esbdb..ESB_LOGGING WITH (NOLOCK) WHERE CAST(DATOSRESP AS VARCHAR(MAX)) LIKE '%<status>408</status>%' AND TIMESTAMPRESP >= DATEADD(MINUTE, -10, GETDATE())) SELECT BANCO, COUNT(*) AS ERRORES408 FROM errores_xml GROUP BY banco ORDER BY banco ASC");

    res.json(result.recordset);
  } catch (error) {
    res.status(500);
    res.send(error.message);
  }
};


export const getErrorById = async (req, res) => {
  try {
    const pool = await getConnection();

    const result = await pool
      .request()
      .input("minutos", sql.Int, parseInt(req.params.id)) 
      .query("WITH errores_xml AS (SELECT CAST(DATOSREQ AS XML).value('(/Datos/banco)[1]', 'VARCHAR(50)') AS banco FROM esbdb..ESB_LOGGING WITH (NOLOCK) WHERE CAST(DATOSRESP AS VARCHAR(MAX)) LIKE '%<status>408</status>%' AND TIMESTAMPRESP >= DATEADD(MINUTE, -@minutos, GETDATE())) SELECT BANCO, COUNT(*) AS ERRORES408 FROM errores_xml GROUP BY banco ORDER BY banco ASC;");

    return res.json(result.recordset);
  } catch (error) {
    res.status(500);
    res.send(error.message);
  }
};
