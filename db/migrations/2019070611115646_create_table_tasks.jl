module CreateTableTasks

import SearchLight.Migrations: create_table, column, primary_key, add_index, drop_table

function up()
  create_table(:tasks) do
    [
      primary_key()
      column(:content, :string)
      column(:done, :bool)
    ]
  end

  add_index(:tasks, :content)
end

function down()
  drop_table(:tasks)
end

end
