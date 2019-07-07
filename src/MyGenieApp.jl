module MyGenieApp

using Genie, Genie.Router, Genie.Renderer, Genie.AppServer

function main()
  Base.eval(Main, :(const UserApp = MyGenieApp))

  include("../genie.jl")

  Base.eval(Main, :(const Genie = MyGenieApp.Genie))
  Base.eval(Main, :(using Genie))
end

main()

end
