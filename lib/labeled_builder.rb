class LabeledBuilder < ActionView::Helpers::FormBuilder
  select_form_fields  = [:date_select, :select, :collection_select]
  text_form_fields = field_helpers - %w(hidden_field label radio_button fields_for)
  
  (select_form_fields + text_form_fields).each do |name|
    # build a custom *_field method for each element we want prepended with a <label>
    define_method(name) do |name, *args|
      field_label = args.last.delete(:label) if args.last.is_a?(Hash)
      
      # dont render a <label> if :label => :none
      field_label ||= name.to_s.titleize
      label_html = field_label == :none ? "" : label(name, "#{field_label}:")
      
      @template.content_tag("div", (label_html + super))
    end
  end
end
