module TasksController

using Genie.Renderer
using Genie.Router
using SearchLight
using Tasks
using Dates

using ViewHelper

# index page
#   - new_form      ... ajax_create form. The normal submit will be canceled by event.preventDefault().
#   - show_done     ... show/hidden done task.
#   - tasks_tr      ... Tasks List in table > tbody. included Edit and Destroy button.
#   - today         ... Just today.
function index()
    tasks = sort(SearchLight.all(Tasks.Task), by = t -> (t.done, t.deadline))
    tasks_tr = map(task_tr, tasks) |> join
    html!(:tasks, :index, show_done = show_done(), new_form = task_form(""), tasks_tr = tasks_tr, today = Date(now()))
end

function new() # not used
    html!(:tasks, :new)
end

function create() # not used
    Tasks.Task(content = @params(:task_content), done = false, deadline = Date(@params(:task_deadline))) |> save && redirect_to(:get_tasks)
end

# edit page
#   - edit_form     ... Normal edit form.
function edit()
    task = SearchLight.find_one!!(Tasks.Task, @params(:task_id))
    html!(:tasks, :edit, edit_form = task_form(link_to(:update_task), task = task))
end

# update action
function update()
    task = SearchLight.find_one!!(Tasks.Task, @params(:task_id))
    task.content  = @params(:task_content)
    task.deadline = @params(:task_deadline)
    save(task) && redirect_to(:get_tasks)
end

function ajax_create()
    task = Tasks.Task(content = @params(:task_content), done = false, deadline = Date(@params(:task_deadline))) |> save!
    respond(Dict(:html => task_tr(task)))
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

# ajax show_done changing.
#   just write .show_done file.
#   In julia, true is 1, false is 0.
function ajax_change_show_done()
    open(fp -> write(fp, string(+(@params(:show_done) == "true"))), ".show_done", "w")
end

function show_done()
    isfile(".show_done") || touch(".show_done")
     open(fp -> read(fp, String), ".show_done", "r") == "1"
end

end
