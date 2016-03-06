Sequel.migration do
  transaction
  change do
    create_table :users do |t|
      primary_key :id
      String :first_name, null: false
      String :last_name, null: false
      String :email
      String :photo_url
      DateTime :created_at
      DateTime :updated_at
    end
  end
end
