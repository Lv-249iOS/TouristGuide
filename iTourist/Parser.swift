//
//  Parser.swift
//  iTourist
//
//  Created by Kristina Del Rio Albrechet on 8/1/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import Foundation

protocol Parser {
    func parse(with url: URL, completion: @escaping (Any?, Error?)->())
}
