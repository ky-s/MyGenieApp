# TODO application

Ref: https://qiita.com/yshutaro/items/16cb2e02655911fed83b

## setup
```
julia

julia>] # switch to pkg> mode
pkg> add https://github.com/genieframework/Genie.jl
pkg> add https://github.com/genieframework/SearchLight.jl
pkg> Nullables
```

```
bin/repl

julia> using SearchLight
julia> SearchLight.Configuration.load_db_connection() |> SearchLight.Database.connect!
```

## boot Server
```
bin/server
```

access to localhost:8000/tasks
