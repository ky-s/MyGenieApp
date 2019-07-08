module TasksController

using Genie.Renderer
using Genie.Router
using SearchLight
using Tasks
using Dates

function index()
    tasks = sort(SearchLight.all(Tasks.Task), by = t -> (t.done, t.deadline))
    html!(:tasks, :index, tasks = tasks, today = Date(now()))
end

function new()
    html!(:tasks, :new)
end

function create()
    @show @params
    Tasks.Task(content = @params(:task_content), done = false, deadline = Date(@params(:task_deadline))) |> save && redirect_to(:get_tasks)
end

function update()
    task = SearchLight.find_one!!(Tasks.Task, @params(:task_id))
    task.done = @params(:task_done) == "true"
    save(task)
end

function destroy()
    SearchLight.find_one!!(Tasks.Task, @params(:task_id)) |> delete
    true
end

end
