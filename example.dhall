let Concourse =
        ./deps/concourse.dhall
      ? https://raw.githubusercontent.com/akshaymankar/dhall-concourse/master/package.dhall

let DockerImage =
        ./package.dhall
      ? https://raw.githubusercontent.com/dhall-concourse/git-resource/master/package.dhall

let resource =
    -- Use Source to define source.
    -- And use Source.render to render it as `Optional (Prelude.Map.Type Text Prelude.JSON.Type)`
      Concourse.schemas.Resource::{
      , name = "test-docker-image"
      , type = Concourse.Types.ResourceType.InBuilt "docker-image"
      , source =
          DockerImage.Source.render
            DockerImage.Source::{ repository = "ubuntu" }
      }

in  resource
