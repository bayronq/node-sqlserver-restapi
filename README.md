# Node & MSSQL Server API

nodejs and Microsoft SQL Server Datbase REST API

## environment variables

```
DB_USER = youruser
DB_PASSWORD = yourpassword
DB_SERVER = localhost
DB_DATABASE = yourdatabase
```

## Crear imagen docker

`docker build -t docker-nodejs . `

## Ejecuta imagen en el puerto 3001

`docker run --name nodejs -d -p 3001:3000 docker-nodejs`

## Probar app

`curl localhost:3000/api/errors`
