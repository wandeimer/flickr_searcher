class FlickrAPI{
  String http = 'https://www.flickor.com/services/rest/?';
  String apiKey = '3d6ad5bf6ffac3b56f343f8611a98906';
  int perPage = 40;
  Map<String, String> mediaType = {
    'all' : 'all',
    'photos' : 'photos',
    'videos' : 'videos'
  };
  Map<String, String> requestsMap = {
    'search':'flickr.photos.search',
  };
  String search(String method, String requestText, int page){
    String searchLink = '$http'
        'method=${requestsMap[method]}'
        '&api_key=$apiKey'
        '&text=$requestText'
        '&sort=date-posted-desc'
        '&per_page=$perPage'
        '&page=$page'
        '&media=${mediaType['photos']}'
        '&format=json&nojsoncallback=1';
    return searchLink;
  }

  String imageLink(int farm, String server, String id, String secret){
    String link = 'https://farm$farm.staticflickr.com/$server/${id}_$secret.jpg';
    return link;
  }
}