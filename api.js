var jsonServer = require('json-server')
var server = jsonServer.create()
server.use(jsonServer.defaults())

// db.json に定義したデータを返す
var router = jsonServer.router('db.json')
server.use(router)

// server listen port 4000
console.log('Listening at 4000')
server.listen(4000)
