# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  private

  def ensure_frame_response
    redirect_to root_path unless turbo_frame_request?
  end
end
