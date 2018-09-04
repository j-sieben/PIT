'use strict';

process.title = 'database-notification';

var webSocketServer = require('websocket').server;
var http = require('http');

var options = {
  'port':8880,
  'encoding':'utf8',
  'contentType':{'Content-Type':'application/json'},
  'messages':{
    'connect':'#DATE#: Connection accepted.',
    'disconnect':'#DATE#: Peer #1# disconnected.',
    'request':'#DATE#: Websocketconnection from origin #1#.',
    'sent':'#DATE#: Send to #1# clients',
    'listen':'#DATE#: Server is listening on port #1#'
  }
};

var clients = [ ];

/* HTTP server */
var server = http.createServer(function(request, response){
  var body = '';
  var json;
  request.setEncoding(options.encoding);
  response.writeHead(200, options.contentType);

  request.on('data', function(data) {
    body += data.toString();
    /* Try ot parse message as JSON. If that fails, put it into a message object */
    try {
      json = body;
      var test = JSON.parse(json);
    }
    catch (e) {
      json = JSON.stringify({'message':body});
    }  
    /* Push message to all the connected clients */
    for (var i=0; i < clients.length; i++) {
      clients[i].sendUTF(json);
    };
    response.end(JSON.stringify({ message: 'Send to '+ clients.length + ' clients' }));
  });
});

/* Start listening on the configured port an write to standard output*/
server.listen(options.port, function() {
  log(options.messaegs.listen, [options.port]);
});

/*
   WebSocket server
 */
var wsServer = new webSocketServer({
  // De WebSocket server is tied to a HTTP server.
  httpServer: server
});

/* If a client connects to the websocketserver,
   this callback accepts the request and adds it to the list
*/
wsServer.on('request', function(request) {
  log(options.messaegs.request, [request.origin]);
  var connection = request.accept(null, request.origin); 
  
  // we need to know client index to remove them on 'close' event
  var index = clients.push(connection) - 1;
  log((options.messages.connect);

  connection.on('close', function(connection) {
    log(options.messages.disconnect, [connection.remoteAddress]);
    clients.splice(index, 1);
  });
});

function log(message, params){
  var msg = message;
  msg.replace('#DATE#', new Date());
  
  for (var i=0; i < params.length; i++) {
    msg.replace('#' + i + '#', params[i]);
  };
  console.log(msg);
}