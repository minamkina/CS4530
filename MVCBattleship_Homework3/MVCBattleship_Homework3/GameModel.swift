//
//  GameModel.swift
//  MVCBattleship_Homework3
//
//  Created by u0939404 on 3/10/17.
//  Copyright © 2017 mckay fenn. All rights reserved.
//

import Foundation

protocol GameModelDelegate: class {
    func showTouchedStatus(status: String)
    func showPlayerWon(player: Int)
}

class Game {
    
    public enum Ships {
        case none
        case hit
        case miss
        case ship
    }
    
    private var currentPlayer1: Bool = false // start out with p1
    private var _winner: Int = 0 // nobody has won to start out with
    
    
    init() {
        placeShips()
        
    }
    
    ///
    /// Place ships randomly
    ///
    private func placeShips() {
        // List of Ships
        let ships = [5, 4, 3, 2]
        
        var allShipsPlaced = 0
        
        var currentShipIndex = 0
        var currentShip = ships[currentShipIndex]
        
        while allShipsPlaced < 4 {
            if (placeShip(shipLength: currentShip)) {
                //NSLog("Ship \(currentShip) placed")
                if (currentShipIndex < 3) {
                    currentShipIndex = currentShipIndex + 1
                    currentShip = ships[currentShipIndex]
                }
                allShipsPlaced = allShipsPlaced + 1
            }
        }
        
        
        
        
        // Now do it again for grid2
        
        allShipsPlaced = 0
        currentShipIndex = 0
        currentShip = ships[currentShipIndex]
        
        while allShipsPlaced < 4 {
            if (placeShip2(shipLength: currentShip)) {
                //NSLog("P2 Ship \(currentShip) placed")
                if (currentShipIndex < 3) {
                    currentShipIndex = currentShipIndex + 1
                    currentShip = ships[currentShipIndex]
                }
                allShipsPlaced = allShipsPlaced + 1
            }
        }
        
    }
    
    
    /// First try to check if the ship can be placed in that space
    /// If it can use the helper function to actually place it
    private func placeShip(shipLength: Int) -> Bool{
        
        
        let randX = Int(arc4random_uniform(10)) // column
        let randY = Int(arc4random_uniform(10)) // row
        let orientation = Int(arc4random_uniform(2))
        
        var validPlace = true
        
        if (orientation == 0)  { // Horizontal
            var xPos = randX
            for length: Int in 0 ..< shipLength {
                
                if (xPos < 10 && _p1Grid[randY][xPos] == .none) {
                    validPlace = true
                }
                else {
                    validPlace = false
                    return validPlace
                }
                
                // If all positions were valid then place the ship
                //                if (length == shipLength - 1 && validPlace) {
                //                    setShip(grid: 1, ship: shipLength, randY: randY, randX: randX, orientation: orientation)
                //                }
                
                xPos = xPos + 1
            }
            // if it got to here then it's a valid position
            
            //setShip(grid: 1, ship: shipLength, randY: randY, randX: randX, orientation: orientation)
            setShip2(grid: 1, ship: shipLength, randY: randY, randX: randX, orientation: orientation)
            
        }
        else { // Vertical
            var yPos = randY
            for length: Int in 0 ..< shipLength {
                
                if (yPos < 10 && _p1Grid[yPos][randX] == .none) {
                    validPlace = true
                }
                else {
                    validPlace = false
                    return validPlace
                }
                
                // If all positions were valid then place the ship
                //                if (length == shipLength - 1 && validPlace) {
                //                    setShip(grid: 1, ship: shipLength, randY: randY, randX: randX, orientation: orientation)
                //                }
                
                yPos = yPos + 1
            }
            //setShip(grid: 1, ship: shipLength, randY: randY, randX: randX, orientation: orientation)
            setShip2(grid: 1, ship: shipLength, randY: randY, randX: randX, orientation: orientation)
        }
        
        return validPlace
    }
    
    
    /// Same as other but for the second grid
    private func placeShip2(shipLength: Int) -> Bool{
        
        
        let randX = Int(arc4random_uniform(10)) // column
        let randY = Int(arc4random_uniform(10)) // row
        let orientation = Int(arc4random_uniform(2))
        
        var validPlace = true
        
        if (orientation == 0)  { // Horizontal
            var xPos = randX
            for length: Int in 0 ..< shipLength {
                
                if (xPos < 10 && _p2Grid[randY][xPos] == .none) {
                    validPlace = true
                }
                else {
                    validPlace = false
                    return validPlace
                }
                
                // If all positions were valid then place the ship
                //                if (length == shipLength - 1 && validPlace) {
                //                    setShip(grid: 2, ship: shipLength, randY: randY, randX: randX, orientation: orientation)
                //                }
                
                xPos = xPos + 1
            }
            //setShip(grid: 2, ship: shipLength, randY: randY, randX: randX, orientation: orientation)
            setShip2(grid: 2, ship: shipLength, randY: randY, randX: randX, orientation: orientation)
            
        }
        else { // Vertical
            var yPos = randY
            for length: Int in 0 ..< shipLength {
                
                if (yPos < 10 && _p2Grid[yPos][randX] == .none) {
                    validPlace = true
                }
                else {
                    validPlace = false
                    return validPlace
                }
                
                // If all positions were valid then place the ship
                //                if (length == shipLength - 1 && validPlace) {
                //                    setShip(grid: 2, ship: shipLength, randY: randY, randX: randX, orientation: orientation)
                //                }
                
                yPos = yPos + 1
            }
            //setShip(grid: 2, ship: shipLength, randY: randY, randX: randX, orientation: orientation)
            setShip2(grid: 2, ship: shipLength, randY: randY, randX: randX, orientation: orientation)
        }
        
        return validPlace
    }
    
