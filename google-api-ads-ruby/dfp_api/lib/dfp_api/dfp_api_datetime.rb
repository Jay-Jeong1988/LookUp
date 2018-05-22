# Encoding: utf-8
#
# Copyright:: Copyright 2017, Google Inc. All Rights Reserved.
#
# License:: Licensed under the Apache License, Version 2.0 (the "License");
#           you may not use this file except in compliance with the License.
#           You may obtain a copy of the License at
#
#           http://www.apache.org/licenses/LICENSE-2.0
#
#           Unless required by applicable law or agreed to in writing, software
#           distributed under the License is distributed on an "AS IS" BASIS,
#           WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
#           implied.
#           See the License for the specific language governing permissions and
#           limitations under the License.
#
# DfpDate and DfpDateTime convert between native ruby Date and Time objects and
# the DFP API's Date and DateTime objects.

require 'date'
require 'tzinfo'


module DfpApi
  class DfpDate
    # Create a new DfpDate, a utility class that allows for interoperability
    # between the DFP API's Date objects and ruby's Date class.
    #
    # Args:
    #   - args:
    #     - ([year, [month, [day]]]), integer values, uses Date defaults
    #     - (date), a native ruby Date object
    #     - (dfp_date), a DFP Date hash representation
    # Returns:
    #   - dfp_date: an instance of DfpDate
    def initialize(api, *args)
      @api = api
      @api.utils_reporter.dfp_date_used()

      case args.first
      when Hash
        hash = args.first
        date_args = [hash[:year], hash[:month], hash[:day]]
      when Date
        date = args.first
        date_args = [date.year, date.month, date.day]
      else
        date_args = args
      end
      @date = Date.new(*date_args)
    end

    # Creates a DfpDate object denoting the present day.
    def self.today(api, *args)
      self.new(api, Date.today(*args))
    end

    # When an unrecognized method is applied to DfpDate, pass it through to the
    # internal ruby Date.
    def method_missing(name, *args, &block)
      result = @date.send(name, *args, &block)
      return self.class.new(@api, result) if result.is_a? Date
      return result
    end

    # Convert DfpDate into a hash representation which can be consumed by
    # the DFP API. E.g., a hash that can be passed as PQL Date variables.
    #
    # Returns:
    #   - dfp_datetime: a DFP Date hash representation
    def to_h()
      return {:year => @date.year, :month => @date.month, :day => @date.day}
    end
  end

  class DfpDateTime
    attr_accessor :timezone

    # Create a new DfpDateTime, a utility class that allows for interoperability
    # between the DFP API's DateTime objects and ruby's Time class. The last
    # argument must be a valid timezone identifier, e.g. "America/New_York".
    #
    # Args:
    #   - args:
    #     - ([year, [month, [day, [hour, [minute, [second,]]]]]] timezone)
    #     - (time, timezone), a native Time object and a timezone identifier
    #     - (dfp_datetime), a DFP DateTime hash representation
    #
    # Returns:
    #   - dfp_datetime: an instance of DfpDateTime
    def initialize(api, *args)
      @api = api
      @api.utils_reporter.dfp_date_time_used()

      # Handle special cases when a DFP DateTime hash or ruby Time instance are
      # passed as the first argument to the constructor.
      case args.first
      when Hash
        hash = args.first
        datetime_args = [hash[:date][:year], hash[:date][:month],
            hash[:date][:day], hash[:hour], hash[:minute], hash[:second],
            hash[:time_zone_id]]
      when DfpDateTime, Time, DateTime
        time = args.first
        datetime_args = [args.last]
        [:sec, :min, :hour, :day, :month, :year].each do |duration|
          datetime_args.unshift(time.send(duration))
        end
      else
        datetime_args = args
      end
      # Check the validity of the timezone parameter, which is required.
      if not TZInfo::Timezone.all_identifiers.include?(datetime_args.last)
        raise "Last argument to DfpDateTime constructor must be valid timezone"
      end
      # Set timezone attribute and pass its utc offset into the Time
      # constructor.
      @timezone = TZInfo::Timezone.get(datetime_args.pop)
      @time = Time.new(*datetime_args,
          utc_offset=@timezone.current_period.utc_offset)
    end

    # Create a DfpDateTime for the current time in the specified timezone.
    #
    # Args:
    #   - timezone: a valid timezone identifier, e.g. "America/New_York"
    #
    # Returns:
    #   - dfp_datetime: an instance of DfpDateTime
    def self.now(api, timezone)
      new(api, TZInfo::Timezone.get(timezone).now, timezone)
    end

    # Create a DfpDateTime in the "UTC" timezone. Calls the DfpDateTime
    # contstructor with timezone identifier "UTC".
    #
    # Args:
    #   - ([year, [month, [day, [hour, [minute, [second]]]]]])
    #
    # Returns:
    #   - dfp_datetime: an instance of DfpDateTime
    def self.utc(api, *args)
      new(api, *args + ['UTC'])
    end

    # Convert DfpDateTime into a hash representation which can be consumed by
    # the DFP API. E.g., a hash that can be passed as PQL DateTime variables.
    #
    # Returns:
    #   - dfp_datetime_hash: a hash representation of a DfpDateTime
    def to_h
      {
        :date => DfpApi::DfpDate.new(
            @api, @time.year, @time.month, @time.day
        ).to_h,
        :hour => @time.hour,
        :minute => @time.min,
        :second => @time.sec,
        :time_zone_id => @timezone.identifier
      }
    end

    # When an unrecognized method is applied to DfpDateTime, pass it through to
    # the internal ruby Time.
    def method_missing(name, *args, &block)
      # Restrict time zone related functions from being passed to internal ruby
      # Time attribute, since DfpDateTime handles timezones its own way
      restricted_functions = [:dst?, :getgm, :getlocal, :getutc, :gmt,
          :gmtime, :gmtoff, :isdst, :localtime, :utc]
      if restricted_functions.include? name
        raise NoMethodError, 'undefined method %s for %s' % [name, self]
      end
      result = @time.send(name, *args, &block)
      if result.is_a? Time
        return self.class.new(@api, result, @timezone.identifier)
      else
        return result
      end
    end
  end
end
