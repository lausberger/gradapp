# frozen_string_literal: true

# Application helper tools
module ApplicationHelper
  # CC - https://stevepolito.design/blog/create-a-nested-form-in-rails-from-scratch/
  def link_to_add_fields(name, form_ref, association)
    new_object = form_ref.object.send(association).klass.new
    id = new_object.object_id

    fields = form_ref.fields_for(association, new_object, child_index: id) do |builder|
      render("#{association.to_s.singularize}_fields", f: builder)
    end

    link_to(name, '#', class: 'add_fields', data: { id: id, fields: fields.gsub("\n", '') })
  end
end
