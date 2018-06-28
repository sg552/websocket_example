#!/usr/bin/env ruby
require 'eventmachine'
require 'websocket-eventmachine-server'

PORT = 8080

EM::run do
  @channel = EM::Channel.new

  puts "start websocket server, port: #{PORT}"

  WebSocket::EventMachine::Server.start(host: '0.0.0.0', port: PORT) do |ws|
    ws.onopen do
      sid = @channel.subscribe do |message|
        ws.send "from server: #{message}"
      end
      puts "== <#{sid}> connect"
      @channel.push "hello , new client <#{sid}>"

      ws.onmessage do |message|
        puts "<#{sid}> #{message}"
        @channel.push "<#{sid}> #{message}"
      end

      ws.onclose do
        puts "<#{sid}> disconnected"
        @channel.unsubscribe sid
        @channel.push "<#{sid}> disconnected"
      end
    end
  end
end
