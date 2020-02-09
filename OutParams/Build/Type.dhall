let Map = (../../deps/prelude.dhall).Map.Type

in  { build : Text
    , build_args : Optional (Map Text Text)
    , build_args_file : Optional Text
    , cache : Optional Bool
    , cache_from : Optional (List Text)
    , cache_tag : Optional Text
    , dockerfile : Optional Text
    , lables : Optional (Map Text Text)
    , labels_file : Optional Text
    , load_base : Optional Text
    , load_bases : Optional (List Text)
    , target_name : Optional Text
    }
