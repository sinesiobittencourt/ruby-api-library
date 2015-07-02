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

require 'rake'

Gem::Specification.new do |s|
    s.name        = 'KayakoClient'
    s.version     = '1.2.1'
    s.platform    = Gem::Platform::RUBY
    s.license     = 'FreeBSD'

    s.author      = 'Andriy Lesyuk'
    s.email       = 'jamie.edwards+rubygems@kayako.com'

    s.summary     = 'Kayako official Ruby REST API library.'
    s.description = 'Kayako\'s official Ruby interface library for the REST API.'
    s.homepage    = 'https://github.com/kayako/ruby-api-library'

    s.files       = FileList['lib/**/*.rb']
    s.test_files  = FileList['test/*.rb']
end
