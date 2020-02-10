{ Source =
      ./Source/package.dhall sha256:9ea8e85d1c990a954d957e9e246204b1282c3f1300b3b88ed7a59cf439268a78
    ? ./Source/package.dhall
, InParams =
      ./InParams/package.dhall sha256:9962144a2e3830b1285ce5248d87aa1acc370c03ed454e79581e6e183f4b70ed
    ? ./InParams/package.dhall
, OutParams =
      ./OutParams/package.dhall sha256:12b9716a472b86bf00bce6bfc66244f63c5e5f58b980870c4d4157105dbd77af
    ? ./OutParams/package.dhall
, ImageResource =
      ./ImageResource/package.dhall sha256:f24918556b497372a3cd1510d0160ba013f3e22e47c5bba840335fa51c596e9b
    ? ./ImageResource/package.dhall
}
