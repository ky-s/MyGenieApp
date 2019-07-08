module AddDateToTasks

import SearchLight.Migrations: add_column, remove_column

function up()
    add_column(:tasks, :deadline, :date)
end

function down()
    remove_column(:tasks, :deadline)
end

end
