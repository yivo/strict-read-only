# encoding: UTF-8
# frozen_string_literal: true

require "active_support/concern"
require "active_support/lazy_load_hooks"

module StrictReadOnly
  module Extension
    extend ActiveSupport::Concern

    included do
      validate do
        @read_only_data&.each do |attribute, value|
          new_value = send(attribute)
          errors.add(attribute, :read_only) unless new_value == value
        end
      end
    end

    module ClassMethods
      def read_only_attribute(*attributes)
        extension = Module.new
        options   = attributes.extract_options!

        attributes.map(&:to_s).each do |name|
          extension.class_eval <<-RUBY, __FILE__, __LINE__ + 1
            def #{name}=(*)
              if #{options.fetch(:if, :persisted?)}
                @read_only_data ||= {}
                @read_only_data["#{name}"] = #{name} unless @read_only_data.key?("#{name}")
              end
              super
            end
          RUBY
        end

        prepend extension
      end
    end
  end
end

ActiveSupport.on_load(:active_record) { ActiveRecord::Base.include StrictReadOnly::Extension }
