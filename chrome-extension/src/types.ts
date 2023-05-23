export enum Sender {
  React,
  Content,
}

export type DaffyRequestType = "store-api-key" | "add-amount";

export type DaffyRequest = {
  msg: DaffyRequestType;
  data: any;
};
