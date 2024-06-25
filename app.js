// работа с базой данных (через модуль для синхр. работы с MySQL, который может быть усталовлен командой: npm install sync-mysql)
const Mysql = require('sync-mysql'); // npm install sync-mysql
const connection = new Mysql({
    host: 'localhost',
    user: 'root',
    password: 'password',
    database: 'planets'
});

// обработка параметров из формы.
var qs = require('querystring');
function reqPost(request, response) {
    if (request.method == 'POST') {
        var body = '';

        request.on('data', function (data) {
            body += data;
        });

        request.on('end', function () {
			var post = qs.parse(body);
			var sInsert = "INSERT INTO Sector (id, coords, intensity, outsiders, count, undefined, specified, notation) VALUES (\""+post['col1']+"\",\""+post['col2']+"\",\""+post['col3']+"\",\""+post['col4']+"\",\""+post['col5']+"\",\""+post['col6']+"\",\""+post['col7']+"\",\""+post['col8']+"\")";
			var results = connection.query(sInsert);
            console.log('Done. Hint: ' + sInsert);
        });
    }
}

// выгрузка массива данных.
function ViewSelect(res) {
    const query = 'SELECT id, coords, intensity, outsiders, count, undefined, specified, notation FROM Sector';
    const results = connection.query(query);

    res.write('<tr>');
    for (let key in results[0]) {
        res.write('<td>' + key + '</td>');
    }
    res.write('</tr>');

    for (let row of results) {
        res.write('<tr>');
        for (let key in row) {
            res.write('<td>' + row[key] + '</td>');
        }
        res.write('</tr>');
    }
}


// создание ответа в браузер, на случай подключения.
const http = require('http');
const server = http.createServer((req, res) => {
	reqPost(req, res);
	console.log('Loading...');

	res.statusCode = 200;

	// чтение шаблона в каталоге со скриптом.
	var fs = require('fs');
	var array = fs.readFileSync(__dirname+'/select.html').toString().split("\n");
	console.log(__dirname+'/select.html');
	for(i in array) {
		// подстановка.
		if ((array[i].trim() != '@tr')) res.write(array[i]);
		if (array[i].trim() == '@tr') ViewSelect(res);
	}
	res.end();
	console.log('1 User Done.');
});

// запуск сервера, ожидание подключений из браузера.
const hostname = '127.0.0.1';
const port = 3000;
server.listen(port, hostname, () => {
	console.log(`Server running at http://${hostname}:${port}/`);
});
