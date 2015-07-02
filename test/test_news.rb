#######################################################################
#
# Kayako Ruby REST API library
# _____________________________________________________________________
#
# @author      Andriy Lesyuk
#
# @package     KayakoClient
# @copyright   Copyright (c) 2011-2015, Kayako
# @license     FreeBSD
# @link        https://github.com/kayako/ruby-api-library
#
#######################################################################

require 'test/unit'
require 'kayako_client'

class TestNews < Test::Unit::TestCase

    def test_path
        assert_equal KayakoClient::NewsCategory.path,  '/News/Category'
        assert_equal KayakoClient::NewsComment.path,   '/News/Comment'
        assert_equal KayakoClient::NewsItem.path,      '/News/NewsItem'
        assert_equal KayakoClient::NewsSubscriber.path,'/News/Subscriber'
    end

    def test_category
        test = KayakoClient::NewsCategory.new(
            :title => 'Test'
        )

        test.visibility_type = 'test'

        assert_equal test.post, false
        assert test.has_errors?
    end

    def test_category_client
        test = KayakoClient::NewsCategory.new

        assert test.respond_to?(:news)
        assert test.respond_to?(:get_news)
        assert test.respond_to?(:post_news)
        assert test.respond_to?(:delete_news)
    end

    def test_comment
        assert KayakoClient::NewsComment.const_defined?(:CREATOR_USER)
        assert KayakoClient::NewsComment.const_defined?(:CREATOR_STAFF)

        assert KayakoClient::NewsComment.const_defined?(:STATUS_PENDING)
        assert KayakoClient::NewsComment.const_defined?(:STATUS_APPROVED)
        assert KayakoClient::NewsComment.const_defined?(:STATUS_SPAM)

        test = KayakoClient::NewsComment.new

        assert test.respond_to?(:creator=)

        assert_raise NotImplementedError do
            test.put
        end

        assert test.respond_to?(:creator_type)
        assert test.respond_to?(:creator_id)
        assert test.respond_to?(:parent_comment_id)
        assert test.respond_to?(:parent_comment)

        assert test.respond_to?(:news_item_id)
        assert test.respond_to?(:news_item)

        assert_raise ArgumentError do
            KayakoClient::NewsComment.all
        end
    end

    def test_news
        assert KayakoClient::NewsItem.included_modules.include?(KayakoClient::ConvertAPI)

        test = KayakoClient::NewsItem.new(
            :category_ids => [ 1 ]
        )

        assert test.respond_to?(:comments)
        assert test.respond_to?(:get_comment)
        assert test.respond_to?(:post_comment)
        assert test.respond_to?(:delete_comment)

        assert test.respond_to?(:user_visibility_custom)
        assert test.respond_to?(:user_group_ids)
        assert test.respond_to?(:visible_to_user_group?)
        assert test.respond_to?(:staff_visibility_custom)
        assert test.respond_to?(:staff_group_ids)
        assert test.respond_to?(:visible_to_staff_group?)

        assert_raise ArgumentError do
            KayakoClient::NewsItem.all(1, 2)
        end

        assert test.in_category?(1)

        category = KayakoClient::NewsCategory.new(
            :id => 1
        )

        assert test.in_category?(category)
    end

    def test_subscriber
        test = KayakoClient::NewsSubscriber.new(
            :tgroupid => 1
        )

        assert_equal test.template_group_id, 1
        assert_equal test.template_group_id, test.tgroupid
    end

end
