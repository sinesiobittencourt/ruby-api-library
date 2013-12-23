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

require 'kayako_client/mixins/creator_api'
require 'kayako_client/mixins/comment_object'

require 'kayako_client/troubleshooter_step'

module KayakoClient
    class TroubleshooterComment < KayakoClient::Troubleshooter
        include KayakoClient::CreatorAPI
        include KayakoClient::CommentObject

        path '/Troubleshooter/Comment'

        property :troubleshooter_step_id, :integer, :required => :post

        associate :troubleshooter_step, :troubleshooter_step_id, TroubleshooterStep

    end
end
