let JSON = (../deps/prelude.dhall).JSON

let RenderOptional = ../deps/render-optionals.dhall

let renderCACert =
        λ(cert : ./CACert.dhall)
      → JSON.object
          ( toMap
              { domain = JSON.string cert.domain, cert = JSON.string cert.cert }
          )

let renderClientCert =
        λ(cert : ./ClientCert.dhall)
      → JSON.object
          ( toMap
              { domain = JSON.string cert.domain
              , cert = JSON.string cert.cert
              , key = JSON.string cert.key
              }
          )

in    λ(source : ./Type.dhall)
    → Some
        ( toMap
            { repository = JSON.string source.repository
            , tag = RenderOptional.text source.tag
            , username = RenderOptional.text source.username
            , password = RenderOptional.text source.password
            , aws_access_key_id = RenderOptional.text source.aws_access_key_id
            , aws_secret_access_key =
                RenderOptional.text source.aws_secret_access_key
            , aws_session_token = RenderOptional.text source.aws_session_token
            , insecure_registries =
                RenderOptional.lists.text source.insecure_registries
            , registry_mirror = RenderOptional.text source.registry_mirror
            , ca_certs =
                RenderOptional.lists.generic
                  ./CACert.dhall
                  renderCACert
                  source.ca_certs
            , client_certs =
                RenderOptional.lists.generic
                  ./ClientCert.dhall
                  renderClientCert
                  source.client_certs
            , max_concurrent_downloads =
                RenderOptional.natural source.max_concurrent_downloads
            , max_concurrent_uploads =
                RenderOptional.natural source.max_concurrent_uploads
            }
        )
