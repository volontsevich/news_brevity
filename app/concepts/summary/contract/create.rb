module Summary::Contract
  class Create < Dry::Validation::Contract
    params do
      required(:name).filled(:string)
      required(:channel_name).filled(:string)
      required(:min_post_length).filled(:integer)
      required(:start_utc_time).filled(:date_time)
      optional(:next_utc_time).filled(:date_time)
      required(:delay).filled(:integer)
      optional(:exception_dictionary).filled(:string)
      required(:length).filled(:integer)
      optional(:topics_to_exclude).filled(:string)
    end
  end
end
