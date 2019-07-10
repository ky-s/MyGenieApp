module TasksController

using Genie.Renderer
using Genie.Router
using SearchLight
using Tasks
using Dates

using ViewHelper

function index()
    tasks = sort(SearchLight.all(Tasks.Task), by = t -> (t.done, t.deadline))
    tasks_tr = map(task_tr, tasks) |> join
    html!(:tasks, :index, show_done = show_done(), new_form = task_form(link_to(:create_task)), tasks_tr = tasks_tr)
end

function new()
    html!(:tasks, :new)
end

function create()
    Tasks.Task(content = @params(:task_content), done = false, deadline = Date(@params(:task_deadline))) |> save && redirect_to(:get_tasks)
end

function edit()
    task = SearchLight.find_one!!(Tasks.Task, @params(:task_id))
    html!(:tasks, :edit, edit_form = task_form(link_to(:update_task), task = task))
end

function update()
    task = SearchLight.find_one!!(Tasks.Task, @params(:task_id))
    task.content  = @params(:task_content)
    task.deadline = @params(:task_deadline)
    save(task) && redirect_to(:get_tasks)
end

function ajax_update_status()
    task = SearchLight.find_one!!(Tasks.Task, @params(:task_id))
    task.done = @params(:task_done) == "true"
    save(task)
end

function ajax_destroy()
    SearchLight.find_one!!(Tasks.Task, @params(:task_id)) |> delete
    true
end

function ajax_change_show_done()
    open(fp -> write(fp, string((@params(:show_done) == "true") + 0)), ".show_done", "w")
end

function show_done()
    isfile(".show_done") || touch(".show_done")
     open(fp -> read(fp, String), ".show_done", "r") == "1"
end

end
