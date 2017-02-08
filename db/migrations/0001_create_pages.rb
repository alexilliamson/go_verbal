Sequel.migration do
  up do
    create_table(:pages) do
      primary_key :id
      String :url, :null=>false
      String :title, :null=>false
      Date :date, :null=>false
      String :section, :null=>false
    end
  end

  down do
    drop_table(:pages)
  end
end
