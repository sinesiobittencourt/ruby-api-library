#######################################################################
#
# Kayako Ruby REST API library
# _____________________________________________________________________
#
# @author      Andriy Lesyuk
#
# @package     KayakoClient
# @copyright   Copyright (c) 2011-2013, Kayako
# @license     FreeBSD
# @link        http://forge.kayako.com/projects/kayako-ruby-api-library
#
#######################################################################

module KayakoClient

    class CustomFieldOption < KayakoClient::Base
        supports :all

        property :custom_field_option_id,        :integer
        property :custom_field_id,               :integer
        property :option_value,                  :string
        property :display_order,                 :integer
        property :is_selected,                   :boolean
        property :parent_custom_field_option_id, :integer

        def has_parent_custom_field_option?
            !parent_custom_field_option_id.nil? && parent_custom_field_option_id > 0
        end

        def self.all(custom_field_id, options = {})
            unless custom_field_id.to_i > 0
                logger.error "invalid :custom_field_id - #{custom_field_id}" if logger
                raise ArgumentError, "invalid custom field ID"
            end
            super(options.merge(:e => "/#{self.superclass.name.split('::').last}/CustomField/ListOptions/#{custom_field_id.to_i}"))
        end

    end

    class CustomField < KayakoClient::Base
        supports :all

        TYPE_TEXT          = 1
        TYPE_TEXT_AREA     = 2
        TYPE_PASSWORD      = 3
        TYPE_CHECKBOX      = 4
        TYPE_RADIO         = 5
        TYPE_SELECT        = 6
        TYPE_MULTI_SELECT  = 7
        TYPE_CUSTOM        = 8
        TYPE_LINKED_SELECT = 9
        TYPE_DATE          = 10
        TYPE_FILE          = 11

        property :custom_field_id,       :integer
        property :field_name,            :string
        property :title,                 :string
        property :description,           :string
        property :field_type,            :integer, :range => 1..11
        property :is_required,           :boolean
        property :default_value,         :string
        property :regexp_validate,       :string
        property :custom_field_group_id, :integer
        property :encrypt_in_db,         :boolean
        property :display_order,         :integer
        property :user_editable,         :boolean
        property :staff_editable,        :boolean

        def options
            if instance_variable_defined?(:@options)
                instance_variable_get(:@options)
            elsif !new? && custom_field_id && custom_field_id > 0
                options = KayakoClient::CustomFieldOption.all(custom_field_id, inherited_options)
                if options && !options.empty?
                    instance_variable_set(:@options, options)
                else
                    instance_variable_set(:@options, nil)
                end
            else
                nil
            end
        end

    end

end
