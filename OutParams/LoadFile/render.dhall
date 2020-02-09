let RenderOptional = ../../deps/render-optionals.dhall

let JSON = (../../deps/prelude.dhall).JSON

in    λ(l : ./Type.dhall)
    → toMap
        { load_file = JSON.string l.load_file
        , load_repository = JSON.string l.load_repository
        , load_tag = RenderOptional.text l.load_tag
        }
