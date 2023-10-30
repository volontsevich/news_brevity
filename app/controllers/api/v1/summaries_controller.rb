# frozen_string_literal: true

module Api
  module V1
    class SummariesController < ApplicationController
      def show
        result = Summary::Operation::Generate.call(params: params)

        if result.success?
          render json: result[:json]
        else
          render json: { error: 'Invalid input' }, status: :unprocessable_entity
        end
      end
    end
  end
end
