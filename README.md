# dhall-concourse/docker-image-resource

[dhall-concourse](https://github.com/akshaymankar/dhall-concourse) bindings for [docker-image-resource](https://github.com/concourse/docker-image-resource)

## Usage

### Source

To define a resource with source rendered by this package, you can use the `Source` type like this: 

```dhall
let Concourse =
        ./deps/concourse.dhall
      ? https://raw.githubusercontent.com/akshaymankar/dhall-concourse/master/package.dhall

let DockerImage =
        ./package.dhall
      ? https://raw.githubusercontent.com/dhall-concourse/git-resource/master/package.dhall

let myDockerResource =
    -- Use Source to define source.
    -- And use Source.render to render it as `Optional (Prelude.Map.Type Text Prelude.JSON.Type)`
      Concourse.schemas.Resource::{
      , name = "test-docker-image"
      , type = Concourse.Types.ResourceType.InBuilt "docker-image"
      , source =
          DockerImage.Source.render
            DockerImage.Source::{ repository = "ubuntu" }
      }

in myDockerResource
```

The `Source` type supports all parameters accepted by the docker-image-resource.
You can look at the full type [here](Source/Type.dhall).

For detailed explanation please refer to the [docker-image-resource README](https://github.com/concourse/docker-image-resource/blob/master/README.md)

### InParams (params for the `get` step)

To define the `params` for `get` step to get a git resource, you can use the `InParams` type like this: 

```dhall
let Concourse =
        ./deps/concourse.dhall
      ? https://raw.githubusercontent.com/akshaymankar/dhall-concourse/master/package.dhall

let DockerImage =
        ./package.dhall
      ? https://raw.githubusercontent.com/dhall-concourse/git-resource/master/package.dhall

let myDockerResource = ./resource-defined-earlier.dhall

let get =
      Concourse.helpers.getStep
        Concourse.schemas.GetStep::{
        , resource = myDockerResource
        , params =
            DockerImage.InParams.render
              DockerImage.InParams::{ save = Some True }
        }

in get
```

This type also supports all parameters supported by the docker-image resource.
The type is defined [here](InParams/Type.dhall) and the detailed explanation is on the [docker-image resource README](https://github.com/concourse/docker-image-resource/#in-fetch-the-image-from-the-registry)

### OutParams (params for the `put` step)

To define the `params` for `put` step to push and image to a docker repository, you can use the `OutParams`. The `OutParams` type is more than just a simple record because the docker-image resource supports pushing images in 5 ways: `build`, `load`, `load_file`, `import_file` and `pull_repository`.

Here is an example for each of these:

#### Build

Build requires a record with type described [here](OutParams/Build/Type.dhall)

```dhall
let Concourse =
        ./deps/concourse.dhall
      ? https://raw.githubusercontent.com/akshaymankar/dhall-concourse/master/package.dhall

let DockerImage =
        ./package.dhall
      ? https://raw.githubusercontent.com/dhall-concourse/git-resource/master/package.dhall

let myDockerResource = ./resource-defined-earlier.dhall

let buildParams =
      DockerImage.OutParams.ImageFrom.Type.Build
        DockerImage.OutParams.ImageFrom.Build::{
        , build = "some-repo/build-path"
        , dockerfile = Some "some-repo/build-path/Dockerfile.test"
        }

let putBuild =
      Concourse.helpers.putStep
        Concourse.schemas.PutStep::{
        , resource = resource
        , params =
            DockerImage.OutParams.render
              DockerImage.OutParams::{
              , image_from = buildParams
              , tag_as_latest = Some True 
              --^ This option is valid for any of the 5 ways of pushing
              }
        }

in  putBuild
```

#### Load

Load requires just one text argument which should be the path of a directory containing an image that was fetched using this same resource type with `save: true`. This is equivalent to specifying `load` in YAML config for docker-image resource.

```dhall
let Concourse =
        ./deps/concourse.dhall
      ? https://raw.githubusercontent.com/akshaymankar/dhall-concourse/master/package.dhall

let DockerImage =
        ./package.dhall
      ? https://raw.githubusercontent.com/dhall-concourse/git-resource/master/package.dhall

let myDockerResource = ./resource-defined-earlier.dhall

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

in putLoad
```

#### Load File

Build requires a record with type described [here](OutParams/LoadFile/Type.dhall).

```dhall
let Concourse =
        ./deps/concourse.dhall
      ? https://raw.githubusercontent.com/akshaymankar/dhall-concourse/master/package.dhall

let DockerImage =
        ./package.dhall
      ? https://raw.githubusercontent.com/dhall-concourse/git-resource/master/package.dhall

let myDockerResource = ./resource-defined-earlier.dhall

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

in putLoadFile
```

#### ImportFile

ImportFile requires just one text argument, it specifies the path to a file to `docker import` and push.

```dhall
let Concourse =
        ./deps/concourse.dhall
      ? https://raw.githubusercontent.com/akshaymankar/dhall-concourse/master/package.dhall

let DockerImage =
        ./package.dhall
      ? https://raw.githubusercontent.com/dhall-concourse/git-resource/master/package.dhall

let myDockerResource = ./resource-defined-earlier.dhall

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
        
in putImport
```

#### Pull Repository (Deprecated)

PullRepository requires a record with `repository` (corresponds to `pull_repository` in docker-image resource docs) which is a `Text` field containing the name of repository to push. It also contains and optional `pull_tag` field, which specified what tag to pull, it defaults to `latest`.

```dhall
let Concourse =
        ./deps/concourse.dhall
      ? https://raw.githubusercontent.com/akshaymankar/dhall-concourse/master/package.dhall

let DockerImage =
        ./package.dhall
      ? https://raw.githubusercontent.com/dhall-concourse/git-resource/master/package.dhall

let myDockerResource = ./resource-defined-earlier.dhall

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

in putPullRepo
```

### ImageResource

The docker-image is the most commonly used resource in defining tasks. Here is how one can use it:

```dhall
let Concourse =
        ./deps/concourse.dhall
      ? https://raw.githubusercontent.com/akshaymankar/dhall-concourse/master/package.dhall

let DockerImage =
        ./package.dhall
      ? https://raw.githubusercontent.com/dhall-concourse/git-resource/master/package.dhall

let imageSource =
      DockerImage.ImageResource::{
      , source = DockerImage.Source::{ repository = "ubuntu" }
      }

let task =
      Concourse.helpers.taskStep
        Concourse.schemas.TaskStep::{
        , task = "test-image-resource"
        , config =
            Concourse.Types.TaskSpec.Config
              Concourse.schemas.TaskConfig::{
              , image_resource = DockerImage.ImageResource.render imageSource
              , run = Concourse.schemas.TaskRunConfig::{ path = "true" }
              }
        }

in  task
```
