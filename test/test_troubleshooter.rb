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
# @link        https://github.com/kayako/ruby-api-library
#
#######################################################################

require 'test/unit'
require 'kayako_client'

class TestTroubleshooter < Test::Unit::TestCase

    def test_path
        assert_equal KayakoClient::TroubleshooterAttachment.path, '/Troubleshooter/Attachment'
        assert_equal KayakoClient::TroubleshooterCategory.path,   '/Troubleshooter/Category'
        assert_equal KayakoClient::TroubleshooterComment.path,    '/Troubleshooter/Comment'
        assert_equal KayakoClient::TroubleshooterStep.path,       '/Troubleshooter/Step'
    end

    def test_step_api
        assert_raise ArgumentError do
            KayakoClient::TroubleshooterAttachment.all
        end

        assert_raise ArgumentError do
            KayakoClient::TroubleshooterAttachment.get(1)
        end

        assert_raise ArgumentError do
            KayakoClient::TroubleshooterAttachment.delete(1)
        end

        test = KayakoClient::TroubleshooterAttachment.new(
            :id => 1
        )
        test.loaded!

        assert_raise RuntimeError do
            test.delete
        end
    end

    def test_step
        test = KayakoClient::TroubleshooterStep.new(
            :parent_step_ids => [ 1 ],
            :child_step_ids => [ 2 ]
        )

        assert test.respond_to?(:get_attachment)
        assert test.respond_to?(:get_comment)

        assert test.has_parent_steps?
        assert test.in_step?(1)
        assert !test.in_step?(2)

        assert test.has_child_steps?
        assert test.has_step?(2)
        assert !test.has_step?(1)
    end

    def test_attachment
        test = KayakoClient::TroubleshooterAttachment.new

        assert test.respond_to?(:file=)
        assert test.respond_to?(:file)

        assert test.respond_to?(:troubleshooter_step_id)
        assert test.respond_to?(:troubleshooter_step)
    end

    def test_category
        assert KayakoClient::TroubleshooterCategory.included_modules.include?(KayakoClient::ConvertAPI)

        test = KayakoClient::TroubleshooterCategory.new

        test.respond_to?(:visible_to_user_group?)
        test.respond_to?(:visible_to_staff_group?)
    end

    def test_comment
        test = KayakoClient::TroubleshooterComment.new

        assert test.respond_to?(:creator=)

        assert test.respond_to?(:troubleshooter_step_id)
        assert test.respond_to?(:troubleshooter_step)

        assert_raise NotImplementedError do
            test.put
        end

        assert test.respond_to?(:creator_type=)
        assert test.respond_to?(:creator_id=)

        assert test.respond_to?(:user_agent)
        assert test.respond_to?(:referrer)
    end

end
