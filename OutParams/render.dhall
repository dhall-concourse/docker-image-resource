-- image_from : ./ImageFrom.dhall

let Prelude = ../deps/prelude.dhall

let RenderOptional = ../deps/render-optionals.dhall

let renderImageFrom =
        λ(f : ./ImageFrom.dhall)
      → merge
          { Build = ./Build/render.dhall
          , Load = λ(l : Text) → toMap { load = Prelude.JSON.string l }
          , LoadFile = ./LoadFile/render.dhall
          , ImportFile = λ(f : Text) → toMap { load = Prelude.JSON.string f }
          , PullRepository = ./PullRepository/render.dhall
          }
          f

in    λ(p : ./Type.dhall)
    → Some
        ( Prelude.List.concat
            (Prelude.Map.Entry Text Prelude.JSON.Type)
            [ renderImageFrom p.image_from
            , toMap
                { additional_tags = RenderOptional.text p.additional_tags
                , tag = RenderOptional.text p.tag
                , tag_file = RenderOptional.text p.tag_file
                , tag_as_latest = RenderOptional.bool p.tag_as_latest
                , tag_prefix = RenderOptional.text p.tag_prefix
                }
            ]
        )
