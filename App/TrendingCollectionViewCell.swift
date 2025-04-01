import UIKit

protocol TrendingCollectionViewCellDelegate: AnyObject {
    func didSelectTrendingPlant(_ plant: Plant)
}

class TrendingCollectionViewCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    var trendingPlants: [Plant] = []
    weak var delegate: TrendingCollectionViewCellDelegate?

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!

    override func awakeFromNib() {
        super.awakeFromNib()
        configureCollectionView()
        configurePageControl()
        fetchTrendingPlants()
    }

    // MARK: - Configuration
    private func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0

        collectionView.collectionViewLayout = layout
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
    }

    private func configurePageControl() {
        pageControl.currentPage = 0
        pageControl.addTarget(self, action: #selector(pageControlTapped(_:)), for: .valueChanged)
    }

    private func fetchTrendingPlants() {
        let plants = DataModel.shared.getAllPlants()
        trendingPlants = DataModel.shared.trendingPlant(from: plants)

        pageControl.numberOfPages = trendingPlants.count
        collectionView.reloadData()
    }

    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trendingPlants.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "innerTrendingCell", for: indexPath) as! InnerTrendingCollectionViewCell
        let plant = trendingPlants[indexPath.row]
        cell.plantNameLabel.text = plant.name // Assuming Plant has a 'name' property
        cell.plantImageView.image = plant.image // Assuming Plant has an 'image' property
        return cell
    }

    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedPlant = trendingPlants[indexPath.row]
        delegate?.didSelectTrendingPlant(selectedPlant)
    }

    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }

    // MARK: - UIScrollViewDelegate
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentPage = Int(scrollView.contentOffset.x / scrollView.frame.width)
        pageControl.currentPage = currentPage
    }

    // MARK: - Page Control Action
    @objc private func pageControlTapped(_ sender: UIPageControl) {
        let page = sender.currentPage
        let indexPath = IndexPath(item: page, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}
