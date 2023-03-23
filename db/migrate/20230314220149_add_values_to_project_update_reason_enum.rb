class AddValuesToProjectUpdateReasonEnum < ActiveRecord::Migration[7.0]
  def up
    execute <<-SQL
      ALTER TYPE project_update_reason ADD VALUE 'schedule_conflicts' BEFORE 'blocked_by_SME';
      ALTER TYPE project_update_reason ADD VALUE 'contract_missing_items' BEFORE 'schedule_conflicts';
      ALTER TYPE project_update_reason ADD VALUE 'funding' BEFORE 'contract_missing_items';
      ALTER TYPE project_update_reason ADD VALUE 'vacation' BEFORE 'funding';
      ALTER TYPE project_update_reason ADD VALUE 'out_of_office' BEFORE 'vacation';
    SQL
  end

  def down
    execute <<-SQL
      DELETE FROM pg_enum WHERE enumlabel = 'out_of_office' AND enumtypid = (SELECT oid FROM pg_type WHERE typname = 'project_update_reason');
      DELETE FROM pg_enum WHERE enumlabel = 'vacation' AND enumtypid = (SELECT oid FROM pg_type WHERE typname = 'project_update_reason');
      DELETE FROM pg_enum WHERE enumlabel = 'funding' AND enumtypid = (SELECT oid FROM pg_type WHERE typname = 'project_update_reason');
      DELETE FROM pg_enum WHERE enumlabel = 'contract_missing_items' AND enumtypid = (SELECT oid FROM pg_type WHERE typname = 'project_update_reason');
      DELETE FROM pg_enum WHERE enumlabel = 'schedule_conflicts' AND enumtypid = (SELECT oid FROM pg_type WHERE typname = 'project_update_reason');
    SQL
  end
end
