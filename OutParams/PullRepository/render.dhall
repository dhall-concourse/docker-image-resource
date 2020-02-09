  λ(p : ./Type.dhall)
→ toMap
    { repository = (../../deps/prelude.dhall).JSON.string p.repository
    , pull_tag = (../../deps/render-optionals.dhall).text p.pull_tag
    }
