# typed: strict
# frozen_string_literal: true

require_relative "request"
require_relative "response"

module WhatsappSdk
  module Api
    class BusinessProfile < Request
      DEFAULT_FIELDS = 'about,address,description,email,profile_picture_url,websites,vertical'

      # Get the details of business profile.
      #
      # @param phone_number_id [Integer] Phone Number Id.
      # @return [Api::Response] Response object.
      sig { params(phone_number_id: Integer).returns(Api::Response) }
      def details(phone_number_id)
        response = send_request(
          http_method: "get",
          endpoint: "#{phone_number_id}/whatsapp_business_profile?fields=#{DEFAULT_FIELDS}"
        )

        Api::Response.new(
          response: response,
          data_class_type: Api::Responses::BusinessProfileDataResponse
        )
      end

      # Update the details of business profile.
      #
      # @param phone_number_id [Integer] Phone Number Id.
      # @param params [Hash] Params to update.
      # @return [Api::Response] Response object.
      sig do
        params(
          phone_number_id: Integer, params: T::Hash[T.untyped, T.untyped]
        ).returns(Api::Response)
      end
      def update(phone_number_id:, params:)
        # this is a required field
        params[:messaging_product] = 'whatsapp'

        response = send_request(
          http_method: "post",
          endpoint: "#{phone_number_id}/whatsapp_business_profile",
          params: params
        )

        Api::Response.new(
          response: response,
          data_class_type: Api::Responses::SuccessResponse
        )
      end
    end
  end
end
