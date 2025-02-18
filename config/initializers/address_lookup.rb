EA::AddressLookup.configure do |config|
  config.address_facade_server    = Rails.application.secrets.address_facade_server
  config.address_facade_port      = Rails.application.secrets.address_facade_port
  config.address_facade_url       = "/address-service/v1/addresses/postcode"
  config.timeout_in_seconds       = Rails.application.secrets.address_facade_timeout
  config.address_facade_client_id = Rails.application.secrets.address_facade_client_id
  config.address_facade_key       = Rails.application.secrets.address_facade_key
end
