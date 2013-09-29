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
var database = new Firebase('https://igalaxy.firebaseio.com/');
var songs = database.child('songs');
var apps = database.child('apps');
var genres = database.child('genres');
var songGenres = genres.child('songs');

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

function readSongs() {
  var genreArray = [];
  var popularList = [
    "Classical",
    "Electronic",
    "House",
    "Rock",
    "Alternative",
    "Hip Hop",
    "Pop"
  ];
  fs.readFile('./appleData/song_popularity_per_genre', 'utf8', function (err, data) {
    if (err) {
      return console.log(err);
    } 
    var count = 0;
    data.toString().split('\n').forEach(function(line) {
      if (count > 300) {
        return;
      }
      attributes = line.toString().split(/\s+/)

      count += 1;
      appleLookup({
        id: attributes[3]
      }, attributes, count, function(data, params, count) {
        if (data.length > 0 && params.length > 1) {// && _.contains(popularList, data.primaryGenre)) {
          data = data[0];
          data["id"] = params[3];
          data["genre"] = params[2];
          data["rank"] = params[4];
          if (!_.contains(genreArray, data.primaryGenreName) && data.genre) {
            var newGenre = {};
            songGenres.push({name: data.primaryGenreName, id: data["genre"]});
            genreArray.push(data.primaryGenreName);
            console.log(genreArray.length);
          }
          var songByGenre = songs.child(data.primaryGenreName);
          songByGenre.push(data.trackName: data);
        }
      });
    })
  });
}

if (true) {
  readSongs();
}

return;
