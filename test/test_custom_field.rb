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

require 'test/unit'
require 'kayako_client'

class TestCustomField < Test::Unit::TestCase

    def test_custom_field
        test = KayakoClient::CustomField.new(
            :custom_field_id => 1,
            :field_name      => 'Test',
            :title           => 'Test title',
            :description     => 'Test description',
            :field_type      => 1,
            :is_required     => true,
            :default_value   => 'Test',
            :regexp_validate => '/test/',
            :encrypt_in_db   => false,
            :display_order   => 1,
            :user_editable   => false,
            :staff_editable  => true
        )

        assert_equal test.custom_field_id, 1
        assert_equal test.field_name, 'Test'
        assert_equal test.title, 'Test title'
        assert_equal test.description, 'Test description'
        assert_equal test.field_type, KayakoClient::CustomField::TYPE_TEXT
        assert_equal test.default_value, 'Test'
        assert_equal test.regexp_validate, '/test/'
        assert_equal test.display_order, 1

        assert test.is_required?
        assert test.staff_editable?

        assert !test.encrypt_in_db?
        assert !test.user_editable?

        assert test.respond_to?(:options)
    end

    def test_custom_field_types
        assert_equal KayakoClient::CustomField::TYPE_TEXT, KayakoClient::TicketCustomField::TYPE_TEXT
        assert_equal KayakoClient::CustomField::TYPE_TEXT_AREA, KayakoClient::TicketCustomField::TYPE_TEXT_AREA
        assert_equal KayakoClient::CustomField::TYPE_PASSWORD, KayakoClient::TicketCustomField::TYPE_PASSWORD
        assert_equal KayakoClient::CustomField::TYPE_CHECKBOX, KayakoClient::TicketCustomField::TYPE_CHECKBOX
        assert_equal KayakoClient::CustomField::TYPE_RADIO, KayakoClient::TicketCustomField::TYPE_RADIO
        assert_equal KayakoClient::CustomField::TYPE_SELECT, KayakoClient::TicketCustomField::TYPE_SELECT
        assert_equal KayakoClient::CustomField::TYPE_MULTI_SELECT, KayakoClient::TicketCustomField::TYPE_MULTI_SELECT
        assert_equal KayakoClient::CustomField::TYPE_CUSTOM, KayakoClient::TicketCustomField::TYPE_CUSTOM
        assert_equal KayakoClient::CustomField::TYPE_LINKED_SELECT, KayakoClient::TicketCustomField::TYPE_LINKED_SELECT
        assert_equal KayakoClient::CustomField::TYPE_DATE, KayakoClient::TicketCustomField::TYPE_DATE
        assert_equal KayakoClient::CustomField::TYPE_FILE, KayakoClient::TicketCustomField::TYPE_FILE
    end

    def test_custom_field_option
        test = KayakoClient::CustomFieldOption.new(
            :custom_field_option_id => 1,
            :custom_field_id        => 1,
            :option_value           => 'Test',
            :display_order          => 1,
            :is_selected            => true
        )

        assert_equal test.custom_field_option_id, 1
        assert_equal test.custom_field_id, 1
        assert_equal test.option_value, 'Test'
        assert_equal test.display_order, 1

        assert test.is_selected?
        assert !test.has_parent_custom_field_option?
    end

end
