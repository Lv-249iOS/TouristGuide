//
//  RequestFormatter.swift
//  iTourist
//
//  Created by Kristina Del Rio Albrechet on 8/11/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import Foundation

class RequestFormatter {
    
    func createIdUrlRequest(with key: String) -> URLRequest? {
        guard let url = UrlFormatter().createUrlForPlacesIdsReq(with: key) else { return nil }
        return URLRequest(url: url)
    }
    
    func createPlaceRequest(with id: String) -> URLRequest? {
        guard let url = UrlFormatter().createUrlForPlaceDetailReq(with: id) else { return nil }
        return URLRequest(url: url)
    }
}
