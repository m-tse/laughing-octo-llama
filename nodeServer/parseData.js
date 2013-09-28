var Firebase = require('firebase');
var database = new Firebase('https://itunesgalaxy.firebaseio.com/');
database.set('hello world');
