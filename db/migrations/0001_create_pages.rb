Sequel.migration do
  up do
    create_table(:pages) do
      primary_key :id
      String :url, :null=>false, :unique => true
      String :title, :null=>false
      Date :date, :null=>false
      String :section, :null=>false
      String :content
    end
  end

  down do
    drop_table(:pages)
  end
end