    //private var p1ShipCoords: [(row: Int, col:Int)] = []
    //private var p2ShipCoords: [(row: Int, col:Int)] = []
    
    private var p1ShipCoordsDict: [Int: [(row: Int, col:Int)]] = [:]
    private var p2ShipCoordsDict: [Int: [(row: Int, col:Int)]] = [:]
    
    /// By now we now the ship can be successfully placed in this space
    /// Now this function acutally sets it there.
//    private func setShip(grid: Int, ship:Int, randY: Int, randX: Int, orientation: Int) {
//        var xPos = 0
//        var yPos = 0
//        
//        if (orientation == 0) {
//            xPos = randX
//        }
//        else {
//            yPos = randY
//        }
//        
//        
//        for length: Int in 0 ..< ship {
//            if (orientation == 0) {
//                if (grid == 1) {
//                    _p1Grid[randY][xPos] = .ship
//                    p1ShipCoords.append((row: randY, col: xPos))
//                }
//                else {
//                    _p2Grid[randY][xPos] = .ship
//                    p2ShipCoords.append((row: randY, col: xPos))
//                }
//                
//                xPos = xPos + 1
//            }
//            else {
//                
//                if (grid == 1) {
//                    _p1Grid[yPos][randX] = .ship
//                    p1ShipCoords.append((row: yPos, col: randX))
//                }
//                else {
//                    _p2Grid[yPos][randX] = .ship
//                    p2ShipCoords.append((row: yPos, col: randX))
//                }
//                
//                yPos = yPos + 1
//            }
//        }
//    }
    
    /// This one is using the dictionary coordinates
    private func setShip2(grid: Int, ship:Int, randY: Int, randX: Int, orientation: Int) {
        var xPos = 0
        var yPos = 0
        
        if (orientation == 0) {
            xPos = randX
        }
        else {
            yPos = randY
        }
        
        var ship1Coords = [(row: Int, col: Int)]()
        var ship2Coords = [(row: Int, col: Int)]()
        for length: Int in 0 ..< ship {
            if (orientation == 0) {
                if (grid == 1) {
                    _p1Grid[randY][xPos] = .ship
                    //p1ShipCoords.append((row: randY, col: xPos))
                    ship1Coords.append((row:randY, col:xPos))
                }
                else {
                    _p2Grid[randY][xPos] = .ship
                    //p2ShipCoords.append((row: randY, col: xPos))
                    ship2Coords.append((row:randY, col:xPos))
                }
                
                xPos = xPos + 1
            }
            else {
                
                if (grid == 1) {
                    _p1Grid[yPos][randX] = .ship
                    //p1ShipCoords.append((row: yPos, col: randX))
                    ship1Coords.append((row:yPos, col:randX))
                }
                else {
                    _p2Grid[yPos][randX] = .ship
                    //p2ShipCoords.append((row: yPos, col: randX))
                    ship2Coords.append((row:yPos, col:randX))
                }
                
                yPos = yPos + 1
            }
        }
        
        if (grid == 1) {
            p1ShipCoordsDict[ship] = ship1Coords
        }
        else {
            p2ShipCoordsDict[ship] = ship2Coords
        }
    }
    
