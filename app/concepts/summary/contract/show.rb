module Summary::Contract
  class Show < Dry::Validation::Contract
    params do
      optional(:channel_name).filled(:string)
      optional(:hours).filled(:integer)
    end
  end
end
