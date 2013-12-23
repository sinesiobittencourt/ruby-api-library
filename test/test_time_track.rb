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

class TestTimeTrack < Test::Unit::TestCase

    def test_time_track_methods
        test = KayakoClient::TicketTimeTrack.new

        assert_raise NotImplementedError do
            test.put
        end
    end

    def test_time_track_ticket_api
        assert KayakoClient::TicketTimeTrack.included_modules.include?(KayakoClient::TicketAPI)

        assert_raise ArgumentError do
            KayakoClient::TicketTimeTrack.all
        end

        assert_raise ArgumentError do
            KayakoClient::TicketTimeTrack.get(1)
        end

        assert_raise ArgumentError do
            KayakoClient::TicketTimeTrack.delete(1)
        end
    end

    def test_time_track_associates
        test = KayakoClient::TicketTimeTrack.new(
            :ticket_id => 0,
            :worker_staff_id => 0,
            :creator_staff_id => 0
        )

        assert test.respond_to?(:ticket)
        assert test.respond_to?(:worker_staff)
        assert test.respond_to?(:creator_staff)

        assert_nil test.ticket
        assert_nil test.worker_staff
        assert_nil test.creator_staff
    end

    def test_time_track_note_colors
        assert KayakoClient::TicketTimeTrack.options[:note_color][:range].include?(KayakoClient::TicketNote::COLOR_YELLOW)
        assert KayakoClient::TicketTimeTrack.options[:note_color][:range].include?(KayakoClient::TicketNote::COLOR_PURPLE)
        assert KayakoClient::TicketTimeTrack.options[:note_color][:range].include?(KayakoClient::TicketNote::COLOR_BLUE)
        assert KayakoClient::TicketTimeTrack.options[:note_color][:range].include?(KayakoClient::TicketNote::COLOR_GREEN)
        assert KayakoClient::TicketTimeTrack.options[:note_color][:range].include?(KayakoClient::TicketNote::COLOR_RED)
    end

end
