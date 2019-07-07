module TasksController

using Genie.Renderer
using Genie.Router
using SearchLight
using Tasks


function index()
    html!(:tasks, :index, tasks = SearchLight.all(Tasks.Task))
end

function new()
    html!(:tasks, :new)
end

function create()
    Tasks.Task(content = @params(:task_content), done = false) |> save && redirect_to(:get_tasks)
end

function update()
    task = SearchLight.find_one!!(Tasks.Task, @params(:task_id))
    task.done = @params(:task_done) == "true"
    save(task) && redirect_to(:get_tasks)
end

function destroy()
    SearchLight.find_one!!(Tasks.Task, @params(:task_id)) |> delete
    redirect_to(:get_tasks)
end

end
