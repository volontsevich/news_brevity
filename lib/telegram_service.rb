class TelegramService
  include HTTParty
  base_uri 'http://telegram_bot:5000'

  def get_messages(channel_name:, hours:)
    self.class.get('/get_messages', query: { channel_name: channel_name, hours: hours })
  end
end
