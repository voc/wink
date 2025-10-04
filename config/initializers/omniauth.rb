Rails.application.config.middleware.use OmniAuth::Builder do
  provider :openid_connect,
    name: :oidc,                         # your single provider name
    scope: %i[openid email profile],
    response_type: :code,
    # you can use discovery+issuer OR host/scheme/port. Pick ONE style:

    # Style 1: with discovery (if your OP supports it)
    issuer: ENV.fetch("OIDC_ISSUER"),
    discovery: true,

    # OR Style 2: explicit endpoints via host/scheme/port
    # client_options: { host: "accounts.google.com", scheme: "https", port: 443, ... }

    client_options: {
      identifier:   ENV.fetch("OIDC_CLIENT_ID"),
      secret:       ENV.fetch("OIDC_CLIENT_SECRET"),
      redirect_uri: ENV.fetch("OIDC_REDIRECT_URI") # MUST be .../auth/oidc/callback
    }
end


OmniAuth.config.allowed_request_methods = %i[post]