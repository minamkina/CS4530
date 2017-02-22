//
//  PaintingViewController.swift
//  PaintingStudio
//
//  Created by u0939404 on 2/17/17.
//  Copyright © 2017 McKay Fenn. All rights reserved.
//

import UIKit

class PaintingViewController: UIViewController {
    private var _paintingCollection: PaintingCollection? = nil
    private var _paintingIndex: Int? = nil
    
    var paintingCollection: PaintingCollection? {
        get { return _paintingCollection }
        set { _paintingCollection = newValue }
    }
    var paintingIndex: Int? {
        get { return _paintingIndex }
        set { _paintingIndex = newValue }
    }
    
    var paintView: PaintingView {
        return view as! PaintingView
    }
    
    override func loadView() {
        view = PaintingView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //paintView.textAlignment = NSTextAlignment.center
        //paintView.backgroundColor = UIColor.white
        //paintView.numberOfLines = -1
        
        let delete: UIBarButtonItem = UIBarButtonItem(title: "delete", style: .plain, target: self, action: #selector(deletePaintingSelected))
        let brush: UIBarButtonItem = UIBarButtonItem(title: "brush", style: .plain, target: self, action: #selector(brushSelected))
        super.navigationItem.rightBarButtonItems = [delete, brush]
    }
    
//    var painting: Painting? {
//        didSet {
//            // Load painting into view
//        }
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if (_paintingCollection == nil || _paintingIndex == nil) {
            return
        }
        
        // TODO: Convert between a painting object from the data model and the data structure the painting view uses to store this
        //painting(painting, toPaintView: PaintingViewController.paintView)
        //paintViewController.labelView.text = "This painting is ugly! \(painting.strokes.count) that many strokes."
        let painting: Painting = _paintingCollection!.paintingWithIndex(paintingIndex: paintingIndex!)
        paintView.painting = painting
        //labelView.text = "this is a painting"
    }
    
//    private func strokeToPolyLine(stroke: Stroke) -> PolyLine {
//        // TODO: Convert color and line characteristics
//        
//        for point: Point in stroke.points {
//            // from 0-1 to 0-view.bounds
//            let polylinePoint: CGPoint = CGPoint.zero
//            polylinePoint.x = point.x * paintingView.bounds.width
//            polylinePoint.y = point.x * paintingView.bounds.height
//        }
//    }
    
//    private func polylineToStroke(line: PolyLine) -> Stroke {
//        // get color components
//        let c = line.color
//        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0
//        c.getRed(&r, green: &g, blue: &b, alpha: nil)
//        
//        let stroke: Stroke = Stroke()
//        stroke.color = Color(r: Double(r), g: Double(g), b: Double(b))
//        
//        stroke.width = Double(line.width)
//
//        
//        return stroke
//    }
//    
//    private func pointToCGPoint(point: Point) -> CGPoint {
//        return CGPoint(x: point.x, y: point.y)
//    }
//    private func cgpointToPoint(cgpoint: CGPoint) -> Point {
//        let point: Point = Point()
//        point.x = Double(cgpoint.x)
//        point.y = Double(cgpoint.y)
//        return point
//    }
//    
//    private func paintViewtoPainting(view: PaintingView) -> Painting {
//        let paint: Painting = Painting()
//        //paint.strokes
//        
//        return paint
//    }
    
    func deletePaintingSelected() {
        NSLog("delete painting")
        _paintingCollection?.deletePaintingIndex(index: paintingIndex!)
    }
    
    func brushSelected() {
        // open brush chooser
    }
}
