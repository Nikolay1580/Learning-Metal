//
//  DataTypes.swift
//  Metals
//
//  Created by Nikolay Tsonev on 04/10/2023.
//

// this file is for creating and declaring datatypes to make code in other files cleaner

import simd

protocol sizeable {
    static func size(_ count: Int) -> Int
    static func stride(_ count: Int) -> Int
}

extension sizeable {
    static func size() -> Int {
        return MemoryLayout<Self>.size
    }
    
    static func stride() -> Int {
        return MemoryLayout<Self>.stride
    }
    
    static func size(_ count: Int) -> Int {
        return MemoryLayout<Self>.size * count
    }
    
    static func stride(_ count: Int) -> Int {
        return MemoryLayout<Self>.stride * count
    }
}

// this is like the previosuly user basic Vertex array, but now has th position of the vertex alongside a color
// color is of 4 floats. 3 for RGB and the 4th for opacity / alpha
struct Vertex : sizeable {
    var position: SIMD3<Float>
    var color: SIMD4<Float>
}

extension SIMD3<Float> :sizeable { }


