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
      ctx[:json] = { id: model.id, user_uid: model.name }
    end
  end
end
