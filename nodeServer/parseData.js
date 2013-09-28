var http = require('http');
var querystring = require('querystring');
var fs = require('fs');
var Firebase = require('firebase');
var itunes = require('searchitunes');
var _ = require('underscore');

var appleLookupApi = {
  host: 'itunes.apple.com',
  port: 80,
  path: '/lookup?'
}
var database = new Firebase('https://itunesgalaxy.firebaseio.com/');
var songs = database.child('songs');
var genres = database.child('genres');

function appleLookup(params, attributes, count, callback) {

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
          callback(data['results'], attributes, count);
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
  var genreArray = []
  fs.readFile('./appleData/song_popularity_per_genre', 'utf8', function (err, data) {
    if (err) {
      return console.log(err);
    } 
    var count = 0;
    data.toString().split('\n').forEach(function(line) {
/*      if (count > 10) {*/
        //return;
/*      }*/
      attributes = line.toString().split(/\s+/)
      count += 1;

      appleLookup({
        id: attributes[3]
      }, attributes, count, function(data, params, count) {
        if (data.length > 0 && params.length > 1) {
          data = data[0];
          data["id"] = params[3];
          data["genre"] = params[2];
          data["rank"] = params[4];
          if (!_.contains(genreArray, data.primaryGenreName) && data.genre) {
            var newGenre = {};
            genres.push({name: data.primaryGenreName});
            genreArray.push(data.primaryGenreName);
            console.log(genreArray);
          }
          if (count > 100) {
            return;
          }
          console.log(params)
          console.log(data)
          songs.push(data)
        }
      });
    })
  });
}

return;
