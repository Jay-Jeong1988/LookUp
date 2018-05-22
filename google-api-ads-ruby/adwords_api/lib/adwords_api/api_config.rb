# Encoding: utf-8
#
# Copyright:: Copyright 2010, Google Inc. All Rights Reserved.
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
# Helper methods for loading and managing the available services in the AdWords
# API.

require 'ads_common/api_config'

require 'adwords_api/version'

module AdwordsApi

  # Contains helper methods for loading and managing the available services.
  module ApiConfig

    # Inherit from AdsCommon::ApiConfig
    class << ApiConfig
      include AdsCommon::ApiConfig
    end

    # Set defaults
    DEFAULT_VERSION = :v201802
    LATEST_VERSION = :v201802

    # Set other constants
    API_NAME = 'AdwordsApi'
    DEFAULT_CONFIG_FILENAME = 'adwords_api.yml'

    # Configure the services available to each version
    @@service_config = {
      :v201710 => [
          :AccountLabelService,
          :AdCustomizerFeedService,
          :AdGroupAdService,
          :AdGroupBidModifierService,
          :AdGroupCriterionService,
          :AdGroupExtensionSettingService,
          :AdGroupFeedService,
          :AdGroupService,
          :AdParamService,
          :AdwordsUserListService,
          :BatchJobService,
          :BiddingStrategyService,
          :BudgetOrderService,
          :BudgetService,
          :CampaignBidModifierService,
          :CampaignCriterionService,
          :CampaignExtensionSettingService,
          :CampaignFeedService,
          :CampaignGroupService,
          :CampaignGroupPerformanceTargetService,
          :CampaignService,
          :CampaignSharedSetService,
          :ConstantDataService,
          :ConversionTrackerService,
          :CustomerExtensionSettingService,
          :CustomerFeedService,
          :CustomerNegativeCriterionService,
          :CustomerService,
          :CustomerSyncService,
          :DataService,
          :DraftAsyncErrorService,
          :DraftService,
          :FeedItemService,
          :FeedMappingService,
          :FeedService,
          :LabelService,
          :LocationCriterionService,
          :ManagedCustomerService,
          :MediaService,
          :OfflineCallConversionFeedService,
          :OfflineConversionFeedService,
          :OfflineDataUploadService,
          :ReportDefinitionService,
          :SharedCriterionService,
          :SharedSetService,
          :TargetingIdeaService,
          :TrafficEstimatorService,
          :TrialAsyncErrorService,
          :TrialService
      ],
      :v201802 => [
          :AccountLabelService,
          :AdCustomizerFeedService,
          :AdGroupAdService,
          :AdGroupBidModifierService,
          :AdGroupCriterionService,
          :AdGroupExtensionSettingService,
          :AdGroupFeedService,
          :AdGroupService,
          :AdParamService,
          :AdwordsUserListService,
          :BatchJobService,
          :BiddingStrategyService,
          :BudgetOrderService,
          :BudgetService,
          :CampaignBidModifierService,
          :CampaignCriterionService,
          :CampaignExtensionSettingService,
          :CampaignFeedService,
          :CampaignGroupService,
          :CampaignGroupPerformanceTargetService,
          :CampaignService,
          :CampaignSharedSetService,
          :ConstantDataService,
          :ConversionTrackerService,
          :CustomerExtensionSettingService,
          :CustomerFeedService,
          :CustomerNegativeCriterionService,
          :CustomerService,
          :CustomerSyncService,
          :DataService,
          :DraftAsyncErrorService,
          :DraftService,
          :FeedItemService,
          :FeedItemTargetService,
          :FeedMappingService,
          :FeedService,
          :LabelService,
          :LocationCriterionService,
          :ManagedCustomerService,
          :MediaService,
          :OfflineCallConversionFeedService,
          :OfflineConversionFeedService,
          :OfflineDataUploadService,
          :ReportDefinitionService,
          :SharedCriterionService,
          :SharedSetService,
          :TargetingIdeaService,
          :TrafficEstimatorService,
          :TrialAsyncErrorService,
          :TrialService
      ]
    }

    # Configure the base URL for each version and scope.
    @@config = {
      :oauth_scope => 'https://www.googleapis.com/auth/adwords',
      :header_ns => 'https://adwords.google.com/api/adwords/cm/',
      :v201710 => 'https://adwords.google.com/api/adwords/',
      :v201802 => 'https://adwords.google.com/api/adwords/'
    }

    # Configure the subdirectories for each version / service pair.
    # A missing pair means that only the base URL is used.
    @@subdir_config = {
      # v201710
      [:v201710, :AccountLabelService] => 'mcm/',
      [:v201710, :AdCustomizerFeedService] => 'cm/',
      [:v201710, :AdGroupAdService] => 'cm/',
      [:v201710, :AdGroupBidModifierService] => 'cm/',
      [:v201710, :AdGroupCriterionService] => 'cm/',
      [:v201710, :AdGroupExtensionSettingService] => 'cm/',
      [:v201710, :AdGroupFeedService] => 'cm/',
      [:v201710, :AdGroupService] => 'cm/',
      [:v201710, :AdParamService] => 'cm/',
      [:v201710, :AdwordsUserListService] => 'rm/',
      [:v201710, :BatchJobService] => 'cm/',
      [:v201710, :BiddingStrategyService] => 'cm/',
      [:v201710, :BudgetOrderService] => 'billing/',
      [:v201710, :BudgetService] => 'cm/',
      [:v201710, :CampaignBidModifierService] => 'cm/',
      [:v201710, :CampaignCriterionService] => 'cm/',
      [:v201710, :CampaignExtensionSettingService] => 'cm/',
      [:v201710, :CampaignFeedService] => 'cm/',
      [:v201710, :CampaignGroupService] => 'cm/',
      [:v201710, :CampaignGroupPerformanceTargetService] => 'cm/',
      [:v201710, :CampaignService] => 'cm/',
      [:v201710, :CampaignSharedSetService] => 'cm/',
      [:v201710, :ConstantDataService] => 'cm/',
      [:v201710, :ConversionTrackerService] => 'cm/',
      [:v201710, :CustomerExtensionSettingService] => 'cm/',
      [:v201710, :CustomerFeedService] => 'cm/',
      [:v201710, :CustomerNegativeCriterionService] => 'cm/',
      [:v201710, :CustomerService] => 'mcm/',
      [:v201710, :CustomerSyncService] => 'ch/',
      [:v201710, :DraftAsyncErrorService] => 'cm/',
      [:v201710, :DataService] => 'cm/',
      [:v201710, :DraftService] => 'cm/',
      [:v201710, :FeedItemService] => 'cm/',
      [:v201710, :FeedMappingService] => 'cm/',
      [:v201710, :FeedService] => 'cm/',
      [:v201710, :LabelService] => 'cm/',
      [:v201710, :LocationCriterionService] => 'cm/',
      [:v201710, :ManagedCustomerService] => 'mcm/',
      [:v201710, :MediaService] => 'cm/',
      [:v201710, :OfflineCallConversionFeedService] => 'cm/',
      [:v201710, :OfflineConversionFeedService] => 'cm/',
      [:v201710, :OfflineDataUploadService] => 'rm/',
      [:v201710, :ReportDefinitionService] => 'cm/',
      [:v201710, :SharedCriterionService] => 'cm/',
      [:v201710, :SharedSetService] => 'cm/',
      [:v201710, :TargetingIdeaService] => 'o/',
      [:v201710, :TrafficEstimatorService] => 'o/',
      [:v201710, :TrialAsyncErrorService] => 'cm/',
      [:v201710, :TrialService] => 'cm/',
      # v201802
      [:v201802, :AccountLabelService] => 'mcm/',
      [:v201802, :AdCustomizerFeedService] => 'cm/',
      [:v201802, :AdGroupAdService] => 'cm/',
      [:v201802, :AdGroupBidModifierService] => 'cm/',
      [:v201802, :AdGroupCriterionService] => 'cm/',
      [:v201802, :AdGroupExtensionSettingService] => 'cm/',
      [:v201802, :AdGroupFeedService] => 'cm/',
      [:v201802, :AdGroupService] => 'cm/',
      [:v201802, :AdParamService] => 'cm/',
      [:v201802, :AdwordsUserListService] => 'rm/',
      [:v201802, :BatchJobService] => 'cm/',
      [:v201802, :BiddingStrategyService] => 'cm/',
      [:v201802, :BudgetOrderService] => 'billing/',
      [:v201802, :BudgetService] => 'cm/',
      [:v201802, :CampaignBidModifierService] => 'cm/',
      [:v201802, :CampaignCriterionService] => 'cm/',
      [:v201802, :CampaignExtensionSettingService] => 'cm/',
      [:v201802, :CampaignFeedService] => 'cm/',
      [:v201802, :CampaignGroupService] => 'cm/',
      [:v201802, :CampaignGroupPerformanceTargetService] => 'cm/',
      [:v201802, :CampaignService] => 'cm/',
      [:v201802, :CampaignSharedSetService] => 'cm/',
      [:v201802, :ConstantDataService] => 'cm/',
      [:v201802, :ConversionTrackerService] => 'cm/',
      [:v201802, :CustomerExtensionSettingService] => 'cm/',
      [:v201802, :CustomerFeedService] => 'cm/',
      [:v201802, :CustomerNegativeCriterionService] => 'cm/',
      [:v201802, :CustomerService] => 'mcm/',
      [:v201802, :CustomerSyncService] => 'ch/',
      [:v201802, :DraftAsyncErrorService] => 'cm/',
      [:v201802, :DataService] => 'cm/',
      [:v201802, :DraftService] => 'cm/',
      [:v201802, :FeedItemService] => 'cm/',
      [:v201802, :FeedItemTargetService] => 'cm/',
      [:v201802, :FeedMappingService] => 'cm/',
      [:v201802, :FeedService] => 'cm/',
      [:v201802, :LabelService] => 'cm/',
      [:v201802, :LocationCriterionService] => 'cm/',
      [:v201802, :ManagedCustomerService] => 'mcm/',
      [:v201802, :MediaService] => 'cm/',
      [:v201802, :OfflineCallConversionFeedService] => 'cm/',
      [:v201802, :OfflineConversionFeedService] => 'cm/',
      [:v201802, :OfflineDataUploadService] => 'rm/',
      [:v201802, :ReportDefinitionService] => 'cm/',
      [:v201802, :SharedCriterionService] => 'cm/',
      [:v201802, :SharedSetService] => 'cm/',
      [:v201802, :TargetingIdeaService] => 'o/',
      [:v201802, :TrafficEstimatorService] => 'o/',
      [:v201802, :TrialAsyncErrorService] => 'cm/',
      [:v201802, :TrialService] => 'cm/'
    }

    public

    # Getters for constants and module variables.
    def self.default_version
      DEFAULT_VERSION
    end

    def self.latest_version
      LATEST_VERSION
    end

    def self.api_name
      API_NAME
    end

    def self.service_config
      @@service_config
    end

    def self.config(key)
      @@config[key]
    end

    def self.subdir_config
      @@subdir_config
    end

    def self.default_config_filename
      DEFAULT_CONFIG_FILENAME
    end

    def self.headers_config
      @@headers_config
    end

    # Get the download URL for Ad Hoc reports.
    #
    # Args:
    # - version: the API version (as a symbol)
    #
    # Returns:
    # - The endpoint URL (as a string)
    #
    def self.adhoc_report_download_url(version)
      base = get_wsdl_base(version)
      if base
        base += 'reportdownload/%s' % version.to_s
      end
      return base
    end
  end
end
