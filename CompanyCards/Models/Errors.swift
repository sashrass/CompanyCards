//
//  NetworkErrorResponse.swift
//  CompanyCards
//
//  Created by Alexandr Rassokhin on 12.04.2023.
//

import Foundation

struct BadRequestError: Error, Decodable {
    let message: String
}

struct DecodeError: Error { }

struct AuthorizationError: Error { }

struct ServerError: Error { }

struct UnknownError: Error { }
