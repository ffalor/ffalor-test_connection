#!/opt/puppetlabs/puppet/bin/ruby
# frozen_string_literal: true

require 'json'
require 'socket'

result = {}

def test_connection(host, port)
    s = TCPSocket.new(host, port)
    s.close
    return true
end


begin
    params = JSON.load(STDIN.read)

    server = params['server']
    port = params['port']

    server_test = test_connection(server, port)

    result['result'] = {
        "connected": server_test,
        "details": {
            "server": server,
            "port": port
        }
    }
rescue Errno::EADDRNOTAVAIL => e
    result[:_error] = { msg: "Unable to reach #{server} over port #{port}",
        kind: "Uncaught",
        details: { 
            class: e.class.to_s,
            msg: e.message
        }
    }
rescue => e
    puts e.inspect
    result[:_error] = { msg: e.message,
        kind: "Uncaught",
        details: { 
            class: e.class.to_s,
        }
    }
end

puts result.to_json
