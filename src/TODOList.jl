module TODOList

using Genie, Genie.Router, Genie.Renderer, Genie.AppServer

function main()
  Base.eval(Main, :(const UserApp = TODOList))

  include("../genie.jl")

  Base.eval(Main, :(const Genie = TODOList.Genie))
  Base.eval(Main, :(using Genie))
end

main()

end
