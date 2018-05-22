require 'adwords_api'

class TargetingIdeaController < ApplicationController

    def home
        @regions = get_location_id(['canada'])
        # render json: @regions
    end


    def get
        @results = get_keyword_ideas("hello", nil)
        @regions = get_location_id(['canada'])
        # render json: @results
    end
    

    def search
        @keyword = params[:keyword]
        @results = get_keyword_ideas(@keyword, nil)
        @regions = get_location_id(['canada'])
        render :get
    end

    def set_location
        @location = get_location_id(['Canada'])
        render json: @location
    end


    def get_location_id(location_names)

        adwords = AdwordsApi::Api.new

        location_criterion_srv = adwords.service(:LocationCriterionService, :v201802)

        locale = 'en'

        selector = {
            :fields => ['Id', 'LocationName', 'CanonicalName', 'DisplayType',
                'ParentLocations', 'Reach', 'TargetingStatus'],
            :predicates => [
                # Location names must match exactly, only EQUALS and IN are supported.
                {:field => 'LocationName',
                 :operator => 'EQUALS',
                 :values => location_names},
                # Set the locale of the returned location names.
                {:field => 'Locale', :operator => 'EQUALS', :values => [locale]}
          ]
        }
        criteria = location_criterion_srv.get(selector)

        if criteria
            criteria.each do |criterion|
              # Extract all parent location names as one comma-separated string.
              parent_location = if criterion[:location][:parent_locations] and
                  !criterion[:location][:parent_locations].empty?
                else
                    'N/A'
                end
            end
            
            criteria
        else
            puts 'No criterion found'
        end
    end

    if __FILE__ == $0
        API_VERSION = :v201802
        
        begin
            lookup_location()
        
        # Authorization error.
        rescue AdsCommon::Errors::OAuth2VerificationRequired => e
            puts "Authorization credentials are not valid. Edit adwords_api.yml for " +
                "OAuth2 client ID and secret and run misc/setup_oauth2.rb example " +
                "to retrieve and store OAuth2 tokens."
            puts "See this wiki page for more details:\n\n  " +
                'https://github.com/googleads/google-api-ads-ruby/wiki/OAuth2'
        
        # HTTP errors.
        rescue AdsCommon::Errors::HttpError => e
            puts "HTTP Error: %s" % e
        
        # API errors.
        rescue AdwordsApi::Errors::ApiException => e
            puts "Message: %s" % e.message
            puts 'Errors:'
            e.errors.each_with_index do |error, index|
            puts "\tError [%d]:" % (index + 1)
            error.each do |field, value|
                puts "\t\t%s: %s" % [field, value]
            end
            end
        end
    end
    



    def get_keyword_ideas(keyword_text, ad_group_id, region='anywhere')
        # AdwordsApi::Api will read a config file from ENV['HOME']/adwords_api.yml
        # when called without parameters.
        adwords = AdwordsApi::Api.new

        # To enable logging of SOAP requests, set the log_level value to 'DEBUG' in
        # the configuration file or provide your own logger:
        # adwords.logger = Logger.new('adwords_xml.log')

        targeting_idea_srv = adwords.service(:TargetingIdeaService, :v201802)

        # Construct selector object.
        selector = {
            :idea_type => 'KEYWORD',
            :request_type => 'IDEAS'
        }
        selector[:requested_attribute_types] = [
            'KEYWORD_TEXT',
            'SEARCH_VOLUME',
            'AVERAGE_CPC',
            'COMPETITION',
            'CATEGORY_PRODUCTS_AND_SERVICES',
            'TARGETED_MONTHLY_SEARCHES'
        ]

        selector[:paging] = {
            :start_index => 0,
            :number_results => 10
        }

        search_parameters = []
        search_parameters << {
            # The 'xsi_type' field allows you to specify the xsi:type of the object
            # being created. It's only necessary when you must provide an explicit
            # type that the client library can't infer.
            :xsi_type => 'RelatedToQuerySearchParameter',
            :queries => [keyword_text]
        }

        search_parameters << {
            # Language setting (optional).
            # The ID can be found in the documentation:
            #  https://developers.google.com/adwords/api/docs/appendix/languagecodes
            # Only one LanguageSearchParameter is allowed per request.
            :xsi_type => 'LanguageSearchParameter',
            :languages => [{:id => 1000}]
        }

        search_parameters << {
            # Network search parameter (optional).
            :xsi_type => 'NetworkSearchParameter',
            :network_setting => {
            :target_google_search => true,
            :target_search_network => false,
            :target_content_network => false,
            :target_partner_search_network => false
            }
        }

        if region != 'anywhere'
            search_parameters << {
                :xsi_type => 'LocationSearchParameter',
                :locations => [{:id => 21137}]
            }
        end

        selector[:search_parameters] = search_parameters

        # Define initial values.
        offset = 0
        results = []

        begin
            # Perform request. If this loop executes too many times in quick suggestion,
            # you may get a RateExceededError. See here for more info on handling these:
            # https://developers.google.com/adwords/api/docs/guides/rate-limits
            page = targeting_idea_srv.get(selector)
            results += page[:entries] if page and page[:entries]

            # Prepare next page request.
            offset += 100
            selector[:paging][:start_index] = offset
        end while offset < page[:total_num_entries]

        results
    end

    if __FILE__ == $0
        API_VERSION = :v201802
        PAGE_SIZE = 100

        begin
            get_keyword_ideas(keyword_text, ad_group_id)

        # Authorization error.
        rescue AdsCommon::Errors::OAuth2VerificationRequired => e
            puts "Authorization credentials are not valid. Edit adwords_api.yml for " +
                "OAuth2 client ID and secret and run misc/setup_oauth2.rb example " +
                "to retrieve and store OAuth2 tokens."
            puts "See this wiki page for more details:\n\n  " +
                'https://github.com/googleads/google-api-ads-ruby/wiki/OAuth2'

        # HTTP errors.
        rescue AdsCommon::Errors::HttpError => e
            puts "HTTP Error: %s" % e

        # API errors.
        rescue AdwordsApi::Errors::ApiException => e
            puts "Message: %s" % e.message
            puts 'Errors:'
            e.errors.each_with_index do |error, index|
                puts "\tError [%d]:" % (index + 1)
                error.each do |field, value|
                    puts "\t\t%s: %s" % [field, value]
                end
            end
        end

    end

    private 

    
end
