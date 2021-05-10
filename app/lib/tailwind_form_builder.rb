# frozen_string_literal: true

class TailwindFormBuilder < ActionView::Helpers::FormBuilder
  def text_input(name, *args, &block)
    args[0].merge!({ type: 'text' }) if args.any?
    input_element(:text_field, name, *args, &block)
  end

  def area_input(name, *args, &block)
    input_element(:text_area, name, *args, &block)
  end

  def email_input(name, *args, &block)
    args[0].merge!({ type: 'email' }) if args.any?
    input_element(:text_field, name, *args, &block)
  end

  def password_input(name, *args, &block)
    args[0].merge!({ type: 'password' }) if args.any?
    input_element(:text_field, name, *args, &block)
  end

  def number_input(name, *args, &block)
    args[0].merge!({ type: 'number' }) if args.any?
    input_element(:text_field, name, *args, &block)
  end

  def date_input(name, *args, &block)
    input_element(:date_select, name, *args, &block)
  end

  def datetime_input(name, *args, &block)
    input_element(:datetime_select, name, *args, &block)
  end

  def radio_button(name, *args, &block)
    options = args.extract_options!
    message = options.fetch(:message, error_message(name))
    error = options.fetch(:error, any_errors?(name))

    @template.content_tag(:div, { class: 'form-element pb-4', id: "field-#{name}" }) do
      @template.concat(@template.content_tag(:div, { class: 'flex items-center' }) do
        @template.concat(radio_button(name, {class: 'focus:ring-indigo-500 h-4 w-4 text-indigo-600 border-gray-300' + (error ? ' invalid-input' : '') }.merge(options)))
        @template.concat(label(name, { class: 'ml-3 block text-sm font-medium text-gray-700' }))
      end)
      @template.concat(hint_message(message, error))
    end
  end

  def collection_select_input(name, collection, value_method, text_method, options = {}, html_options = {})
    html_options.merge!(class: "shadow-sm focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md")
    collection_select(name, collection, value_method, text_method, options, html_options)
  end

  def check_input(name, *args, &block)
    options = args.extract_options!
    message = options.fetch(:message, error_message(name))
    error = options.fetch(:error, any_errors?(name))

    @template.content_tag(:div, { class: 'form-element pb-4', id: "field-#{name}" }) do
      @template.concat(@template.content_tag(:div, { class: 'flex items-center' }) do
        @template.concat(check_box(name, {class: 'focus:ring-indigo-500 h-4 w-4 text-indigo-600 border-gray-300 rounded' + (error ? ' invalid-input' : '') }.merge(options)))
        @template.concat(label(name, { class: 'ml-3 font-medium text-gray-700' }))
      end)
      @template.concat(hint_message(message, error))
    end
  end

  def submit_button(name, *args, &block)
    args << { class: "inline-flex items-center px-3 py-2 border border-transparent text-sm leading-4 font-medium rounded-md s hadow-sm text-white bg-green-600 hover:bg-green-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring -green-500" }
    button(name, *args, &block)
  end

  private

  def input_element(field_type, name, *args, &block)
    options = args.extract_options!
    input_type = options.fetch(:type, 'text')
    message = options.fetch(:message, error_message(name))
    error = options.fetch(:error, any_errors?(name))
    label_text = options.fetch(:label, name)

    @template.content_tag(:div, { class: 'form-element pb-4', id: "field-#{name}" }) do
      @template.concat(label(label_text, { class: 'text-sm font-medium text-gray-700' }))
      @template.concat(@template.content_tag(:div, { class: 'relative mt-1' }) do
        @template.concat(show_icon(block)) if block.present?
        @template.concat(send(field_type, name, { type: input_type, class: 'shadow-sm focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md' + (block.present? ? ' pl-10' : '') + (error ? ' invalid-input' : '') }.merge(options)))
      end)
      @template.concat(hint_message(message, error))
    end
  end

  def show_icon(block)
    @template.content_tag(:span, { class: 'absolute inset-y-0 left-0 pl-2 text-gray-600 flex items-center' }) do
      block.call
    end
  end

  def hint_message(message, error)
    return unless message.present?

    @template.content_tag(:span, class: 'text-sm ' + (error ? 'hint-error' : 'hint')) do
      message
    end
  end

  def error_message(name)
    return '' unless @object&.errors

    @object.errors[name].join(', ')
  end

  def any_errors?(name)
    return false unless @object&.errors

    @object.errors[name].any?
  end
end
