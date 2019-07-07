module Tasks

using SearchLight, Nullables, SearchLight.Validation, TasksValidator

export Task

mutable struct Task <: AbstractModel
  ### INTERNALS
  _table_name::String
  _id::String
  _serializable::Vector{Symbol}

  ### FIELDS
  id::DbId
  content::String
  done::Bool

  ### VALIDATION
  # validator::ModelValidator

  ### CALLBACKS
  # before_save::Function
  # after_save::Function
  # on_save::Function
  # on_find::Function
  # after_find::Function

  ### SCOPES
  # scopes::Dict{Symbol,Vector{SearchLight.SQLWhereEntity}}

  ### constructor
  Task(;
    ### FIELDS
    id = DbId(),
    content = "",
    done = false

    ### VALIDATION
    # validator = ModelValidator([
    #   ValidationRule(:title, TasksValidator.not_empty)
    # ]),

    ### CALLBACKS
    # before_save = (m::Todo) -> begin
    #   @info "Before save"
    # end,
    # after_save = (m::Todo) -> begin
    #   @info "After save"
    # end,
    # on_save = (m::Todo, field::Symbol, value::Any) -> begin
    #   @info "On save"
    # end,
    # on_find = (m::Todo, field::Symbol, value::Any) -> begin
    #   @info "On find"
    # end,
    # after_find = (m::Todo) -> begin
    #   @info "After find"
    # end,

    ### SCOPES
    # scopes = Dict{Symbol,Vector{SearchLight.SQLWhereEntity}}()

  ) = new("tasks", "id", Symbol[],                                                ### INTERNALS
          id, content, done,                                                            ### FIELDS
          # validator,                                                                  ### VALIDATION
          # before_save, after_save, on_save, on_find, after_find                       ### CALLBACKS
          # scopes                                                                      ### SCOPES
          )
end

function seed()
    Task(content = "塩を買う", done = true)        |> SearchLight.save!
    Task(content = "簡易書留を出す", done = false) |> SearchLight.save!
    Task(content = "本を5冊読む", done = false)    |> SearchLight.save!
end

end
