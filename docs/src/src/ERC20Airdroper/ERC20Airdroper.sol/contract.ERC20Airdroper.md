# ERC20Airdroper
[Git Source](https://github.com/AleksandrWhite-T/smart-deployer/blob/fcdd7b869ebde1b5181025f4a58f498b7f3fdbbe/src\ERC20Airdroper\ERC20Airdroper.sol)

**Inherits:**
[AbstractUtilityContract](/src\UtilityContract\AbstractUtilityContract.sol\abstract.AbstractUtilityContract.md), Ownable2Step

**Author:**
Solidity University

This contract allows the owner to distribute (airdrop) ERC20 tokens to multiple recipients.

*Inherits from AbstractUtilityContract for DeployManager integration and Ownable2Step for ownership control.*


## State Variables
### MAX_AIRDROP_BATCH_SIZE
Maximum number of recipients allowed in a single airdrop batch


```solidity
uint256 public constant MAX_AIRDROP_BATCH_SIZE = 300;
```


### token
The ERC20 token to be distributed


```solidity
IERC20 public token;
```


### amount
The amount expected to be approved for transfer by the treasury


```solidity
uint256 public amount;
```


### treasury
The address from which tokens will be sent


```solidity
address public treasury;
```


## Functions
### constructor

Initializes ownership of the contract

*Ownable in OpenZeppelin v5 accepts no parameters; if using v4, passing msg.sender is correct*


```solidity
constructor() payable Ownable(msg.sender);
```

### airdrop

Distributes tokens to multiple recipients in one transaction

*Requires the treasury to approve this contract to transfer at least `amount`*


```solidity
function airdrop(address[] calldata receivers, uint256[] calldata amounts) external onlyOwner;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`receivers`|`address[]`|List of recipient addresses|
|`amounts`|`uint256[]`|List of token amounts for each recipient (must match receivers length)|


### initialize

Initializes the contract with configuration data

*This function can only be called once by the DeployManager during deployment*


```solidity
function initialize(bytes memory _initData) external override notInitialized returns (bool);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_initData`|`bytes`|Encoded data containing deployManager, token, amount, treasury, and owner|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`bool`|True if initialization is successful|


### getInitData

Helper to encode initialization data for deployment


```solidity
function getInitData(address _deployManager, address _token, uint256 _amount, address _treasury, address _owner)
    external
    pure
    returns (bytes memory);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_deployManager`|`address`|Address of the DeployManager|
|`_token`|`address`|Address of the ERC20 token|
|`_amount`|`uint256`|Amount to be approved by treasury|
|`_treasury`|`address`|Treasury address holding the tokens|
|`_owner`|`address`|Owner address for this contract|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`bytes`|Encoded data ready for initialization|


## Errors
### ArraysLengthMismatch
*Raised when receivers and amounts arrays have different lengths*


```solidity
error ArraysLengthMismatch();
```

### NotEnoughApprovedTokens
*Raised when the contract doesn't have enough approved tokens to complete the airdrop*


```solidity
error NotEnoughApprovedTokens();
```

### TransferFailed
*Raised if a token transfer fails*


```solidity
error TransferFailed();
```

### BatchSizeExceeded
*Raised when trying to airdrop to more than MAX_AIRDROP_BATCH_SIZE addresses*


```solidity
error BatchSizeExceeded();
```

