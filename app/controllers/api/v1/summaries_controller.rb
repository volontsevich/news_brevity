# frozen_string_literal: true

module Api
  module V1
    class SummariesController < ApplicationController
      def show
        result = Summary::Operation::Generate.call(params: params)

        if result.success?
          render json: result[:result]
        else
          render json: { error: 'Invalid input' }, status: :unprocessable_entity
        end
      end

      def create
        result = Summary::Operation::Create.call(params: summary_params.to_h)

        if result.success?
          render json: result[:result]
        else
          render json: { error: result[:schema].errors.to_h }, status: :unprocessable_entity
        end
      end

      def update; end

      def destroy; end

      private

      def summary_params
        params.require(:summary).permit(:name, :channel_name, :length, :min_post_length, :delay, :exception_dictionary,
                                        :topics_to_exclude, :start_utc_time)
      end
    end
  end
end
