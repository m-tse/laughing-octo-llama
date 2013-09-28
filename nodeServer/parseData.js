var http = require('http');
var querystring = require('querystring');
var fs = require('fs');
var Firebase = require('firebase');
var itunes = require('searchitunes');

var appleLookupApi = {
  host: 'itunes.apple.com',
  port: 80,
  path: '/lookup?'
}
var database = new Firebase('https://itunesgalaxy.firebaseio.com/');
var songs = database.child('songs');

function appleLookup(params, callback) {

  var req = http.request({
    host: appleLookupApi.host,
    post: appleLookupApi.port,
    path: appleLookupApi.path + querystring.stringify(params),
    method: 'GET',
    headers: {
      'Accept': 'application/json',
    }
  }, function(response) {
    var data = '';
    response.on('data', function(chunk) {data += chunk});
    response.on('end', function() {
      data = data.toString().trim()  
      if(data.length >= 2 && data.substr(0,1) == '{' && data.substr( data.length -1, 1 ) == '}') {
        data = JSON.parse(data);
        if( data.resultCount !== undefined ) {
          callback(data['results']);
        } else {
          callback(false, {reason: 'incomplete json', headers: response.headers, data: data});
        }
      } else {
        callback(false, {reason: 'not json', headers: response.headers, data: data});
      }
    })
  }).end();
}

if (true) {
  fs.readFile('./appleData/song_popularity_per_genre', 'utf8', function (err, data) {
    if (err) {
      return console.log(err);
    } 
    var count = 0;
    data.toString().split('\n').forEach(function(line) {
      count += 1;
      if (count > 10) {
        return;
      }
      attributes = line.toString().split(/\s+/)
      appleLookup({
        id: attributes[3] 
      }, function(data) {
        if (data.length > 0) {
          data = data[0];
          data.id = attributes[3];
          data.genre = attributes[2];
          data.rank = attributes[4];
          songs.push(data)
        }
      });
    })
  });
}

return;
