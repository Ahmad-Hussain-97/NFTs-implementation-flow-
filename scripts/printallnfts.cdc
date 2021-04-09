// Script2.cdc

import ExampleNFT from 0x179b6b1cb6755e31


// Print the NFTs owned by accounts 0x01 and 0x02.
pub fun main() {

    // Get both public account objects
    let account1 = getAccount(0x01cf0e2f2f715450)
	let account2 = getAccount(0x179b6b1cb6755e31)

    // Find the public Receiver capability for their Collections
    let acct1Capability = account1.getCapability(/public/NFTReceiver1)
    let acct2Capability = account2.getCapability(/public/NFTReceiver)

    // borrow references from the capabilities
    let receiver1Ref = acct1Capability.borrow<&{ExampleNFT.NFTReceiver}>()
        ?? panic("Could not borrow account 1 receiver reference")
    let receiver2Ref = acct2Capability.borrow<&{ExampleNFT.NFTReceiver}>()
        ?? panic("Could not borrow account 2 receiver reference")

    // Print both collections as arrays of IDs
    log("Account 1 NFTs")
    log(receiver1Ref.getIDs())

    log("Account 2 NFTs")
    log(receiver2Ref.getIDs())
}
 