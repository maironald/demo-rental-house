# frozen_string_literal: true

module FormHelper
  def tailwind_form_for(object, **options, &)
    default_form_class = 'block mb-2 text-sm font-medium text-gray-900 dark:text-white'
    options[:html] ||= {}
    options[:html][:class] = default_form_class # you can even use arguments_with_updated_default_class here to make the default classes more flexible
    options[:builder] = Builders::TailwindFormBuilder

    simple_form_for(object, **options, &)
  end
end
