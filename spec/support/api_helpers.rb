# frozen_string_literal: true

module ApiHelpers
  def do_request(method, path, params = {}, headers = {})
    send method, path, params:, headers:
  end

  def json
    @json = JSON.parse(response.body)
  end
end