    public var p1ShipsSunk = 0
    public var p2ShipsSunk = 0
    private var shipWasSunk: Bool = false
    
    private func checkShipsSunk() {
        shipWasSunk = false
        let p1Temp = p1ShipsSunk
        let p2Temp = p2ShipsSunk
        p1ShipsSunk = 0
        p2ShipsSunk = 0
        
        for (ship, coords) in p1ShipCoordsDict {
            var allHit = 0
            for coord in coords {
                if (_p1Grid[coord.row][coord.col] == .hit) {
                    allHit = allHit + 1
                }
            }
            if allHit == ship {
                NSLog("P1 \(ship) is sunk")
                p1ShipsSunk = p1ShipsSunk + 1
            }
        }
        
        for (ship, coords) in p2ShipCoordsDict {
            var allHit = 0
            for coord in coords {
                if (_p2Grid[coord.row][coord.col] == .hit) {
                    allHit = allHit + 1
                }
            }
            if allHit == ship {
                NSLog("P2 \(ship) is sunk")
                p2ShipsSunk = p2ShipsSunk + 1
            }
        }
        
        if (p1ShipsSunk > p1Temp || p2ShipsSunk > p2Temp) {
            shipWasSunk = true
        }
    }
    
    
    
    
    // ENEMY ships
    private var _p1Grid: [[Ships]] = [[.none, .none, .none, .none, .none, .none, .none, .none, .none, .none],
                                      [.none, .none, .none, .none, .none, .none, .none, .none, .none, .none],
                                      [.none, .none, .none, .none, .none, .none, .none, .none, .none, .none],
                                      [.none, .none, .none, .none, .none, .none, .none, .none, .none, .none],
                                      [.none, .none, .none, .none, .none, .none, .none, .none, .none, .none],
                                      [.none, .none, .none, .none, .none, .none, .none, .none, .none, .none],
                                      [.none, .none, .none, .none, .none, .none, .none, .none, .none, .none],
                                      [.none, .none, .none, .none, .none, .none, .none, .none, .none, .none],
                                      [.none, .none, .none, .none, .none, .none, .none, .none, .none, .none],
                                      [.none, .none, .none, .none, .none, .none, .none, .none, .none, .none],
                                      ]
    
    
    // MY ships
    private var _p2Grid: [[Ships]] = [[.none, .none, .none, .none, .none, .none, .none, .none, .none, .none],
                                      [.none, .none, .none, .none, .none, .none, .none, .none, .none, .none],
                                      [.none, .none, .none, .none, .none, .none, .none, .none, .none, .none],
                                      [.none, .none, .none, .none, .none, .none, .none, .none, .none, .none],
                                      [.none, .none, .none, .none, .none, .none, .none, .none, .none, .none],
                                      [.none, .none, .none, .none, .none, .none, .none, .none, .none, .none],
                                      [.none, .none, .none, .none, .none, .none, .none, .none, .none, .none],
                                      [.none, .none, .none, .none, .none, .none, .none, .none, .none, .none],
                                      [.none, .none, .none, .none, .none, .none, .none, .none, .none, .none],
                                      [.none, .none, .none, .none, .none, .none, .none, .none, .none, .none],
                                      ]
    
    public var currentPlayerIs1: Bool {
        return currentPlayer1
    }
    public var winner: Int {
        return _winner
    }
    
    public var p1Grid: [[Ships]] {
        return _p1Grid
    }
    
    public var p2Grid: [[Ships]] {
        return _p2Grid
    }
    
