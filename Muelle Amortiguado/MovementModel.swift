//
//  MovementModel.swift
//  Muelle Amortiguado
//
//  Created by Carlos Macias Jimenez on 05/10/15.
//  Copyright © 2015 Carlos Macias Jimenez. All rights reserved.
//

import Foundation

class MovementModel {
        
    // Masa
    var m = 5.0 {
        didSet {
            updateCtes()
        }
    }
    
    // Cte del muelle
    var k = 1500.0 {
        didSet {
            updateCtes()
        }
    }
    
    // Cte de rozamiento
    var λ = 1.0 {
        didSet {
            updateCtes()
        }
    }
    
    init() {
        updateCtes()
    }
    
    // Posición inicial de la masa
    private let x0 = 2.0
    
    // Velocidad inicial de la masa
    private let v0 = 0.0
    
    // Ctes intermedias
    private var ω0 = 1.0
    private var γ = 1.0
    private var ω = 1.0
    private var A = 1.0
    private var φ = 1.0
    
    // Función para actualizar las ctes intermedias
    private func updateCtes() {
        ω0 = sqrt(k / m)
        γ = λ / m / 2
        ω = sqrt(ω0*ω0 - γ*γ)
        A = sqrt(x0*x0 + pow((v0+γ*x0)/ω,2))
        φ = atan(x0*ω/(v0+γ*x0))
    }
    
    // Posición de la masa en el instante
    func positionAtTime (t: Double) -> Double {
            return A*exp(-γ*t)*sin(ω*t + φ)
        }
    
    // Velocidad de la masa en el instante
    func speedAtTime (t: Double) -> Double {
        let ae = A*exp(-γ*t)
        let ωtφ = ω*t+φ
        return -γ*ae*sin(ωtφ) + ω*ae*cos(ωtφ)
    }
}
