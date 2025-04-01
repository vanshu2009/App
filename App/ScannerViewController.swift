import UIKit
import AVFoundation
import GoogleGenerativeAI

class ScannerViewController: UIViewController, AVCapturePhotoCaptureDelegate {

    // MARK: - Properties
    private var captureSession: AVCaptureSession!
    private var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    private var photoOutput: AVCapturePhotoOutput!
    private var model: GenerativeModel?
    private var selectedImage: UIImage?

    private let detectButton: UIButton = {
        let button = UIButton(type: .system)
        let magnifyImage = UIImage(systemName: "magnifyingglass") // Magnifying glass image
        button.setImage(magnifyImage, for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 25
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.3
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.shadowRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let galleryButton: UIButton = {
        let button = UIButton(type: .system)
        let galleryImage = UIImage(systemName: "photo") // Gallery image
        button.setImage(galleryImage, for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 25
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.3
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.shadowRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    

    // MARK: - Initialization
    private func commonInit() {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "GEMINI_API_KEY") as? String else {
            fatalError("API Key not found in Info.plist")
        }
        model = GenerativeModel(name: "gemini-1.5-flash-latest", apiKey: apiKey)
    }

    init() {
        super.init(nibName: nil, bundle: nil)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        for subview in view.subviews {
            if let label = subview as? UILabel, label.text?.contains("Upload your photo") == true {
                label.text="Scan your plant"
            }
        }


        super.viewDidLoad()
        setupCameraSession()
        setupUI()
        setupConstraints()
        setupActions()
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !captureSession.isRunning {
            captureSession.startRunning()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if captureSession.isRunning {
            captureSession.stopRunning()
        }
    }
    
    


    // MARK: - Camera Setup
    private func setupCameraSession() {
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .photo

        guard let backCamera = AVCaptureDevice.default(for: .video),
              let input = try? AVCaptureDeviceInput(device: backCamera) else {
            showAlert(message: "Unable to access the camera")
            return
        }

        if captureSession.canAddInput(input) {
            captureSession.addInput(input)
        }

        photoOutput = AVCapturePhotoOutput()
        if captureSession.canAddOutput(photoOutput) {
            captureSession.addOutput(photoOutput)
        }

        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer.videoGravity = .resizeAspectFill
        videoPreviewLayer.frame = view.bounds
        view.layer.addSublayer(videoPreviewLayer)

        DispatchQueue.global().async {
            self.captureSession.startRunning()
        }
    }
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .white
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    // MARK: - UI Setup
    private func setupUI() {
        view.addSubview(detectButton)
        view.addSubview(galleryButton)
        view.addSubview(activityIndicator)
       
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
                   detectButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -60),
                   detectButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
                   detectButton.widthAnchor.constraint(equalToConstant: 50),
                   detectButton.heightAnchor.constraint(equalToConstant: 50),

                   galleryButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 60),
                   galleryButton.bottomAnchor.constraint(equalTo: detectButton.bottomAnchor),
                   galleryButton.widthAnchor.constraint(equalToConstant: 50),
                   galleryButton.heightAnchor.constraint(equalToConstant: 50),
                   
                   activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                   activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
               ])
    }

    private func setupActions() {
        detectButton.addTarget(self, action: #selector(detectButtonPressed(_:)), for: .touchUpInside)
        galleryButton.addTarget(self, action: #selector(galleryButtonPressed(_:)), for: .touchUpInside)
    }

    @objc private func detectButtonPressed(_ sender: UIButton) {
        animateButtonPress(sender) {
            self.capturePhoto()
        }
    }

    @objc private func galleryButtonPressed(_ sender: UIButton) {
        animateButtonPress(sender) {
            self.openGalleryPicker()
        }
    }
    
    private func animateButtonPress(_ button: UIButton, completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0.1, animations: {
            button.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }, completion: { _ in
            UIView.animate(withDuration: 0.1, animations: {
                button.transform = .identity
            }, completion: { _ in
                completion()
            })
        })
    }


    // MARK: - Capture Photo
    @objc private func capturePhoto() {
        let settings = AVCapturePhotoSettings()
        photoOutput.capturePhoto(with: settings, delegate: self)
    }

    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard error == nil, let photoData = photo.fileDataRepresentation(), let image = UIImage(data: photoData) else {
            showAlert(message: "Error capturing photo")
            return
        }

        selectedImage = image
        detectPlant(image: image)
    }
    