    /// For saving games
    public var dictionaryRepresentation: NSDictionary {
        // Save p1Grid
        var result: [String : [String]] = [:]
        var strings: [String] = []
        for boardRow: Int in 0 ..< (_p1Grid.count) {
            for boardCol: Int in 0 ..< (_p1Grid.count) {
                strings.append(stringFromToken(_p1Grid[boardRow][boardCol]))
            }
        }
        result["P1Grid"] = strings
        
        
        // Save p2Grid
        strings = []
        for boardRow: Int in 0 ..< (_p2Grid.count) {
            for boardCol: Int in 0 ..< (_p2Grid.count) {
                strings.append(stringFromToken(_p2Grid[boardRow][boardCol]))
            }
        }
        result["P2Grid"] = strings
        
        
        // Save p1ShipCoordinates
        strings = []
        for (ship, coords) in p1ShipCoordsDict {
            for coord in coords {
                strings.append(String(coord.row))
                strings.append(String(coord.col))
            }
        }
        result["P1ShipCoords"] = strings
        
        
        // Save p2ShipCoordinates
        strings = []
        for (ship, coords) in p2ShipCoordsDict {
            for coord in coords {
                strings.append(String(coord.row))
                strings.append(String(coord.col))
            }
        }
        result["P2ShipCoords"] = strings
        
        // Save currentPlayer
        if (currentPlayer1) {
            result["CurrentPlayer"] = ["2"]
        }
        else {
            result["CurrentPlayer"] = ["1"]
        }
        
        
        // Save ships sunk
        result["P1ShipsSunk"] = [String(p1ShipsSunk)]
        result["P2ShipsSunk"] = [String(p2ShipsSunk)]
        
        
        // Save winner
        result["Winner"] = [String(_winner)]
        
        return result as NSDictionary
    }
    
    /// For loading games
    public init(dictionary: NSDictionary) {
        // load p1Grid
        let tokens: [String] = dictionary.value(forKey: "P1Grid") as! [String]
        var i = 0
        for boardRow: Int in 0 ..< (_p1Grid.count) {
            for boardCol: Int in 0 ..< (_p1Grid.count) {
                _p1Grid[boardRow][boardCol] = tokenFromString(tokens[i])
                i = i + 1
            }
        }
        
        
        // load p2Grid
        let tokens2: [String] = dictionary.value(forKey: "P2Grid") as! [String]
        var j = 0
        for boardRow: Int in 0 ..< (_p2Grid.count) {
            for boardCol: Int in 0 ..< (_p2Grid.count) {
                _p2Grid[boardRow][boardCol] = tokenFromString(tokens2[j])
                j = j + 1
            }
        }
        
        
        // load p1ShipCoords
        let p1coords: [String] = dictionary.value(forKey: "P1ShipCoords") as! [String]
        loadP1ShipCoords(coords: p1coords)
        
        // load p2ShipCoords
        let p2coords: [String] = dictionary.value(forKey: "P2ShipCoords") as! [String]
        loadP2ShipCoords(coords: p2coords)
        
        
        // load currentPlayer
        let tokens3: [String] = dictionary.value(forKey: "CurrentPlayer") as! [String]
        let currPlayer = tokens3[0]
        if (currPlayer == "1") {
            currentPlayer1 = false
        }
        else {
            currentPlayer1 = true
        }
        
        
        // load ships sunk
        let p1sunk = dictionary.value(forKey: "P1ShipsSunk") as! [String]
        p1ShipsSunk = Int(p1sunk[0])!
        let p2sunk = dictionary.value(forKey: "P2ShipsSunk") as! [String]
        p2ShipsSunk = Int(p2sunk[0])!
        
        
        // load winner
        let winn = dictionary.value(forKey: "Winner") as! [String]
        _winner = Int(winn[0])!
    }
    
    private func loadP1ShipCoords(coords: [String]) {
        let listOfShips = [5, 4, 3, 2]
        var i = 0
        for ship in listOfShips {
            var ship1Coords = [(row: Int, col: Int)]()
            for length: Int in 0 ..< ship {
                ship1Coords.append((row: Int(coords[i])!, col: Int(coords[i+1])!))
                i = i + 2
            }
            p1ShipCoordsDict[ship] = ship1Coords
        }
    }
    private func loadP2ShipCoords(coords: [String]) {
        let listOfShips = [5, 4, 3, 2]
        var i = 0
        for ship in listOfShips {
            var ship2Coords = [(row: Int, col: Int)]()
            for length: Int in 0 ..< ship {
                ship2Coords.append((row: Int(coords[i])!, col: Int(coords[i+1])!))
                i = i + 2
            }
            p2ShipCoordsDict[ship] = ship2Coords
        }
    }
    
