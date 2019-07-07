using Genie.Router
using TasksController

route("/") do
  serve_static_file("welcome.html")
end

route("/hello") do
    "Welcome to Genie!"
end

route("/tasks", TasksController.index, named = :get_tasks)
route("/tasks/new", TasksController.new, named = :new_task)
route("/tasks/create", TasksController.create, method = POST, named = :create_task)
route("/tasks/update", TasksController.update, method = POST, named = :update_task)
route("/tasks/destroy", TasksController.destroy, method = POST, named = :destroy_task)
