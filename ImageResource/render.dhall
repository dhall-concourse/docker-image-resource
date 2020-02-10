let Prelude = ../deps/prelude.dhall

let ConcourseImageResource = (../deps/concourse.dhall).Types.ImageResource

let render
    : ./Type.dhall → Optional ConcourseImageResource
    =   λ(i : ./Type.dhall)
      → Some
          { type = "docker-image"
          , source = ../Source/render.dhall i.source
          , params =
              Prelude.Optional.map
                ../InParams/Type.dhall
                (Prelude.Map.Type Text Prelude.JSON.Type)
                ../InParams/render-to-map.dhall
                i.params
          , version =
              Prelude.Optional.map
                Text
                (Prelude.Map.Type Text Text)
                (λ(v : Text) → toMap { digest = v })
                i.version
          }

in  render
