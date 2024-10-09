//
//  TableViewController.swift
//  CPSC575-Assignment3
//  Team Momenta
//  Created by
//      Rei Tsunemi        - 30121202
//      Selcuk Emir Avci   - 30125151
//  Date: 2024-10-08
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating, UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let categories = [
        "Top Cryptocurrencies": ["Bitcoin", "Ethereum", "Binance Coin", "Cardano", "Solana"],
        "DeFi Projects": ["Uniswap", "Aave", "Compound", "MakerDAO", "SushiSwap"],
        "NFT Marketplaces": ["OpenSea", "Rarible", "SuperRare", "Foundation", "Nifty Gateway"],
        "Stablecoins": ["Tether (USDT)", "USD Coin (USDC)", "Dai (DAI)", "Binance USD (BUSD)"],
        "Layer 1 Blockchains": ["Ethereum", "Cardano", "Polkadot", "Solana", "Avalanche"],
        "Layer 2 Solutions": ["Polygon", "Optimism", "Arbitrum", "Loopring"],
        "Crypto Exchanges": ["Binance", "Coinbase", "Kraken", "Gemini", "Bitstamp"],
        "Crypto Wallets": ["MetaMask", "Trust Wallet", "Ledger Nano S", "Trezor", "Exodus"],
        "Blockchain Platforms": ["Hyperledger Fabric", "Corda", "Quorum", "Stellar"],
        "Crypto News Outlets": ["CoinDesk", "Cointelegraph", "Decrypt", "The Block", "CryptoSlate"]
    ]
    
    var categoryTitles: [String] = []
    
    var filteredCategories: [String: [String]] = [:]
    var isSearching: Bool = false
    
    var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryTitles = categories.keys.sorted()
        
        // Initialize the search controller
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Cryptocurrencies"
        searchController.searchBar.delegate = self
        
        // Add the search bar to the navigation bar
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    /// Returns the number of sections in the table view
    func numberOfSections(in tableView: UITableView) -> Int {
        if isSearching {
            return filteredCategories.keys.count
        } else {
            return categories.keys.count
        }
    }
    
    /// Returns the number of rows in a given section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let currentCategories = isSearching ? Array(filteredCategories.keys.sorted()) : categoryTitles
        let categoryKey = currentCategories[section]
        let items = isSearching ? filteredCategories[categoryKey]! : categories[categoryKey]!
        return items.count
    }
    
    /// Returns the title for the header of a given section
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let currentCategories = isSearching ? Array(filteredCategories.keys.sorted()) : categoryTitles
        return currentCategories[section]
    }
    
    /// Configures and returns the cell for a given index path
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let currentCategories = isSearching ? Array(filteredCategories.keys.sorted()) : categoryTitles
        let categoryKey = currentCategories[indexPath.section]
        let items = isSearching ? filteredCategories[categoryKey]! : categories[categoryKey]!
        let itemName = items[indexPath.row]
        
        cell.textLabel?.text = itemName
        
        return cell
    }
        
    /// Updates the search results based on the search text
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text ?? ""
        filterContentForSearchText(searchText)
        tableView.reloadData()
    }
    
    /// Filters the categories and items based on the search text
    func filterContentForSearchText(_ searchText: String) {
        if searchText.isEmpty {
            isSearching = false
            filteredCategories.removeAll()
        } else {
            isSearching = true
            filteredCategories = [:]
            
            for (category, items) in categories {
                let filteredItems = items.filter { item in
                    item.lowercased().contains(searchText.lowercased())
                }
                if !filteredItems.isEmpty {
                    filteredCategories[category] = filteredItems
                }
            }
        }
    }
    
}
