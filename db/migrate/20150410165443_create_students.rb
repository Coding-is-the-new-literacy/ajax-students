class CreateStudents < ActiveRecord::Migration
  def change
  	create_table :students do |t|
  		t.string :email
  		t.string :password_hash

  		t.timestamps null: false
  	end
  end
end
