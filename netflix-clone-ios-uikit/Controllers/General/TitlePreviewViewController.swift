//
//  TitlePreviewViewController.swift
//  netflix-clone-ios-uikit
//
//  Created by Samet Koyuncu on 16.10.2022.
//

import UIKit
import WebKit

class TitlePreviewViewController: UIViewController {
    
    enum DownloadButtonType {
        case download
        case remove
    }
    // bu alttaki ikisi buraya yakışmadı gibi ::)
    private var titleModel: Title?
    
    private var buttonType: DownloadButtonType = .download
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    private let downloadButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        button.setTitle("Download", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds  = true
        
        return button
    }()
    
    private let webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(webView)
        view.addSubview(titleLabel)
        view.addSubview(overviewLabel)
        view.addSubview(downloadButton)
        
        view.backgroundColor = .systemBackground
        
        navigationController?.navigationBar.tintColor = .white
        
        configureConstraints()
        
        downloadButton.addTarget(self, action: #selector(downloadButtonTapped(_:)), for: .touchUpInside)
        
        // when add to core data, reload button ui
        NotificationCenter.default.addObserver(forName: NSNotification.Name("downloaded"),
                                               object: nil,
                                               queue: nil) { [weak self] _ in
            guard let id = self?.titleModel?.id else {
                return
            }
            self?.checkIsDownloadedBefore(id)
        }
        
    }
    
    private func configureConstraints() {
        let webViewConstraints = [
            webView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.heightAnchor.constraint(equalToConstant: 280)
        ]
        
        let titleLabelConstraints = [
            titleLabel.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ]
        
        let overviewLabelConstraints = [
            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            overviewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            overviewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ]
        
        let downloadButtonConstraints = [
            downloadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            downloadButton.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 25),
            downloadButton.widthAnchor.constraint(equalToConstant: 140),
            downloadButton.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        NSLayoutConstraint.activate(webViewConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(overviewLabelConstraints)
        NSLayoutConstraint.activate(downloadButtonConstraints)
    }
    
    func configure(with model: TitlePreviewViewModel) {
        titleModel = model.titleModel
        
        titleLabel.text = model.title
        overviewLabel.text = model.titleOverview
        guard let url = URL(string: "https://www.youtube.com/embed/\(model.youtubeVideo.id.videoId)") else {
            return
        }
        print(url)
        webView.load(URLRequest(url: url))
        
        checkIsDownloadedBefore(model.titleModel.id)
    }
    
    private func checkIsDownloadedBefore(_ id: Int) {
        DataPersistenceManager.shared.isDownloaded(id) { [weak self] result in
            switch result {
            case .success(let isDownloaded):
                if isDownloaded {
                    self?.buttonType = .remove
                    self?.downloadButton.setTitle("Remove", for: .normal)
                } else {
                    self?.buttonType = .download
                    self?.downloadButton.setTitle("Download", for: .normal)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    @IBAction func downloadButtonTapped(_ sender: UIButton) {
            print("Button tapped!")
        // TODO: add or remove from coredata
        switch buttonType {
        case .download:
            guard let titleModel = titleModel else {
                return
            }

            DataPersistenceManager.shared.downloadTitleWith(model: titleModel) { result in
                switch result {
                case .success():
                    // reload downloads screen data
                    NotificationCenter.default.post(name: NSNotification.Name("downloaded"), object: nil)
                    // cell deki icon da burada güncellenebilir
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case .remove:
            guard let id = titleModel?.id else {
                return
            }
            
            DataPersistenceManager.shared.deleteTitleBy(id: id) { result in
                switch result {
                case .success():
                    // reload downloads screen data
                    NotificationCenter.default.post(name: NSNotification.Name("downloaded"), object: nil)
                    // cell deki icon da burada güncellenebilir
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
