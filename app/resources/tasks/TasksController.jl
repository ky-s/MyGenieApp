module TasksController

using Genie.Renderer
using Genie.Router
using SearchLight
using Tasks
using Dates

# for avoid SearchLight.all() functions error below
# 2019-07-08 12:18:02:ERROR:Main:MethodError(convert, (Dates.Date, "2019-07-08"), 0x0000000000006313)
convert(type::Type{Dates.Date}, datestr::String) = Date(datestr)

function index()
    tasks = sort(SearchLight.all(Tasks.Task), by = t -> t.done)
    html!(:tasks, :index, tasks = tasks, today = Date(now()))
end

function new()
    html!(:tasks, :new)
end

function create()
    Tasks.Task(content = @params(:task_content), done = false, deadline = Date(@params(:task_deadline))) |> save && redirect_to(:get_tasks)
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
