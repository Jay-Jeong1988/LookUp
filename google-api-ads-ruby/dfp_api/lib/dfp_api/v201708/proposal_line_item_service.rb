# Encoding: utf-8
#
# This is auto-generated code, changes will be overwritten.
#
# Copyright:: Copyright 2017, Google Inc. All Rights Reserved.
# License:: Licensed under the Apache License, Version 2.0.
#
# Code generated by AdsCommon library 0.14.1 on 2017-08-04 16:04:45.

require 'ads_common/savon_service'
require 'dfp_api/v201708/proposal_line_item_service_registry'

module DfpApi; module V201708; module ProposalLineItemService
  class ProposalLineItemService < AdsCommon::SavonService
    def initialize(config, endpoint)
      namespace = 'https://www.google.com/apis/ads/publisher/v201708'
      super(config, endpoint, namespace, :v201708)
    end

    def create_proposal_line_items(*args, &block)
      return execute_action('create_proposal_line_items', args, &block)
    end

    def create_proposal_line_items_to_xml(*args)
      return get_soap_xml('create_proposal_line_items', args)
    end

    def get_proposal_line_items_by_statement(*args, &block)
      return execute_action('get_proposal_line_items_by_statement', args, &block)
    end

    def get_proposal_line_items_by_statement_to_xml(*args)
      return get_soap_xml('get_proposal_line_items_by_statement', args)
    end

    def perform_proposal_line_item_action(*args, &block)
      return execute_action('perform_proposal_line_item_action', args, &block)
    end

    def perform_proposal_line_item_action_to_xml(*args)
      return get_soap_xml('perform_proposal_line_item_action', args)
    end

    def update_proposal_line_items(*args, &block)
      return execute_action('update_proposal_line_items', args, &block)
    end

    def update_proposal_line_items_to_xml(*args)
      return get_soap_xml('update_proposal_line_items', args)
    end

    private

    def get_service_registry()
      return ProposalLineItemServiceRegistry
    end

    def get_module()
      return DfpApi::V201708::ProposalLineItemService
    end
  end
end; end; end
