module StoriesHelper  
  # Give a little more space for the acceptance criteria.
  def acceptance_criteria_form_column(record, input_name)
    text_area :record, :acceptance_criteria, :name => input_name, :rows => 8, :cols => 150
  end

  # Reduce space for the effort.
  def effort_form_column(record, input_name)
    text_field :record, :effort, :name => input_name, :size => 4
  end

  # Map user displayable terms to the internal status codes.
  def status_code_mapping
    Story.status_code_mapping
  end
    
  # Override how we select status.
  def status_code_form_column(record, input_name)
    select :record, :status_code, status_code_mapping, :name => input_name
  end

  # Answer a string to represent the status.
  def status_code_column(record)
    record.status
  end
end