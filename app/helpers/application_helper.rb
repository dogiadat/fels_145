module ApplicationHelper

  def link_to_add_fields name, f, association
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, "#", class: "add_fields",
      data: {id: id, word_answers: fields.gsub("\n", "")})
  end

  def create_activity user_id, target_id, activity_type
    current_user.activities.create user_id: user_id, target_id: target_id,
      activity_type: activity_type
  end
end
