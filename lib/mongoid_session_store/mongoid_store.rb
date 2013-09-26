module ActionDispatch
  module Session
    class MongoidStore < AbstractStore

      class Session
        include Mongoid::Document
        
        store_in collection: 'sessions'

        #identity :type => String
        field :id, type: String
        attr_accessible :id
        field :data, :type => String, :default => [Marshal.dump({})].pack("m*")
        field :last_active_time, type: Time, default: Time.now
      end

      # The class used for session storage.
      cattr_accessor :session_class
      self.session_class = Session
      
      SESSION_RECORD_KEY = 'rack.session.record'
      ENV_SESSION_OPTIONS_KEY = Rack::Session::Abstract::ENV_SESSION_OPTIONS_KEY if ::Rails.version >= "3.1"

      private

        def get_session(env, sid)
          expire_after = env[ENV_SESSION_OPTIONS_KEY][:expire_after]
          sid ||= generate_sid
          session = find_session(sid)
          seconds_since_last_access = Time.now - session.last_active_time.to_time
          if expire_after and seconds_since_last_access > expire_after
            # clear all the existing data
            session.data = [Marshal.dump({})].pack("m*")
            session.save
          end
          
          env[SESSION_RECORD_KEY] = session
          [sid, unpack(session.data)]
        end

        def set_session(env, sid, session_data, options = nil)
          record = get_session_model(env, sid)
          record.last_active_time = Time.now
          record.data = pack(session_data)

          # Rack spec dictates that set_session should return true or false
          # depending on whether or not the session was saved or not.
          # However, ActionPack seems to want a session id instead.
          record.save ? sid : false
        end

        def find_session(id)
          @@session_class.find_or_create_by(:id => id)
        end

        # def destroy(env)
        #   if sid = current_session_id(env)
        #     find_session(sid).destroy
        #   end
        # end
        
        def destroy(env)
          destroy_session(env, current_session_id(env), {})
        end
        
        def destroy_session(env, session_id, options)
          if sid = current_session_id(env)
            get_session_model(env, sid).destroy
            env[SESSION_RECORD_KEY] = nil
          end

          generate_sid unless options[:drop]
        end

        def get_session_model(env, sid)
          if env[ENV_SESSION_OPTIONS_KEY][:id].nil?
            env[SESSION_RECORD_KEY] = find_session(sid)
          else
            env[SESSION_RECORD_KEY] ||= find_session(sid)
          end
        end

        def pack(data)
          [Marshal.dump(data)].pack("m*")
        end

        def unpack(packed)
          return nil unless packed
          Marshal.load(packed.unpack("m*").first)
        end

    end
  end
end
