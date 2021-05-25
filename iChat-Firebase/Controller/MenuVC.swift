//
//  MenuVC.swift
//  iChat
//
//  Created by ps on 02/02/2021.
//

import UIKit

class MenuVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var addChannelBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userImg: CircleImage!
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBOutlet weak var channelLoader: UIActivityIndicatorView!
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue){}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.channelLoader.isHidden = true
        self.addChannelBtn.isHidden = true
        tableView.delegate = self
        tableView.dataSource = self
        self.revealViewController().rearViewRevealWidth = self.view.frame.size
            .width - 60
        if AuthService.instance.isLoggedIn {
            loginBtn.setTitle(UserDataService.instance.name, for: .normal)
        }
        NotificationCenter.default.addObserver(self, selector: #selector(userDataDidChange(_:)), name: NOTIF_USER_DATA_CHANGE, object: nil)
    
        NotificationCenter.default.addObserver(self, selector: #selector(channelsDidChange(_:)), name: NOTIF_CHANNELS_LOADED, object: nil)
        
        if AuthService.instance.isLoggedIn {
            addChannelBtn.isHidden = false
            
            
            SocketService.instance.getChannel { (success) in
                if success {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func getAllChannels(){
        channelLoader.isHidden = false
        channelLoader.startAnimating()
        MessageService.instance.findAllChannels { (success) in
            self.channelLoader.isHidden = true
            self.channelLoader.stopAnimating()
            if success {
                self.tableView.reloadData()
            }else {
                print("failure findAllChannels")
            }
        }
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        setupUserInfo()
//      
//    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.channels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "channelCell", for: indexPath) as? ChannelCell {
            let channel = MessageService.instance.channels[indexPath.row]
            cell.configureCell(channel: channel)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let channel = MessageService.instance.channels[indexPath.row]
        MessageService.instance.selectedChannel = channel
        NotificationCenter.default.post(name: NOTIF_CHANNEL_SELECTED, object: nil)
        self.revealViewController()?.revealToggle(animated: true)
    }
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        if AuthService.instance.isLoggedIn {
            let profile = ProfileVC()
            profile.modalPresentationStyle = .custom
            present(profile, animated: true, completion: nil)
        } else {
            performSegue(withIdentifier: TO_LOGIN, sender: nil)
        }
    }

    @IBAction func addChannelPressed(_ sender: Any) {
        let addChannelVC = AddChannelVC()
        addChannelVC.modalPresentationStyle = .custom
        present(addChannelVC, animated: true, completion: nil)
    }
    @objc func userDataDidChange(_ notif: Notification){
        setupUserInfo()
    }
    @objc func channelsDidChange(_ notif: Notification){
        tableView.reloadData()
    }
    func setupUserInfo() {
        if AuthService.instance.isLoggedIn {
            loginBtn.setTitle(UserDataService.instance.name, for: .normal)
            userImg.image = UIImage(named: UserDataService.instance.avatarName)
            userImg.backgroundColor = UserDataService.instance.getAvatarColor()
            getAllChannels()
            addChannelBtn.isHidden = false
        }
        else {
            loginBtn.setTitle("Login", for: .normal)
            userImg.image = UIImage(named: "menuProfileIcon")
            userImg.backgroundColor = UIColor.clear
            addChannelBtn.isHidden = true
            tableView.reloadData()
        }
    }
}
