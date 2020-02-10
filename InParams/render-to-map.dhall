let RenderOptional = ../deps/render-optionals.dhall

in    λ(p : ./Type.dhall)
    → toMap
        { save = RenderOptional.bool p.save
        , rootfs = RenderOptional.bool p.rootfs
        , skip_download = RenderOptional.bool p.skip_download
        }
