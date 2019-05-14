pragma solidity ^0.4.23;

contract SukukMudarabaCoupon {

  enum State{Funding, Active, Matured}
  enum WhitelistType{BackOffice, Investor, TransferToken, Trustee, Pay}

  public address trustee;

  event ErrorAccessDenied(address indexed attemptedFrom, string reason);
  event ErrorNotAllowed(string reason);
  event ErrorNotAllowedStateRequired(State current, State, required);
  event ErrorAuthorizationRequired(address attempted, WhitelistType whitelistType); // previously AddressNotWhitelisted

  event CouponsIssued(address indexed to, uint amount);
  event Refunded(address sender, address token, uint amount, string reason);
  event Transfer(address indexed _from, address indexed _to, uint256 _value);
  event Approval(address indexed _owner, address indexed _spender, uint256 _value);

  event Matured(uint ethTotalProfit, uint fiatTotalProfit);

  modifier trusteeRequired() {
    if (msg.sender != trustee) {
       emit ErrorAuthorizationRequired(msg.sender, Trustee);
       return;
    }
    _;
  }

  modifier stateRequired(State requiredState) {
    State currentState = getState();
    if (currentState != requiredState) {
      emit ErrorNotAllowedStateRequired(currentState, requiredState);
      return;
    }
    _;
  }

  function payCouponPayment() payable public {}
  function getState() public {}

  function isFunding() public constant returns (bool) {}
  function isActive() public constant returns (bool) {}
  function isMatured() public constant returns (bool) {}

}
