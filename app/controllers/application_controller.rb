# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pagy::Backend

  protect_from_forgery with: :null_session
end
