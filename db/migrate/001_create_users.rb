Sequel.migration do
  transaction
  change do
    create_table :users do |t|
      primary_key :id
      String :name, null: false
    end
  end
end
