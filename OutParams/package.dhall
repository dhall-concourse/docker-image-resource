{ Type =
      ./Type.dhall sha256:c77a0b3133f0682a38d357a93ba2131e2061afc44fc2268e74c82dcd77dd530f
    ? ./Type.dhall
, default =
      ./default.dhall sha256:e682e8ff97967d34cbe6d1fad8b182b3c76823c0517fa1b91de922f56b161036
    ? ./default.dhall
, render =
      ./render.dhall sha256:99b010923e86671707a964d24b36c56f44acfa9e33af35bfb1e34e5e2d4e19cb
    ? ./render.dhall
, ImageFrom =
    { Type =
          ./ImageFrom.dhall sha256:95c076b6b3f005b23bb8fa224668b58504a8460749c193620a2e3cf187adce5b
        ? ./ImageFrom.dhall
    , Build =
          ./Build/package.dhall sha256:343d881f974332fd70307da13bcfd0bd61ed0e0267d96871a63ac71bda011a51
        ? ./Build/package.dhall
    , LoadFile =
          ./LoadFile/package.dhall sha256:b0e5be08c6a0958df61322cfb548145937b195a32bf07071a8ebe33ced8fdb40
        ? ./LoadFile/package.dhall
    , PullRepository =
          ./PullRepository/package.dhall sha256:e88433f2e0d67bf1627360f2d39ef64436aa076d29c2972ae90884b243d6c95b
        ? ./PullRepository/package.dhall
    }
}
