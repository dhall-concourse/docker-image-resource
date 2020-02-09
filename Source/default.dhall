{ tag = None Text
, username = None Text
, password = None Text
, aws_access_key_id = None Text
, aws_secret_access_key = None Text
, aws_session_token = None Text
, insecure_registries = None (List Text)
, registry_mirror = None Text
, ca_certs = None (List ./CACert.dhall)
, client_certs = None (List ./ClientCert.dhall)
, max_concurrent_downloads = None Natural
, max_concurrent_uploads = None Natural
}
