require 'telegram_service'
require 'httparty'

module Summary::Operation
  class Generate < Trailblazer::Operation
    step Model(Summary, :find_by)
    step :get_messages
    step :generate_summary

    def get_messages(ctx, model:, **)
      service = TelegramService.new
      channel_name = model.channel_name
      hours = model.delay
      response = service.get_messages(channel_name: channel_name, hours: hours)
      if response&.parsed_response.blank?
        Rails.logger.error("Failed to fetch messages: #{response.body}") and return false
      end

      messages = response.parsed_response
      ctx[:summary_raw_data] = { settings: model, messages: messages }
    end

    def sanitize_string(str)
      str.chars.select do |char|
        ord = char.ord
        (10..126).include?(ord) || (697..702).include?(ord) || (1028..1112).include?(ord)
      end.join
    end

    def generate_summary(ctx, model:, **)
      exceptions = model.exception_dictionary.split(' ')
      min_post_length = model.min_post_length
      raw_news_texts = ctx[:summary_raw_data][:messages].map { |a| a['text'] }.uniq
      news_texts = raw_news_texts.keep_if do |post|
        exceptions.none? do |exc|
          post.include?(exc)
        end && (post.size > min_post_length)
      end.join("\n\n")

      Rails.logger.info(sanitize_string(news_texts))
      ctx[:result] = sanitize_string(news_texts)
      # https://platform.openai.com/docs/api-reference/chat/create
      # response = HTTParty.post('https://api.openai.com/v1/engines/gpt-3.5-turbo/completions',
      #                          body: {
      #                            prompt: "Please summarize the following news articles:\n#{news_texts}",
      #                            max_tokens: 150
      #                          }.to_json,
      #                          headers: {
      #                            'Content-Type' => 'application/json',
      #                            'Authorization' => "Bearer #{ENV['OPENAI_API_KEY']}"
      #                          })
      #
      # if response.success?
      #   ctx[:result] = response.parsed_response['choices'].first['text'].strip
      # else
      #   Rails.logger.error("Error: #{response.body}")
      # end
    end
  end
end
