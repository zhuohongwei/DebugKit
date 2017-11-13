//
//  UIView+DebugKit.swift
//  DebugKit
//
//  Created by Hong Wei Zhuo on 11/11/17.
//  Copyright © 2017 Zhuo Hong Wei. All rights reserved.
//

import UIKit

var outlineLayerKey: Int = 0
var layoutMarginsLayerKey: Int = 0
var colorLayerKey: Int = 0
var safeAreaLayerKey: Int = 0
var adjustedContentInsetLayerKey: Int = 0
var contentInsetLayerKey: Int = 0

extension UIView {
    
    public func inspectWithLongPress() {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(showMenu(sender:)))
        longPressGesture.minimumPressDuration = 1.5
        addGestureRecognizer(longPressGesture)
    }
    
    public func inspectWithTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showMenu(sender:)))
        tapGesture.numberOfTapsRequired = 1
        addGestureRecognizer(tapGesture)
    }
    
    private func viewAtPoint(point: CGPoint) -> UIView {
        for view in subviews {
            if view.frame.contains(point) {
                return view.viewAtPoint(point: view.convert(point, from: self))
            }
        }
        return self
    }
    
    @objc private func showMenu(sender: UITapGestureRecognizer) {
    
        let view: UIView = viewAtPoint(point: sender.location(in: self))
        
        let ac = UIAlertController(title: "Inspector", message: nil, preferredStyle: .actionSheet)
        
        if let _ = view.keyedLayer(key: &outlineLayerKey) {
            ac.addAction(UIAlertAction(title: "Outline \u{2714}", style: .default, handler: { _ in
                view.hideOutline()
            }))
            
        } else {
            ac.addAction(UIAlertAction(title: "Outline", style: .default, handler: { _ in
                view.outline()
            }))
        }
        
        if let _ = view.keyedLayer(key: &layoutMarginsLayerKey) {
            ac.addAction(UIAlertAction(title: "Show Layout Margins \u{2714}", style: .default, handler: { _ in
                view.hideLayoutMargins()
            }))
            
        } else {
            ac.addAction(UIAlertAction(title: "Show Layout Margins", style: .default, handler: { _ in
                view.showLayoutMargins()
            }))
        }
        
        if let _ = view as? UIScrollView {
            
            if let _ = view.keyedLayer(key: &adjustedContentInsetLayerKey), #available(iOS 11.0, *) {
                ac.addAction(UIAlertAction(title: "Show Adjusted Content Inset \u{2714}", style: .default, handler: { _ in
                    view.hideAdjustedContentInset()
                }))
                
            } else if #available(iOS 11.0, *) {
                ac.addAction(UIAlertAction(title: "Show Adjusted Content Inset", style: .default, handler: { _ in
                    view.showAdjustedContentInset()
                }))
            }
            
            if let _ = view.keyedLayer(key: &contentInsetLayerKey) {
                ac.addAction(UIAlertAction(title: "Show Content Inset \u{2714}", style: .default, handler: { _ in
                    view.hideContentInset()
                }))
                
            } else {
                ac.addAction(UIAlertAction(title: "Show Content Inset", style: .default, handler: { _ in
                    view.showContentInset()
                }))
            }
        }
        
        if let _ = view.keyedLayer(key: &safeAreaLayerKey), #available(iOS 11.0, *) {
            ac.addAction(UIAlertAction(title: "Show Safe Area \u{2714}", style: .default, handler: { _ in
                view.hideSafeArea()
            }))
            
        } else if #available(iOS 11.0, *) {
            ac.addAction(UIAlertAction(title: "Show Safe Area", style: .default, handler: { _ in
                view.showSafeArea()
            }))
        }
        
        if let _ = view.keyedLayer(key: &colorLayerKey) {
            ac.addAction(UIAlertAction(title: "Color \u{2714}", style: .default, handler: { _ in
                view.decolorViews()
            }))
            
        } else {
            ac.addAction(UIAlertAction(title: "Color", style: .default, handler: { _ in
                view.colorViews(r: 0, g: 1, b: 0, alpha: 0.2)
            }))
        }
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        if let rootVC = UIApplication.shared.keyWindow?.rootViewController {
            rootVC.present(ac, animated: true, completion: nil)
        }
    
    }
    
    private func outline() {
        
        hideOutline()
        
        let subLayer = createLayerWithKey(&outlineLayerKey)
        
        subLayer.borderWidth = 1
        subLayer.borderColor = UIColor.black.cgColor
        
        for view in subviews {
            view.outline()
        }

    }
    
    private func hideOutline() {
        
        deleteLayerWithKey(&outlineLayerKey)
        
        for view in subviews {
            view.hideOutline()
        }
        
    }
    
    private func showLayoutMargins() {
        let subLayer = createLayerWithKey(&layoutMarginsLayerKey, insets: layoutMargins)
        subLayer.borderWidth = 1
        subLayer.borderColor = UIColor.blue.cgColor
    }
    
    private func hideLayoutMargins() {
        deleteLayerWithKey(&layoutMarginsLayerKey)
    }
    
    private func colorViews(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat) {
        decolorViews()
        
        let subLayer = createLayerWithKey(&colorLayerKey)
        subLayer.backgroundColor = UIColor(red: r, green: g, blue: b, alpha: alpha).cgColor
        
        for view in subviews {
            view.colorViews(r: r, g: g, b: b, alpha: alpha)
        }
    }
    
    private func decolorViews() {
        deleteLayerWithKey(&colorLayerKey)
        
        for view in subviews {
            view.decolorViews()
        }
    }
    
    private func showSafeArea() {
        guard #available(iOS 11.0, *) else { return }
        let subLayer = createLayerWithKey(&safeAreaLayerKey, insets: safeAreaInsets)
        subLayer.borderWidth = 1
        subLayer.borderColor = UIColor.red.cgColor
    }
    
    private func hideSafeArea() {
        deleteLayerWithKey(&safeAreaLayerKey)
    }
    
    private func showAdjustedContentInset() {
        guard #available(iOS 11.0, *) else { return }
        guard let scrollView = self as? UIScrollView else { return }
        let subLayer = createLayerWithKey(&adjustedContentInsetLayerKey, insets: scrollView.adjustedContentInset)
        subLayer.borderWidth = 1
        subLayer.borderColor = UIColor.orange.cgColor
    }
    
    private func hideAdjustedContentInset() {
       deleteLayerWithKey(&adjustedContentInsetLayerKey)
    }
    
    private func showContentInset() {
        guard let scrollView = self as? UIScrollView else { return }
        let subLayer = createLayerWithKey(&contentInsetLayerKey, insets: scrollView.contentInset)
        subLayer.borderWidth = 1
        subLayer.borderColor = UIColor.purple.cgColor
    }
    
    private func hideContentInset() {
        deleteLayerWithKey(&contentInsetLayerKey)
    }
    
    private func createLayerWithKey(_ key: UnsafeRawPointer, insets: UIEdgeInsets = .zero) -> CALayer {
        let subLayer = CALayer()
        layer.addSublayer(subLayer)
        setKeyedLayer(layer: subLayer, key: key)
        
        subLayer.frame =
            layer.bounds
                .divided(atDistance: insets.left, from: .minXEdge).remainder
                .divided(atDistance: insets.right, from: .maxXEdge).remainder
                .divided(atDistance: insets.top, from: .minYEdge).remainder
                .divided(atDistance: insets.bottom, from: .maxYEdge).remainder
        
        return subLayer
    }
    
    private func deleteLayerWithKey(_ key: UnsafeRawPointer) {
        guard let subLayer = keyedLayer(key: key) else { return }
        setKeyedLayer(layer: nil, key: key)
        subLayer.removeFromSuperlayer()
    }
    
    private func keyedLayer(key: UnsafeRawPointer) -> CALayer? {
        return objc_getAssociatedObject(self, key) as? CALayer
    }
    
    private func setKeyedLayer(layer: CALayer?, key: UnsafeRawPointer) {
        objc_setAssociatedObject(self, key, layer, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
}

