require 'yaml'
module Convore
	class Client
		attr_accessor :thread, :stream, :cursor, :username, :password

		def initialize
			@stream ||= []
			@ts ||= Time.now.to_f
		end
		
		def listen
			raise Exception.new("username and password need to be set to listen to /live") if !username || !password

      http = EM::HttpRequest.new("https://convore.com/api/live.json?cursor=#{@cursor if @cursor}").get :head => {'authorization' => ["#{@username}", "#{@password}"]}

      http.callback {
        process_response(http.response)
      }

      http.errback  {
      }

		end

		def process_response(response)
			json = JSON.parse(response)

			if json['messages']
				json['messages'].each {|msg|
					if msg['_ts'] && @ts < msg['_ts']
						case msg['kind']
						when 'message' then
							stream.unshift(Message.from_json(msg))
						when 'topic' then
							stream.unshift(Topic.from_json(msg))
						when 'star', 'unstar' then
							stream.unshift(Star.from_json(msg))
						end
						@ts = msg['_ts'] if msg['_ts']
						@cursor = msg['_id'] if msg['_id']
					end
				}
			end
		end
		
	end
end
