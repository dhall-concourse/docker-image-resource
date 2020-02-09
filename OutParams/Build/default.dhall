let Map = (../../deps/prelude.dhall).Map.Type

in  { build_args = None (Map Text Text)
    , build_args_file = None Text
    , cache = None Bool
    , cache_from = None (List Text)
    , cache_tag = None Text
    , dockerfile = None Text
    , lables = None (Map Text Text)
    , labels_file = None Text
    , load_base = None Text
    , load_bases = None (List Text)
    , target_name = None Text
    }
