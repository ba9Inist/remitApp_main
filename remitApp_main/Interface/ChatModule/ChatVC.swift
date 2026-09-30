//
//  ChatVC.swift
//  remitApp_main
//
//  Created by Егор Голубев on 17.06.2025.
//

import UIKit
import MessageKit
import InputBarAccessoryView
import SnapKit
import RealmSwift


class ChatViewController: MessagesViewController {
    
    var timer: Timer?
    let chatModel = ChatModel()
    var arrayMessage = [customMessage]()
    
    var notificationToken: NotificationToken?
    
    private let safeView: UIView = {
        let titleSafeView = UIView()
        titleSafeView.backgroundColor = .red
        return titleSafeView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(safeView)
        safeView.snp.makeConstraints {
            $0.top.equalTo(view.snp.top)
            $0.left.equalTo(view.snp.left)
            $0.right.equalTo(view.snp.right)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .white
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesDisplayDelegate = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.backgroundColor = .white
        messageInputBar.delegate = self
        messageInputBar.backgroundView.backgroundColor = .white
        loadExistingMessages()
        scrollToLastMessage(animated: true)
    }
    
    deinit {
        notificationToken?.invalidate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startPeriodicUpdate()
    }

    override func viewWillDisappear(_ animated: Bool) {
        stopPeriodicUpdate()
        super.viewWillDisappear(animated)
    }

    private func startPeriodicUpdate() {
        timer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { [weak self] _ in
            self?.sendNewMessage(text: "")
        }
    }

    private func stopPeriodicUpdate() {
        timer?.invalidate()
        timer = nil
    }
    
    private func loadExistingMessages() {
        arrayMessage = chatModel.fetchChat()
        messagesCollectionView.reloadData()
    }
    
    private func sendNewMessage(text: String) {
        chatModel.jobChatHttp(textMessage: text) { success in
            if success {
                DispatchQueue.main.async {
                    self.loadExistingMessages()
                    self.scrollToLastMessage(animated: true)
                }
            }
        }
    }
    
    private func scrollToLastMessage(animated: Bool) {
        guard !arrayMessage.isEmpty else { return }
        let lastIndexPath = IndexPath(item: arrayMessage.count - 1, section: 0)
        messagesCollectionView.scrollToItem(at: lastIndexPath, at: .bottom, animated: animated)
    }
    
    private func reloadData() {
        messagesCollectionView.reloadData()
        scrollToLastMessage(animated: true)
    }
}

// MARK: - MessagesDataSource
extension ChatViewController: MessagesDataSource {
    var currentSender: SenderType {
        return Sender(senderId: "me", displayName: "me")
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return Message(chatObject: arrayMessage[indexPath.row])
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return 1
    }
    
    func numberOfItems(inSection section: Int, in messagesCollectionView: MessagesCollectionView) -> Int {
        return arrayMessage.count
    }
}

// MARK: - MessagesDisplayDelegate
extension ChatViewController: MessagesDisplayDelegate {
    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        if isFromCurrentSender(message: message) {
            return .red
        } else {
            return .lightGray
        }
    }
    
    func shouldDisplayHeader(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> Bool {
        return false
    }
    
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        avatarView.backgroundColor = .systemGray
        avatarView.contentMode = .scaleAspectFill
        if isFromCurrentSender(message: message) {
            let image = chatModel.fetchUserPhohto()
            let avatar = Avatar(image: image, initials: "U")
            avatarView.set(avatar: avatar)
        } else {
            let avatar = Avatar(initials: "R")
            avatarView.set(avatar: avatar)
            avatarView.backgroundColor = .red
        }
    }
}

// MARK: - InputBarAccessoryViewDelegate
extension ChatViewController: InputBarAccessoryViewDelegate {
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        sendNewMessage(text: text)
        inputBar.inputTextView.text = ""
    }
}
// MARK: - MessagesLayoutDelegate
extension ChatViewController: MessagesLayoutDelegate {}
