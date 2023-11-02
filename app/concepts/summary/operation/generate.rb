require 'telegram_service'
module Summary::Operation
  class Generate < Trailblazer::Operation
    step Model(Summary, :find_by)
    step :validate_params!
    step :generate_json

    def validate_params!(opts, params:, **)
      opts[:schema] = Summary::Contract::Show.new.call(params)
      opts[:schema].success?
    end

    def generate_json(ctx, model:, **)
      service = TelegramService.new
      channel_name = ctx[:params][:channel_name] || 'huyovy_kharkiv'
      hours = ctx[:params][:hours] || 24
      response = service.get_messages(channel_name: channel_name, hours: hours)
      if response.success?
        messages = response.parsed_response
      else
        Rails.logger.error("Failed to fetch messages: #{response.body}")
      end

      ctx[:json] = { id: model.id, messages: messages }
    end
  end
end
