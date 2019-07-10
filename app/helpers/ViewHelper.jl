module ViewHelper

using Genie, Genie.Helpers, SearchLight, Genie.Router
using Dates
using Tasks

export output_flash, task_form, task_tr

function output_flash(params::Dict{Symbol,Any}) :: String
  ! isempty( flash(params) ) ? """<div class="form-group alert alert-info">$(flash(params))</div>""" : ""
end

function task_form(action; task::Tasks.Task = Tasks.Task(content = "", deadline = Date(now())))
    @show action
    id_field = isnull(task.id) ? "" : """<input type="hidden" name="task_id" value="$(get(task.id))"/>"""
    """
    <form action="$(action)" method="POST" id="task-form">
      <div class="input-group mb-3">
        $(id_field)
        <input id="task-deadline" class="form-control" type="date" name="task_deadline" value="$(task.deadline)"/>
        <input id="task-content" class="form-control" type="text" name="task_content" placeholder="Write down your TODO" value="$(task.content)" style="width: 50%" />
        <div class="input-group-append">
          <input type="submit" value="$(isnull(task.id) ? "Create" : "Update")" class="btn btn-sm btn-primary"/>
        </div>
      </div>
    </form>
    """
end

function task_tr(task)
    today = Date(now())
    """
        <tr id="tr_$(get(task.id))" data-id="$(get(task.id))" class="$(task.done ? "table-success" : "")">
          <td>
            <input type="checkbox" id="$(get(task.id))" data-id="$(get(task.id))"
                   class="checkbox done-checkbox" $(task.done ? "checked" : "") />
          </td>
          <td>
            <span id="deadline_$(get(task.id))" class="$(task.done ? "done" : task.deadline <= today ? "deadline" : "doing")">
                  $(task.deadline)
            </span>
          </td>
          <td>
            <span id="content_$(get(task.id))" class="$(task.done ? "done" : task.deadline <= today ? "deadline" : "doing")">
                  $(task.content)
            </span>
          </td>
          <td>
            <div class="btn-group">
              <a href="$(link_to(:edit_task, task_id = get(task.id)))" class="btn btn-sm btn-info">Edit</a>
              <button data-id="$(get(task.id))" class="btn btn-sm btn-danger delete-button">Delete</button>
            </div>
          </td>
        </tr>
    """
end

end
