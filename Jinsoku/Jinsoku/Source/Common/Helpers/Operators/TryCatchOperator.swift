//
//  TryCatchOperator.swift
//  elcorteinglesMock
//
//  Created by Jose Antonio Garcia Yañez on 7/2/18.
//  Copyright © 2018 El Corte Inglés. All rights reserved.
//

import Foundation

infix operator ~>

func ~> <T>(expression: @autoclosure () throws -> T, errorTransform: (Error) -> Error) throws -> T {
    do {
        return try expression()
    } catch {
        throw errorTransform(error)
    }
}
