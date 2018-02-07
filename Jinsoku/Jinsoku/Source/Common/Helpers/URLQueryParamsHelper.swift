import Foundation

class URLQueryParamsHelper {
    /**
     Add, update, or remove a query string item from the URL
     
     :param: url   the URL
     :param: key   the key of the query string item
     :param: value the value to replace the query string item, nil will remove item
     
     :returns: the URL with the mutated query string
     */
    static func addOrUpdateQueryStringParameter(url: String, key: String, value: String?) -> String {
        if let components = NSURLComponents(string: url) {
            var queryItems = components.queryItems != nil ? components.queryItems! : [URLQueryItem]()
            for (index, item) in queryItems.enumerated() where item.name == key {
                // Match query string key and update
                if let v = value {
                    queryItems[index] = URLQueryItem(name: key, value: v)
                } else {
                    queryItems.remove(at: index)
                }
                components.queryItems = queryItems.count > 0
                    ? queryItems : nil
                return components.string!
            }
            
            // Key doesn't exist if reaches here
            if let v = value {
                // Add key to URL query string
                queryItems.append(URLQueryItem(name: key, value: v))
                components.queryItems = queryItems
                return components.string!
            }
        }
        
        return url
    }
    
    /**
     Add, update, or remove a query string parameters from the URL
     
     :param: url   the URL
     :param: values the dictionary of query string parameters to replace
     
     :returns: the URL with the mutated query string
     */
    static func addOrUpdateQueryStringParameter(url: String, values: [String: String]) -> String {
        var newUrl = url
        
        for item in values {
            newUrl = addOrUpdateQueryStringParameter(url: newUrl, key: item.0, value: item.1)
        }
        
        return newUrl
    }
    
    /**
     Removes a query string item from the URL
     
     :param: url   the URL
     :param: key   the key of the query string item
     
     :returns: the URL with the mutated query string
     */
    static func removeQueryStringParameter(url: String, key: String) -> String {
        return addOrUpdateQueryStringParameter(url: url, key: key, value: nil)
    }
    
}
