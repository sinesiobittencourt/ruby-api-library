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

require 'uri'

module KayakoClient
    module HTTPBackend

        def initialize(options = {})
            raise NotImplementedError, "not implemented"
        end

        def get(base, params = {})
            raise NotImplementedError, "not implemented"
        end

        def put(base, params = {})
            raise NotImplementedError, "not implemented"
        end

        def post(base, params = {})
            raise NotImplementedError, "not implemented"
        end

        def delete(base, params = {})
            raise NotImplementedError, "not implemented"
        end

        def response(resp)
            raise NotImplementedError, "not implemented"
        end

    end
end
