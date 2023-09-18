import { BigInt } from "@graphprotocol/graph-ts";
import { CreditAcquired, TransactionCounter } from "../generated/schema";
import { creditAcquired } from "../generated/NFTCredit/contract";

export function handleCreditAcquired(event: creditAcquired): void {
  // Load the TransactionCounter entity or create it if it doesn't exist
  let counter = TransactionCounter.load("counter");
  if (counter == null) {
    counter = new TransactionCounter("counter");
    counter.count = BigInt.fromI32(0);
  }

  // Increment the counter
  counter.count = counter.count.plus(BigInt.fromI32(1));
  counter.save();

  // Use the counter as the ID for the CreditAcquired entity
  let entity = new CreditAcquired(counter.count.toString());

  entity.to = event.params.to;
  entity.quantity = event.params.quantity;
  entity.creditAmount = event.params.creditAmount;
  entity.totalCreditAmount = event.params.totalCreditAmount;
  entity.minted = event.params.minted;
  // Additional fields
  entity.timestamp = event.block.timestamp;
  entity.block = event.block.number;
  entity.transactionHash = event.transaction.hash;

  entity.save();
}