    private func stringFromToken(_ token: Ships) -> String {
        switch (token) {
        case .none : return "none"
        case .miss : return "miss"
        case .hit : return "hit"
        case .ship : return "ship"
        }
    }
    
    private func tokenFromString(_ tokenString: String) -> Ships {
        switch (tokenString) {
        case "none" : return .none
        case "miss" : return .miss
        case "hit" : return .hit
        case "ship" : return .ship
        default : return .none
        }
    }
    
    
    
    /// Return 1 if p1 wins,
    /// 2 if p2 wins
//    public func checkForWinner() {
//        // Check if p1 has hit every ship
//        var p1count = 0
//        for coord: (row: Int, col: Int) in p1ShipCoords {
//            if _p1Grid[coord.row][coord.col] == .hit {
//                p1count = p1count + 1
//            }
//        }
//        
//        // announce if p1 has won
//        if p1count == 3 { // 17 for all ships
//            for delegate: GameModelDelegate in delegates {
//                delegate.showPlayerWon(player: 1)
//                _winner = 1
//            }
//        }
//        
//        // Check if p2 has hit every ship
//        var p2count = 0
//        for coord: (row: Int, col: Int) in p2ShipCoords {
//            if _p2Grid[coord.row][coord.col] == .hit {
//                p2count = p2count + 1
//            }
//        }
//        
//        // announce if p2 has won
//        if p2count == 3 { // 17 for all ships
//            for delegate: GameModelDelegate in delegates {
//                delegate.showPlayerWon(player: 2)
//                _winner = 2
//            }
//        }
//    }
    
    /// Return 1 if p1 wins,
    /// 2 if p2 wins
    public func checkForWinner2() {
        // Check if p1 has hit every ship
        var p1count = 0
        
        for (ship, coords) in p1ShipCoordsDict {
            for coord in coords {
                if (_p1Grid[coord.row][coord.col] == .hit) {
                    p1count = p1count + 1
                }
            }
        }
        
        // announce if p1 has won
        if p1count == 14 {
            for delegate: GameModelDelegate in delegates {
                //delegate.showPlayerWon(player: 1)
                _winner = 1
            }
        }
        
        // Check if p2 has hit every ship
        var p2count = 0
        for (ship, coords) in p2ShipCoordsDict {
            for coord in coords {
                if (_p2Grid[coord.row][coord.col] == .hit) {
                    p2count = p2count + 1
                }
            }
        }
        
        // announce if p2 has won
        if p2count == 14 {
            for delegate: GameModelDelegate in delegates {
                //delegate.showPlayerWon(player: 2)
                _winner = 2
            }
        }
    }
    
    /// Check the row and col given and determine whether
    /// it was a hit or miss
    public func takeMove(row:Int, col: Int) {
        var msg: String = ""
        if (currentPlayer1) {
            if (_p2Grid[row][col] == .none) {
                _p2Grid[row][col] = .miss
                msg = "Miss!"
            }
            else if (_p2Grid[row][col] == .ship)
            {
                _p2Grid[row][col] = .hit
                msg = "Hit!"
            }
            else if (_p2Grid[row][col] == .miss || _p2Grid[row][col] == .hit) {
                msg = "try again"
            }
        }
        else {
            if (_p1Grid[row][col] == .none) {
                _p1Grid[row][col] = .miss
                msg = "Miss!"
            }
            else if (_p1Grid[row][col] == .ship)
            {
                _p1Grid[row][col] = .hit
                msg = "Hit!"
            }
            else if (_p1Grid[row][col] == .miss || _p1Grid[row][col] == .hit) {
                msg = "try again"
            }
        }
        if (msg != "try again") {
            currentPlayer1 = !currentPlayer1
            checkShipsSunk()
            checkForWinner2()
            if (shipWasSunk) {
                msg = "Hit and Sunk!"
            }
        }
        
        
        if (_winner == 0) {
            for delegate: GameModelDelegate in delegates {
                delegate.showTouchedStatus(status: msg)
            }
        }
        else {
            for delegate: GameModelDelegate in delegates {
                delegate.showPlayerWon(player: _winner)
            }
        }
    }
    
    public var delegates: [GameModelDelegate] = []
    
}
