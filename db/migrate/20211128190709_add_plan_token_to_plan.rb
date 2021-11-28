class AddPlanTokenToPlan < ActiveRecord::Migration[6.1]
  def change
    add_column :plans, :plan_token, :string
  end
end
