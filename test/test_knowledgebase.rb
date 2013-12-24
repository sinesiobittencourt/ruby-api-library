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

class TestKnowledgebase < Test::Unit::TestCase

    def test_knowledgebase_api
        assert_equal KayakoClient::KnowledgebaseArticle.path,    '/Knowledgebase/Article'
        assert_equal KayakoClient::KnowledgebaseAttachment.path, '/Knowledgebase/Attachment'
        assert_equal KayakoClient::KnowledgebaseCategory.path,   '/Knowledgebase/Category'
        assert_equal KayakoClient::KnowledgebaseComment.path,    '/Knowledgebase/Comment'
    end

    def test_creator_api
        test = KayakoClient::KnowledgebaseArticle.new

        assert !test.created_by_user?
        assert !test.created_by_staff?

        test = KayakoClient::KnowledgebaseArticle.new(
            :creator_type => KayakoClient::KnowledgebaseArticle::CREATOR_USER
        )

        assert test.created_by_user?

        test = KayakoClient::KnowledgebaseArticle.new(
            :creator_type => KayakoClient::KnowledgebaseArticle::CREATOR_STAFF
        )

        assert test.created_by_staff?
    end

    def test_article
        test = KayakoClient::KnowledgebaseArticle.new(
            :kbarticleid => 1,
            :categories => [ 0 ]
        )

        assert test.respond_to?(:id)
        assert_equal test.id, test.kb_article_id

        assert_raise ArgumentError do
            KayakoClient::KnowledgebaseArticle.all(1, 2)
        end

        assert test.in_root_category?
    end

    def test_article_api
        assert_raise ArgumentError do
            KayakoClient::KnowledgebaseAttachment.all
        end

        assert_raise ArgumentError do
            KayakoClient::KnowledgebaseAttachment.all(0)
        end

        assert_raise ArgumentError do
            KayakoClient::KnowledgebaseAttachment.get(1)
        end

        assert_raise ArgumentError do
            KayakoClient::KnowledgebaseAttachment.delete(1)
        end

        test = KayakoClient::KnowledgebaseAttachment.new(
            :id => 1
        )
        test.loaded!

        assert_raise RuntimeError do
            test.delete
        end
    end

    def test_attachment
        test = KayakoClient::KnowledgebaseAttachment.new

        assert_raise NotImplementedError do
            test.put
        end

        assert test.respond_to?(:file)
        assert test.respond_to?(:file=)
    end

    def test_category
        test = KayakoClient::KnowledgebaseCategory.new(
            :parent_kb_category_id => 0,
            :user_visibility_custom => true,
            :usergroupidlist => [ 1 ],
            :staff_visibility_custom => true,
            :staffgroupidlist => [ 1 ]
        )

        assert !test.has_parent_category?
        assert test.parent_is_root?

        assert test.visible_to_user_group?(1)
        assert test.visible_to_staff_group?(1)

        assert !test.visible_to_user_group?(2)
        assert !test.visible_to_staff_group?(2)
    end

    def test_comment
        test = KayakoClient::KnowledgebaseComment.new(
            :parent_comment_id => 1
        )

        assert test.respond_to?(:creator=)

        staff = KayakoClient::Staff.new(
            :id => 1,
            :full_name => 'Test Test',
            :email => 'test@test.com'
        )

        test.creator = staff

        assert_equal test.creator_type, KayakoClient::KnowledgebaseComment::CREATOR_STAFF
        assert_equal test.creator_id, 1
        assert_equal test.full_name, 'Test Test'
        assert_equal test.email, 'test@test.com'

        user = KayakoClient::User.new(
            :id => 2,
            :full_name => 'Test2 Test2',
            :emails => [ 'test2@test2.com' ]
        )

        test.creator = user

        assert_equal test.creator_type, KayakoClient::KnowledgebaseComment::CREATOR_USER
        assert_equal test.creator_id, 2
        assert_equal test.full_name, 'Test2 Test2'
        assert_equal test.email, 'test2@test2.com'

        assert test.has_parent_comment?
    end

end
