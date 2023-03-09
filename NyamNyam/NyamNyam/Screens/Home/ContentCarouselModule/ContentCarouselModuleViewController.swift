//
//  ContentCarouselModuleViewController.swift
//  NyamNyam
//
//  Created by Noah Park on 2023/03/08.
//

import UIKit
import SnapKit

final class ContentCarouselModuleViewController: UIViewController {
    
    let viewModel: HomeViewModel
    
    private lazy var collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: view.frame.width - 60,
                                 height: view.frame.height)
        layout.minimumLineSpacing = 15.0
        layout.minimumInteritemSpacing = 0
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        else { fatalError() }
        let insetX = (scene.screen.bounds.width - collectionViewFlowLayout.itemSize.width) / 2.0
        let view = UICollectionView(frame: .zero, collectionViewLayout: self.collectionViewFlowLayout)
        view.isScrollEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = true
        view.backgroundColor = .clear
        view.clipsToBounds = true
        view.register(CarouselCell.self, forCellWithReuseIdentifier: CarouselCell.cellId)
        view.isPagingEnabled = false
        view.contentInsetAdjustmentBehavior = .never
        view.contentInset = UIEdgeInsets(top: 0, left: insetX, bottom: 0, right: insetX)
        view.decelerationRate = .fast
        return view
    }()
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionViewLayout()
        
        bind(to: viewModel)
    }
    
    private func bind(to viewModel: HomeViewModel) {
        viewModel.currentCampus.observe(on: self) { [weak self] _ in
            self?.collectionView.reloadData()
        }
        
        viewModel.indexOfDate.observe(on: self) { [weak self] _ in
            self?.collectionView.reloadData()
        }
        viewModel.indexOfCafeteria.observe(on: self) { [weak self] index in
            self?.scrollViewBy(buttonIndex: index)
        }
    }
    
    
}

extension ContentCarouselModuleViewController {
    private func setCollectionViewLayout() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CarouselCell.self, forCellWithReuseIdentifier: CarouselCell.cellId)
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
    }
}


// MARK: DataSource
extension ContentCarouselModuleViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.currentCampus.value == .seoul ? viewModel.seoulCafeteriaList.count : viewModel.ansungCafeteriaList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarouselCell.cellId, for: indexPath) as! CarouselCell
        return cell
    }
}

extension ContentCarouselModuleViewController: UICollectionViewDelegate {
    
}

extension ContentCarouselModuleViewController: UICollectionViewDelegateFlowLayout {
    func scrollViewWillEndDragging(
        _ scrollView: UIScrollView,
        withVelocity velocity: CGPoint,
        targetContentOffset: UnsafeMutablePointer<CGPoint>
    ) {
        let scrolledOffsetX = targetContentOffset.pointee.x + scrollView.contentInset.left
        let cellWidth = collectionViewFlowLayout.itemSize.width + collectionViewFlowLayout.minimumLineSpacing
        viewModel.indexOfCafeteria.value = Int(round(scrolledOffsetX / cellWidth))
        let index = viewModel.indexOfCafeteria.value
        targetContentOffset.pointee = CGPoint(x: CGFloat(index) * cellWidth - scrollView.contentInset.left, y: scrollView.contentInset.top)
    }
    
    func scrollViewBy(buttonIndex: Int) {
        let indexPath = IndexPath(item: buttonIndex, section: 0)
        self.collectionView.scrollToItem(at: indexPath, at: [.centeredVertically, .centeredHorizontally], animated: true)
    }
}
