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
    class StaffGroup < KayakoClient::Base

        property :id,       :integer, :readonly => true
        property :title,    :string, :required => [ :put, :post ]
        property :is_admin, :boolean, :required => :post

    end
end
