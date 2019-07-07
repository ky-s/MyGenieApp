  cd(@__DIR__)
  using Pkg
  pkg"activate ."

  function main()
    include(joinpath("src", "MyGenieApp.jl"))
  end

  main()
