module Summary::Contract
  class Show < Dry::Validation::Contract
    params do
      optional(:user_id).filled(:string)
    end
  end
end
