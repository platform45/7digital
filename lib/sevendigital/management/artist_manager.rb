require "peachy"

module Sevendigital

  # provides access to Artist related API methods (artist/*)
  class ArtistManager < Manager

    # calls <tt>*artist/details*</tt> API method and returns Artist with populated details
    #
    # <tt>artist_id</tt>:: artist ID
    # <tt>options</tt>:: optional hash of additional API parameters, e.g. {page_size => 50}, etc
    def get_details(artist_id, options={})
      api_response = @api_client.make_api_request("artist/details", {:artistId => artist_id}, options)
      @api_client.artist_digestor.from_xml(api_response.content.artist)
    end

    # calls *_artist/releases_* API method and returns Release array
    #
    # <tt>artist_id</tt>:: artist ID
    # <tt>options</tt>:: optional hash of additional API parameters, e.g. {page_size => 50}, etc
    def get_releases(artist_id, options={})
      api_response = @api_client.make_api_request("artist/releases", {:artistId => artist_id}, options)
      @api_client.release_digestor.list_from_xml(api_response.content.releases)
    end
      
    # calls *<tt>artist/toptracks</tt>* API method and returns Track array
    #
    # <tt>artist_id</tt>:: artist ID
    # <tt>options</tt>:: optional hash of additional API parameters, e.g. {page_size => 50}, etc
      def get_top_tracks(artist_id, options={})
      api_response = @api_client.make_api_request("artist/topTracks", {:artistId => artist_id}, options)
      @api_client.track_digestor.list_from_xml(api_response.content.tracks)
    end

    # calls *<tt>artist/similar</tt>* API method and returns Artist array
    #
    # <tt>artist_id</tt>:: artist ID
    # <tt>options</tt>:: optional hash of additional API parameters, e.g. {page_size => 50}, etc
    def get_similar(artist_id, options={})
      api_response = @api_client.make_api_request("artist/similar", {:artistId => artist_id}, options)
      @api_client.artist_digestor.list_from_xml(api_response.content.artists)
    end

    # calls *<tt>artist/byTag/top</tt>* API method and returns Artist array
    #
    # <tt>tags</tt>:: string containing comma separated list of tags
    # <tt>options</tt>:: optional hash of additional API parameters, e.g. {page_size => 50}, etc
    def get_top_by_tag(tags, options={})
      api_response = @api_client.make_api_request("artist/byTag/top", {:tags => tags}, options)
      @api_client.artist_digestor.nested_list_from_xml(api_response.content.tagged_results, :tagged_item, :tagged_results)
    end

    # calls *<tt>artist/search</tt>* API method and returns Artist arry
    #
    # <tt>query</tt>:: string containing the search query
    # <tt>options</tt>:: optional hash of additional API parameters, e.g. {page_size => 50}, etc
    def search(query, options={})
     api_response = @api_client.make_api_request("artist/search", {:q => query}, options)
     @api_client.artist_digestor.nested_list_from_xml(api_response.content.search_results, :search_result, :search_results)
    end

  end

end
