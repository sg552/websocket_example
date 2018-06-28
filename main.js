var ws = new WebSocket("ws://localhost:8080");

ws.onmessage = function(e){
  print(e.data);
};

ws.onopen = function(e){
  log("websocket open");
  console.log(e);
};

ws.onclose = function(e){
  log("websocket close");
  console.log(e);
};

$(function(){
  $('#btn_post').click(post)
  $('#message').keydown(function(e){
    if(e.keyCode == 13) post()
  })
})

var post = function(){
  name = $('#name').val()
  message = $('#message').val()
  ws.send(name + ': ' + message)
  $('input#message').val()
}

log = function(message){
  console.log(message)
  $('#chat').prepend($('<li>').text("[log]" + message))
}

print = function(message){
  $('#chat').prepend($('<li>').text(message))
}
