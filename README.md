# TODO application

Ref: https://qiita.com/yshutaro/items/16cb2e02655911fed83b

## setup
```
bin/repl

julia> SearchLight.Configuration.load_db_connection() |> SearchLight.Database.connect!
julia> SearchLight.db_init()
julia> SearchLight.Migration.last_up()
```

## boot Server
```
bin/server
```

access to localhost:8000/tasks
