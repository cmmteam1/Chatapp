module MessagesHelper
    def set_message(message)
        session[:curr_message_id]=message.id
    end
end
