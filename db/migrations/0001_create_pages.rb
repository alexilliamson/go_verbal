Sequel.migration do
  up do
    create_table(:pages) do
      primary_key :id
      String :url, :null=>false
    end
  end

  down do
    drop_table(:artists)
  end
end
