//
//  APIServiceModels.swift
//  RickAndMorty
//
//  Created by Vince Carlo Santos on 1/16/23.
//

import Foundation

/// An Error with an option to add a custom message and supply the data that caused the error as optional
struct CustomError: Error {
    var message: String
    var error: Error?
}