    // MARK: - Gallery Picker
    @objc private func openGalleryPicker() {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            showAlert(message: "Photo library not available")
            return
        }

        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        present(picker, animated: true)
    }
    
    // MARK: - Plant Detection
    private func detectPlant(image: UIImage) {
        guard let model = model else {
            showAlert(message: "AI Model not initialized")
            return
        }

        guard let resizedImage = resizeImage(image, to: CGSize(width: 512, height: 512)) else {
            showAlert(message: "Failed to resize image")
            return
        }

        let prompt = """
        Identify the plant in this image and provide detailed information. 
        Response format:

        Plant Name: <common name>
        Growth Stage: <stage from: germination, seedling, vegetative growth, dormancy, budding, propagation, maturity, flowering>
        Stage Description: <brief description of current stage>
        Plant Family: <botanical family>
        Estimated Age: <approximate age or growth phase duration>

        If the image does not contain a clear plant, return <null>
        """
 
        activityIndicator.startAnimating()
        Task {
            do {
                let response = try await model.generateContent(prompt, resizedImage)
                DispatchQueue.main.async {
                                self.activityIndicator.stopAnimating()
                                self.presentResult(response.text ?? "No response received.")
                            }
            } catch {
                DispatchQueue.main.async {
                                self.activityIndicator.stopAnimating()
                                self.showAlert(message: "Error: \(error.localizedDescription)")
                            }
            }
        }
    }

    // MARK: - Result Presentation
    private func presentResult(_ result: String) {
        let resultVC = UIViewController()
        resultVC.modalPresentationStyle = .pageSheet

        if let sheet = resultVC.sheetPresentationController {
                sheet.detents = [.medium()] // Shows modal at half of the screen
                sheet.prefersGrabberVisible = true // Adds a grabber for dragging
            }
        
        // Radial Gradient Background
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.systemGreen.cgColor, UIColor.systemTeal.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        gradientLayer.frame = resultVC.view.bounds
        resultVC.view.layer.insertSublayer(gradientLayer, at: 0)

        // Header with Icon and Title
        let headerStack = UIStackView()
        headerStack.axis = .horizontal
        headerStack.spacing = 10
        headerStack.alignment = .center
        headerStack.translatesAutoresizingMaskIntoConstraints = false

        let iconImageView = UIImageView(image: UIImage(systemName: "leaf.fill"))
        iconImageView.tintColor = .white
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true

        let titleLabel = UILabel()
        titleLabel.text = "Plant Scan Result"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textAlignment = .center

        headerStack.addArrangedSubview(iconImageView)
        headerStack.addArrangedSubview(titleLabel)
        resultVC.view.addSubview(headerStack)

        // Content Card
        let cardView = UIView()
        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = 20
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 0.3
        cardView.layer.shadowOffset = CGSize(width: 0, height: 5)
        cardView.layer.shadowRadius = 10
        cardView.alpha = 0 // Initial alpha for fade-in animation
        cardView.translatesAutoresizingMaskIntoConstraints = false
        resultVC.view.addSubview(cardView)

        // Stack View for Sections
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(stackView)

        // Extracted Information
        let components = result.split(separator: "\n").map { $0.trimmingCharacters(in: .whitespaces) }
        for line in components {
            if let separatorIndex = line.firstIndex(of: ":") {
                let title = String(line[..<separatorIndex]).trimmingCharacters(in: .whitespaces)
                let content = String(line[separatorIndex...].dropFirst()).trimmingCharacters(in: .whitespaces)

                let titleLabel = UILabel()
                titleLabel.text = title
                titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
                titleLabel.textColor = .systemGreen

                let contentLabel = UILabel()
                contentLabel.text = content
                contentLabel.font = UIFont.systemFont(ofSize: 16)
                contentLabel.textColor = .darkGray
                contentLabel.numberOfLines = 0

                let sectionStack = UIStackView(arrangedSubviews: [titleLabel, contentLabel])
                sectionStack.axis = .vertical
                sectionStack.spacing = 5

                stackView.addArrangedSubview(sectionStack)

                // Divider
                let divider = UIView()
                divider.backgroundColor = .systemGray4
                divider.heightAnchor.constraint(equalToConstant: 1).isActive = true
                stackView.addArrangedSubview(divider)
            }
        }

        // Close Button
        let closeButton = UIButton(type: .system)
        closeButton.setTitle("Close", for: .normal)
        closeButton.setTitleColor(.white, for: .normal)
        closeButton.backgroundColor = .systemRed
        closeButton.layer.cornerRadius = 10
        closeButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.addTarget(self, action: #selector(dismissModal), for: .touchUpInside)
        resultVC.view.addSubview(closeButton)

        // Constraints
        NSLayoutConstraint.activate([
            // Header Stack
            headerStack.topAnchor.constraint(equalTo: resultVC.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            headerStack.centerXAnchor.constraint(equalTo: resultVC.view.centerXAnchor),

            // Card View
            cardView.topAnchor.constraint(equalTo: headerStack.bottomAnchor, constant: 20),
            cardView.leadingAnchor.constraint(equalTo: resultVC.view.leadingAnchor, constant: 20),
            cardView.trailingAnchor.constraint(equalTo: resultVC.view.trailingAnchor, constant: -20),
            cardView.bottomAnchor.constraint(equalTo: closeButton.topAnchor, constant: -20),

            // Stack View inside Card
            stackView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -20),

            // Close Button
            closeButton.bottomAnchor.constraint(equalTo: resultVC.view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            closeButton.centerXAnchor.constraint(equalTo: resultVC.view.centerXAnchor),
            closeButton.widthAnchor.constraint(equalToConstant: 100),
            closeButton.heightAnchor.constraint(equalToConstant: 44)
        ])

        // Animations
        UIView.animate(withDuration: 0.3) {
            cardView.alpha = 1 // Fade-in animation
        }

        present(resultVC, animated: true)
    }

    @objc private func dismissModal() {
        dismiss(animated: true)
    }
    



    // MARK: - Image Resizing
    private func resizeImage(_ image: UIImage, to size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        image.draw(in: CGRect(origin: .zero, size: size))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage
    }

    // MARK: - Utility Methods
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Plant Scanner", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

extension ScannerViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let uiImage = info[.originalImage] as? UIImage {
            selectedImage = uiImage
            detectPlant(image: uiImage)
        }
        dismiss(animated: true)
    }
}
