module ApplicationHelper

  def active_label(form, field, instance, opts = {})
    options = opts.merge({class: instance.send(field) ? "active #{opts[:class]}" : ""})
    form.label field, options
  end

  def checkmark_icon(yes)
    if yes
      haml_tag :i, "check", class: 'material-icons'
    end
  end
end
