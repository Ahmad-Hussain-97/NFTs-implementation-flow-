
import ExampleNFT from 0x179b6b1cb6755e31
transaction {
  let receiverRef: &{ExampleNFT.NFTReceiver}
  let minterRef: &ExampleNFT.NFTMinter

  prepare(acct: AuthAccount) {
      self.receiverRef = acct.getCapability<&{ExampleNFT.NFTReceiver}>(/public/NFTReceiver1)
          .borrow()
          ?? panic("Could not borrow receiver reference")        
      
      self.minterRef = acct.borrow<&ExampleNFT.NFTMinter>(from: /storage/NFTMinter)
          ?? panic("could not borrow minter reference")
  }

  execute {
      let metadata : {String : String} = {
          "name": "The small Swing",
          "swing_velocity": "29", 
          "swing_angle": "45", 
          "rating": "5",
          "uri": "ipfs://QmRZdc3mAMXpv6Akz9Ekp1y4vDSjazTx2dCQRkxVy1yUj6"
      }
      let newNFT <- self.minterRef.mintNFT()
  
      self.receiverRef.depositwm(token: <-newNFT, metadata: metadata)

      log("NFT Minted and deposited to Account 2's Collection")
  }
}
 