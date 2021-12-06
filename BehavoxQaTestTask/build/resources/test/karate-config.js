function fn() {
  var config = { // base config JSON
    hostUrl : 'http://localhost:8080/',
    postUrl : 'groovy/submit',
    getUrl : 'groovy/status',
    username : 'user_1',
    password : 'pass_1'
  };
  karate.configure('connectTimeout', 10000);
  karate.configure('readTimeout', 10000);
  return config;
}