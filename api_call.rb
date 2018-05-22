selector = {
    idea_type: 'KEYWORD',
    request_type: 'IDEAS'
}

selector[:requested_attribute_types] = [
    'KEYWORD_TEXT',
    'SEARCH_VOLUME',
    'AVERAGE_CPC',
    'COMPETITION',
    'CATEGORY_PRODUCTS_AND_SERVICES',
]

selector[:paging] = {
    start_index: 0,
    number_results: 10
}

search_parameters = []
search_parameters << {
    xsi_type: 'RelatedToQuerySearchParameter',
    queries: ['darkness']
}

begin
    page= targeting_idea_srv.get(selector)
    results += page[:entries] if page and page[:entries]

    offset += PAGE_SIZE
    selector[:paging][:start_index] = offset
    
end while offset < page[:total_num_entries]



results.each do |result|
    data = result[:data]
    keyword = data['KEYWORD_TEXT'][:value]
    average_cpc = data['AVERAGE_CPC'][:value]
    competition = data['COMPETITION'][:value]
    products_and_services = data['CATEGORY_PRODUCTS_AND_SERVICES'][:value]
    average_monthly_searches = data['SEARCH_VOLUME'][:value]
    puts ("Keyword with text '%s', average monthly search volume %d, " +
        "average CPC %d, and competition %.2f was found with categories: %s") %
        [
          keyword,
          average_monthly_searches,
          average_cpc[:micro_amount],
          competition,
          products_and_services
        ]
end
