{ repository : Text
, tag : Optional Text
, username : Optional Text
, password : Optional Text
, aws_access_key_id : Optional Text
, aws_secret_access_key : Optional Text
, aws_session_token : Optional Text
, insecure_registries : Optional (List Text)
, registry_mirror : Optional Text
, ca_certs : Optional (List ./CACert.dhall)
, client_certs : Optional (List ./ClientCert.dhall)
, max_concurrent_downloads : Optional Natural
, max_concurrent_uploads : Optional Natural
}
