module ApplicationHelper

  def active_label(form, field, instance, opts = {})
    options = opts.merge({class: instance.send(field) ? "active #{opts[:class]}" : ""})
    form.label field, options
  end
end
