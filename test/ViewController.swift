//
//  ViewController.swift
//  test
//
//  Created by Alexey Kuznetsov on 09.03.2021.
//

import UIKit

class ViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    private var longPressGesture: UILongPressGestureRecognizer!
    private var pictures = ImageDataSource()
    private var collectionViewFlowLayout = UICollectionViewFlowLayout()
    private let minimalSize = Int(UIScreen.main.bounds.width / 4)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewFlowLayout.minimumInteritemSpacing = 0.0
        collectionViewFlowLayout.minimumLineSpacing = 0.0
        collectionViewFlowLayout.sectionInset = UIEdgeInsets.zero
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(Cell.self, forCellWithReuseIdentifier: Cell.cellIdentifier)
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        
        longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongGesture(_:)))
        collectionView.addGestureRecognizer(longPressGesture)
    }

    @objc func handleLongGesture(_ gesture: UILongPressGestureRecognizer) {
        switch(gesture.state) {
        case UIGestureRecognizerState.began:
            guard let selectedIndexPath = collectionView.indexPathForItem(at: gesture.location(in: collectionView)) else { break }
            collectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
        case UIGestureRecognizerState.changed:
            collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
        case UIGestureRecognizerState.ended:
            collectionView.endInteractiveMovement()
        default:
            collectionView.cancelInteractiveMovement()
        }
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView (_ collectionView: UICollectionView, layout cellForRow: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let picture = pictures[indexPath.row]
        let width = CGFloat(minimalSize * picture.width)
        let height = CGFloat(minimalSize * picture.height)
        return CGSize(width: width, height: height)
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.cellIdentifier, for: indexPath)
        if let cell = cell as? Cell {
            let picture = pictures[indexPath.row]
            cell.imageView.image = picture.image
            cell.labelView.text = "\(picture.height)x\(picture.width)"
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        guard longPressGesture.state != .ended else { return }
        pictures.moveWithReorder(sourceIndexPath.item, toIndex: destinationIndexPath.item)
    }
    
}

extension UICollectionViewFlowLayout {
    
    override public func invalidationContext(forInteractivelyMovingItems targetIndexPaths: [IndexPath],
                                           withTargetPosition targetPosition: CGPoint,
                                           previousIndexPaths: [IndexPath],
                                           previousPosition: CGPoint) -> UICollectionViewLayoutInvalidationContext {
        let context = super.invalidationContext(forInteractivelyMovingItems: targetIndexPaths,
                                                withTargetPosition: targetPosition,
                                                previousIndexPaths: previousIndexPaths,
                                                previousPosition: previousPosition)
        if previousIndexPaths.first!.item != targetIndexPaths.first!.item {
            collectionView?.dataSource?.collectionView?(collectionView!, moveItemAt: previousIndexPaths.first!, to: targetIndexPaths.last!)
        }
        return context
    }
    
    override public func invalidationContextForEndingInteractiveMovementOfItems(toFinalIndexPaths indexPaths: [IndexPath],
                                                                              previousIndexPaths: [IndexPath],
                                                                              movementCancelled: Bool) -> UICollectionViewLayoutInvalidationContext {
        return super.invalidationContextForEndingInteractiveMovementOfItems(toFinalIndexPaths: indexPaths,
                                                                            previousIndexPaths: previousIndexPaths,
                                                                            movementCancelled: movementCancelled)
    }
    
}


