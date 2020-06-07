{ Source =
      ./Source/package.dhall sha256:a5e8b2ddaf7ce81309cdbf41d26a92a0267b04fbe54262fae201706b85c76f7d
    ? ./Source/package.dhall
, InParams =
      ./InParams/package.dhall sha256:0105a4a99ebb9dc409b833835d2e3eed3a13343987d35b91b8d87d6c02fc391a
    ? ./InParams/package.dhall
, OutParams =
      ./OutParams/package.dhall sha256:fd8dcac3035236a43b73f8b4df8cca6c96f150219dd9c09cdc2d2b9dfad2a50c
    ? ./OutParams/package.dhall
, ImageResource =
      ./ImageResource/package.dhall sha256:5edff1c31c48f3a665ed0dfa198a08d1128b79d3bf1f517c2afe5866fd5f473e
    ? ./ImageResource/package.dhall
}
