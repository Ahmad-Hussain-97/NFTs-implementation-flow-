// Script1.cdc 

import ExampleNFT from 0x179b6b1cb6755e31

// Print the NFTs owned by account 0x179b6b1cb6755e31.
pub fun main() {
    // Get the public account object for account 0x179b6b1cb6755e31
    let nftOwner = getAccount(0x179b6b1cb6755e31)

    // Find the public Receiver capability for their Collection
    let capability = nftOwner.getCapability<&{ExampleNFT.NFTReceiver}>(/public/NFTReceiver)

    // borrow a reference from the capability
    let receiverRef = capability.borrow()
        ?? panic("Could not borrow the receiver reference")

    // Log the NFTs that they own as an array of IDs
    log("Account 2 NFTs")
    log(receiverRef.getIDs())
}
