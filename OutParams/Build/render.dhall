let JSON = (../../deps/prelude.dhall).JSON

let RenderOptional = ../../deps/render-optionals.dhall

in    λ(b : ./Type.dhall)
    → toMap
        { build = JSON.string b.build
        , build_args = RenderOptional.textTextMap b.build_args
        , build_args_file = RenderOptional.text b.build_args_file
        , cache = RenderOptional.bool b.cache
        , cache_from = RenderOptional.lists.text b.cache_from
        , cache_tag = RenderOptional.text b.cache_tag
        , dockerfile = RenderOptional.text b.dockerfile
        , lables = RenderOptional.textTextMap b.lables
        , labels_file = RenderOptional.text b.labels_file
        , load_base = RenderOptional.text b.load_base
        , load_bases = RenderOptional.lists.text b.load_bases
        , target_name = RenderOptional.text b.target_name
        }
