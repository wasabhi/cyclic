module TwitterFormHelper

  def self.included(base)
    ActionView::Helpers::FormBuilder.instance_eval do
      include TwitterFormBuilderMethods
    end
  end

  module TwitterFormBuilderMethods

    ###
    #
    # prefix any form_for helpers with twitter to get the input field marked up for twitter bootstrap
    #
    # twitter[input](field, [option])
    #
    # => <%= f.twitter_text_field :name %>
    # => <%= f.twitter_password_field :password %>
    #
    # options:
    #
    # :class => wrapping div class
    # :input => options passed to the form_for input helper
    # :label => options passed to the form_for label helper
    #
    # => <%= f.twitter_text_field :name, :class => 'admin-name' %>
    # => <%= f.twitter_text_field :name, :input => { :class => 'admin-name' } %>
    #
    ###
    #
    # twitter_input_collection([field, [options]], &block)
    #
    # => <%= f.twitter_input_collection do %>
    #      <%= f.twitter_check_box :remember_me %>
    #    <% end %>
    #
    # options:
    #
    # :class            => wrapping div class
    # :collection_label => specify a label for the collection (only use when field isn't passed in agrs)
    #
    ###
    
    include ApplicationHelper

    def respond_to?(name)
      twitter?(name) || super(name)
    end

    def method_missing(name, *args, &block) 
      if twitter? name
        field = args.first
        options = args[1] || {}
        twitter_build twitter_options(name, field, options)
      else
        super name, *args, &block
      end
    end

    def twitter_input_collection(field = nil, options = {}, &block) 
      options = twitter_options('collection', field, options)
      @collection = []
      @has_error = false
      @extra_errors = ''

      @has_error ||= options[:errors?]

      html = twitter_wrapper(options) do |body|
        body << "<label>#{options[:collection_label]}</label>"
        body << twitter_input_wrapper(options) do |input_wrapper|
          input_wrapper << @template.content_tag(:ul, :class => 'inputs-list') do
            ul = ''
            yield ul
            ul.html_safe
          end
        end
        body << twitter_input_wrapper(options) do |errors|
          errors << twitter_errors(options)
          errors << @extra_errors
        end
      end
      html = html.gsub(/clearfix (?:error)?/, 'clearfix error') if @has_error
      @collection = nil
      @has_error = nil
      html.html_safe
    end

    def twitter_date_range(start, stop, options = {}) 
      options[:collection_label] ||= 'Date Range'
      twitter_input_collection(nil, options) do |wrapper|
        wrapper << text_field(start, :value => formatted_date(@object.try(start)), :class => 'small datepicker')
        wrapper << ' to '
        wrapper << text_field(stop, :value => formatted_date(@object.try(stop)), :class => 'small datepicker')
        @has_error = twitter_field_errors?(start) || twitter_field_errors?(stop)
        @extra_errors = twitter_errors(:errors => [twitter_field_errors(start), twitter_field_errors(stop)].flatten)
      end
    end

    def twitter_base_errors
      if @object.errors[:base].any?
        @template.content_tag :div, :class => 'clearfix error base' do
          body = ''
          @object.errors[:base].each do |error|
            body += "<div class=\"input base-error\">#{error}</div>"
          end
          body.html_safe
        end
      end
    end

    private

    def twitter?(name)
      name.to_s.starts_with? 'twitter_'
    end

    def twitter_field_type(name)
      name.to_s.gsub(/twitter_/, '').to_sym
    end

    def twitter_field_errors(field)
      @object.errors[field]
    end

    def twitter_field_errors?(field)
      twitter_field_errors(field).any?
    end

    def twitter_options(name, field, options)
      options[:type] = twitter_field_type(name)
      options[:field] = field
      options[:errors?] = field.nil? ? false : twitter_field_errors?(field)
      options[:errors] = field.nil? ? [] : twitter_field_errors(field)
      options[:input] ||= {}
      options[:label] ||= {}
      options[:class] ||= ''
      options[:collection_label] ||= twitter_label_name(options)
      options
    end

    def twitter_build(options)
      if @collection.nil?
        twitter_wrapper options do |wrapper|
          wrapper << twitter_label(options)
          wrapper << twitter_input_wrapper(options) do |body|
            body << twitter_input(options)
            body << twitter_errors(options)
          end
        end
      else
        @has_error ||= options[:errors?]
        twitter_inline_label_wrapper(options) do |body|
          body << twitter_input(options)
          body << "<span>&nbsp;#{options[:input_label] || twitter_label_name(options)}</span>"
          body << twitter_errors(options)
        end
      end
    end

    def twitter_wrapper(options, &block)
      @template.content_tag :div, :class => "#{options[:class]} clearfix #{'error' if options[:errors?]}" do
        body = ''
        yield body
        body.html_safe
      end
    end

    def twitter_input_wrapper(options, &block) 
      @template.content_tag :div, :class => 'input' do
        body = ''
        yield body
        body.html_safe
      end
    end

    def twitter_label_for(options)
      label = twitter_label(options).gsub(/^.*for="(.*?)".*$/, '\1')
      label += "_#{options[:input][0]}" if options[:type] == :radio_button
      label
    end

    def twitter_label_name(options)
      twitter_label(options).gsub(/^.*?>(.*)<[^<]*$/, '\1')
    end

    def twitter_inline_label_wrapper(options, &block) 
      body = "<li><label for=\"#{twitter_label_for(options)}\">"
      yield body
      body << "</label></li>"
      body.html_safe
    end

    def twitter_label(options) 
      @template.label(@object_name, options[:field], *options[:label])
    end

    def twitter_input(options)
      @template.try(options[:type], @object_name, options[:field], *options[:input])
    end

    def twitter_errors(options)
      errors = ''
      options[:errors].each do |error|
        is_last = error == options[:errors].last
        errors << twitter_error(error, is_last)
      end
      errors.html_safe
    end

    def twitter_error(error, is_last = true)
      @template.content_tag(:span, "#{error}#{',' unless is_last}", :class => 'help-inline')
    end

  end

end
