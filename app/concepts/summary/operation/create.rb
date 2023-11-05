module Summary::Operation
  class Create < Trailblazer::Operation
    step Model(Summary, :new)
    step :validate_params!
    step :persists

    def validate_params!(opts, params:, **)
      opts[:schema] = Summary::Contract::Create.new.call(params)
      opts[:schema].success?
    end

    def persists(opts, model:, **)
      model.assign_attributes(opts[:schema].to_h)
      model.save
    end
  end
end
