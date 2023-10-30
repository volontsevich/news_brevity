# frozen_string_literal: true

module Api
  module V1
    class SummariesController < ApplicationController
      def show
        allowed_params = params.permit(:id, :user_uid).to_h
        render json: allowed_params, status: :ok
      end
    end
  end
end
