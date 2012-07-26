class ActionView::Helpers::FormBuilder
  
  include ActiveSupport::Configurable
  include ActionView::Helpers::UrlHelper 
  include ActionView::Helpers::AssetTagHelper
  
  def date_field_control(object, attribute, label_options = {}, field_options = {}, control_options = {})
    field_options[:class] = 'datepicker'
    field_options[:autocomplete] = 'off'
    field_options[:value] = @object.send(attribute).strftime("%Y-%m-%d") unless @object.send(attribute).blank?
    field = self.text_field(attribute, field_options)
    input_control(object, attribute, label_options, field, control_options)
  end
  
  def tag_field_control(object, attribute, label_options = {}, field_options = {}, control_options = {})
    field_options['data-pre'] = object.send(attribute)
    field_options[:autocomplete] = 'off'
    field_options[:class] = 'tag-tokens'
    field_options['data-limit'] = field_options[:limit] unless field_options[:limit].nil?
    control_options[:after] = "<p class=\"hint\">Please enter up to #{field_options[:limit]} tags</p>" unless field_options[:limit].nil?
    field = self.text_field(attribute, field_options)
    input_control(object, attribute, label_options, field, control_options)
  end

  def text_field_control(object, attribute, label_options = {}, field_options = {}, control_options = {})
    field_options[:autocomplete] = 'off'
    field = self.text_field(attribute, field_options)
    input_control(object, attribute, label_options, field, control_options)
  end

  def email_field_control(object, attribute, label_options = {}, field_options = {}, control_options = {})
    field_options[:autocomplete] = 'off'
    field = self.email_field(attribute, field_options)
    input_control(object, attribute, label_options, field, control_options)
  end

  def url_field_control(object, attribute, label_options = {}, field_options = {}, control_options = {})
    field_options[:autocomplete] = 'off'
    field = self.url_field(attribute, field_options)
    input_control(object, attribute, label_options, field, control_options)
  end

  def phone_field_control(object, attribute, label_options = {}, field_options = {}, control_options = {})
    field_options[:autocomplete] = 'off'
    field = self.phone_field(attribute, field_options)
    input_control(object, attribute, label_options, field, control_options)
  end

  def password_field_control(object, attribute, label_options = {}, field_options = {}, control_options = {})
    field_options[:autocomplete] = 'off'
    field = self.password_field(attribute, field_options)
    input_control(object, attribute, label_options, field, control_options)
  end

  def text_area_control(object, attribute, label_options = {}, field_options = {}, control_options = {})
    if control_options.extract!(:mce)[:mce]
      control_options[:after] = '<span class="togglemce">Toggle rich-text</span>'
      field_options[:class] = "mceEditor"
    end
    field_options[:autocomplete] = 'off'
    field = self.text_area(attribute, field_options)
    input_control(object, attribute, label_options, field, control_options)
  end

  def select_control(object, attribute, label_options = {}, field_options = {}, control_options = {})
    options = field_options.extract!(:options)[:options]
    field = self.select(attribute, options, field_options)
    input_control(object, attribute, label_options, field, control_options)
  end

  def file_field_control(object, attribute, label_options = {}, field_options = {}, control_options = {})
    field = self.file_field(attribute, field_options)
    input_control(object, attribute, label_options, field, control_options)
  end
  
  def contact_field_control(object, attribute, label_options = {}, field_options = {}, control_options = {})
    contact = control_options[:contact]
    id = (!contact.blank?) ? contact.id : ''
    name = (!contact.blank?) ? contact.name : ''
    image = (!contact.blank?) ? path_to_image(contact.thumbnail_path(:medium)) : ''
    self.text_field_control object, attribute, label_options, { :class => 'combobox', 'data-id' => id, 'data-name' => name, 'data-image' => image, 'data-url' => "/autocomplete/contacts", 'data-placeholder' => 'Find a Contact...' }, control_options
  end
  
  def project_field_control(object, attribute, label_options = {}, field_options = {}, control_options = {})
    project = control_options[:project]
    id = (!project.blank?) ? project.id : ''
    name = (!project.blank?) ? project.name : ''
    image = (!project.blank?) ? path_to_image(project.client.thumbnail_path(:medium)) : ''
    self.text_field_control object, attribute, label_options, { :class => 'combobox', 'data-id' => id, 'data-name' => name, 'data-image' => image, 'data-url' => "/autocomplete/projects", 'data-placeholder' => 'Find a Project...' }, control_options
  end
  
  def deal_field_control(object, attribute, label_options = {}, field_options = {}, control_options = {})
    deal = control_options[:deal]
    id = (!deal.blank?) ? deal.id : ''
    name = (!deal.blank?) ? deal.name : ''
    image = (!deal.blank?) ? path_to_image(deal.customer.thumbnail_path(:medium)) : ''
    self.text_field_control object, attribute, label_options, { :class => 'combobox', 'data-id' => id, 'data-name' => name, 'data-image' => image, 'data-url' => "/autocomplete/deals", 'data-placeholder' => 'Find a Deal...' }, control_options
  end
  
  
  private
  
    def input_control(object, attribute, label_options, field, control_options)
      label_text = label_options.extract!(:text)[:text]
      if(label_options.has_key?(:required))
        label_options.extract!(:required)[:required]
        label_options[:class] = 'required'
      end
      label = self.label(attribute, label_text, label_options)
      output = ''
      unless control_options.has_key?(:naked)
        output += '<dt>' + label + '</dt>'
        output += '<dd>'
      end
      output += control_options[:before] unless control_options[:before].nil?
      output += field
      output += control_options[:after] unless control_options[:after].nil?
      unless control_options.has_key?(:naked)
        unless object.errors[attribute].empty?
          output += '<div class="error_description">' + object.errors[attribute].first + '</div>'
        end
        output += '</dd>'
      end
      output.to_s.html_safe
    end

end