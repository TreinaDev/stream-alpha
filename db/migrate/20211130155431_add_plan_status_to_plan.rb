class AddPlanStatusToPlan < ActiveRecord::Migration[6.1]
  def change
    add_column :plans, :plan_status, :integer, default: 0
  end
end
