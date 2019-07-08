using Genie.Router
using TasksController

route("/") do
  serve_static_file("welcome.html")
end

route("/hello") do
    "<h1>Welcome to Genie!</h1>"
end

route("/tasks", TasksController.index, named = :get_tasks)
route("/tasks/create", TasksController.create, method = POST, named = :create_task)
route("/tasks/edit", TasksController.edit, named = :edit_task)
route("/tasks/update", TasksController.update, method = POST, named = :update_task)
route("/tasks/update_status", TasksController.ajax_update_status, method = POST, named = :ajax_update_status_task)
route("/tasks/destroy", TasksController.ajax_destroy, method = POST, named = :ajax_destroy_task)
route("/tasks/change_show_done", TasksController.ajax_change_show_done, method = POST, named = :ajax_change_show_done)
