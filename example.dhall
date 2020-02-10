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

let get =
      Concourse.helpers.getStep
        Concourse.schemas.GetStep::{
        , resource = resource
        , params =
            DockerImage.InParams.render
              DockerImage.InParams::{ save = Some True }
        }

let buildParams =
      DockerImage.OutParams::{
      , image_from =
          DockerImage.OutParams.ImageFrom.Type.Build
            DockerImage.OutParams.ImageFrom.Build::{
            , build = "some-repo/build-path"
            , dockerfile = Some "some-repo/build-path/Dockerfile.test"
            }
      }

let putBuild =
      Concourse.helpers.putStep
        Concourse.schemas.PutStep::{
        , resource = resource
        , params = DockerImage.OutParams.render buildParams
        }

let putImport =
      Concourse.helpers.putStep
        Concourse.schemas.PutStep::{
        , resource = resource
        , params =
            DockerImage.OutParams.render
              DockerImage.OutParams::{
              , image_from =
                  DockerImage.OutParams.ImageFrom.Type.ImportFile "path/to/file"
              }
        }

let putLoad =
      Concourse.helpers.putStep
        Concourse.schemas.PutStep::{
        , resource = resource
        , params =
            DockerImage.OutParams.render
              DockerImage.OutParams::{
              , image_from =
                  DockerImage.OutParams.ImageFrom.Type.Load "path/to/dir"
              }
        }

let putLoadFile =
      Concourse.helpers.putStep
        Concourse.schemas.PutStep::{
        , resource = resource
        , params =
            DockerImage.OutParams.render
              DockerImage.OutParams::{
              , image_from =
                  DockerImage.OutParams.ImageFrom.Type.LoadFile
                    { load_file = "path/to/file"
                    , load_repository = "example.com/docker/repo"
                    , load_tag = Some "tag"
                    }
              }
        }

let putPullRepo =
      Concourse.helpers.putStep
        Concourse.schemas.PutStep::{
        , resource = resource
        , params =
            DockerImage.OutParams.render
              DockerImage.OutParams::{
              , image_from =
                  DockerImage.OutParams.ImageFrom.Type.PullRepository
                    { repository = "example.com/docker/repo"
                    , pull_tag = Some "tag"
                    }
              }
        }

let task =
      Concourse.helpers.taskStep
        Concourse.schemas.TaskStep::{
        , task = "test-image-resource"
        , config =
            Concourse.Types.TaskSpec.Config
              Concourse.schemas.TaskConfig::{
              , image_resource =
                  DockerImage.ImageResource.render
                    DockerImage.ImageResource::{
                    , source = DockerImage.Source::{ repository = "ubuntu" }
                    }
              , run = Concourse.schemas.TaskRunConfig::{ path = "true" }
              }
        }

in  Concourse.schemas.Job::{
    , name = "example"
    , plan =
      [ get, putBuild, putImport, putLoad, putLoadFile, putPullRepo, task ]
    }
