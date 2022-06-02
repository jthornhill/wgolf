return if Rails.env.test? || Rails.env.development? || ENV['SECRET_KEY_BASE'].present?

# At this point we should fall back to encrypted secrets, but we need to confirm they exist
Rails.logger.debug 'No secret key base defined in the normal rails way, using vault'
return if File.file?('/app/config/credentials/production.key')

warn 'No secret key base defined, using a temporary one! Please copy over the production.key file'\
     'Note this warning is expected during asset precompilation'
Rails.application.secrets.secret_key_base = SecureRandom.base64(96)
