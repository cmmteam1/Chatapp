module ChannelsHelper
    def set_channel(channel)
        session[:curr_channel_id]=channel.id
    end
end
