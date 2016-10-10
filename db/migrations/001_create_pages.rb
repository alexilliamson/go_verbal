Sequel.migration do
  up do
    create_table(:pages) do
      primary_key :id
      String :url, :null=>false
      Text :content, :null=> false
    end
  end

  down do
    drop_table(:pages)
  end
end

