module ViewHelper

using Genie, Genie.Helpers, SearchLight, Genie.Router
using Dates
using Tasks

export output_flash, task_form

function output_flash(params::Dict{Symbol,Any}) :: String
  ! isempty( flash(params) ) ? """<div class="form-group alert alert-info">$(flash(params))</div>""" : ""
end

function task_form(action; task::Tasks.Task = Tasks.Task(content = "", deadline = Date(now())))
    @show action
    id_field = isnull(task.id) ? "" : """<input type="hidden" name="task_id" value="$(get(task.id))"/>"""
    """
    <form action="$(action)" method="POST">
      <div class="input-group mb-3">
        $(id_field)
        <input class="form-control" type="date" name="task_deadline" value="$(task.deadline)"/>
        <input id="todo-content" class="form-control" type="text" name="task_content" placeholder="Write down your TODO" value="$(task.content)" style="width: 50%" />
        <div class="input-group-append">
          <input type="submit" value="$(isnull(task.id) ? "Create" : "Update")" class="btn btn-sm btn-primary"/>
        </div>
      </div>
    </form>
    """
end


end
