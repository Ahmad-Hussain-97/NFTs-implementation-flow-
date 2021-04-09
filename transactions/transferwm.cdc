
import ExampleNFT from 0x179b6b1cb6755e31

// This transaction transfers an NFT from one user's collection
// to another user's collection.
transaction {

    // The field that will hold the NFT as it is being
    // transferred to the other account
    let transferToken: @ExampleNFT.NFT
	
    prepare(acct: AuthAccount) {

        // Borrow a reference from the stored collection
        let collectionRef = acct.borrow<&ExampleNFT.Collection>(from: /storage/NFTCollection)
            ?? panic("Could not borrow a reference to the owner's collection")

        // Call the withdraw function on the sender's Collection
        // to move the NFT out of the collection
        self.transferToken <- collectionRef.withdraw(withdrawID: 6)
    }

    execute {
        // Get the recipient's public account object
        let recipient = getAccount(0x01cf0e2f2f715450)

        // Get the Collection reference for the receiver
        // getting the public capability and borrowing a reference from it
        let receiverRef = recipient.getCapability<&{ExampleNFT.NFTReceiver}>(/public/NFTReceiver1)
            .borrow()
            ?? panic("Could not borrow receiver reference")

        // Deposit the NFT in the receivers collection
        receiverRef.deposit(token: <-self.transferToken)

        log("NFT transferred from account 2 to account 1")
    }
}
 