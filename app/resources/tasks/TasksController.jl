module TasksController

using Genie.Renderer
using Genie.Router
using SearchLight
using Tasks


function index()
    tasks = sort(SearchLight.all(Tasks.Task), by = t -> t.done)
    html!(:tasks, :index, tasks = tasks)
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
