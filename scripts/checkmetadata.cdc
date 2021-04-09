import ExampleNFT from 0x179b6b1cb6755e31

pub fun main() : {String : String} {
    let nftOwner = getAccount(0x179b6b1cb6755e31)
    log("NFT Owner")    
     let capability = nftOwner.getCapability<&{ExampleNFT.NFTReceiver}>(/public/NFTReceiver1)

     let receiverRef = capability.borrow()
         ?? panic("Could not borrow the receiver reference")

    return receiverRef.getMetadata(id: 6)
}
 