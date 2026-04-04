# ERC1155Airdroper
[Git Source](https://github.com/AleksandrWhite-T/smart-deployer/blob/fcdd7b869ebde1b5181025f4a58f498b7f3fdbbe/src\ERC1155Airdroper\ERC1155Airdroper.sol)

**Inherits:**
[AbstractUtilityContract](/src\UtilityContract\AbstractUtilityContract.sol\abstract.AbstractUtilityContract.md), Ownable2Step

**Author:**
...

Allows the contract owner to distribute ERC1155 tokens to multiple recipients in a single transaction.

*Inherits from AbstractUtilityContract for DeployManager integration and Ownable2Step for access control.*


## State Variables
### MAX_AIRDROP_BATCH_SIZE
Maximum number of recipients in a single airdrop batch


```solidity
uint256 public constant MAX_AIRDROP_BATCH_SIZE = 10;
```


### token
ERC1155 token to distribute


```solidity
IERC1155 public token;
```


### treasury
Treasury address that holds the tokens to be distributed


```solidity
address public treasury;
```


## Functions
### constructor

Initializes ownership of the contract

*In OpenZeppelin v5, `Ownable` constructor takes no parameters and should be `Ownable()`.*


```solidity
constructor() payable Ownable(msg.sender);
```

### airdrop

Airdrop ERC1155 tokens to multiple addresses in a single batch

*Requires the treasury to approve this contract with `setApprovalForAll`.*


```solidity
function airdrop(address[] calldata receivers, uint256[] calldata amounts, uint256[] calldata tokenIds)
    external
    onlyOwner;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`receivers`|`address[]`|List of recipient addresses|
|`amounts`|`uint256[]`|List of token amounts to send to each recipient|
|`tokenIds`|`uint256[]`|List of token IDs corresponding to each recipient|


### initialize

Initializes the contract with configuration data

*This function can only be called once by the DeployManager during deployment.*


```solidity
function initialize(bytes memory _initData) external override notInitialized returns (bool);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_initData`|`bytes`|Encoded data containing deployManager, token, treasury, and owner addresses|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`bool`|Returns true if initialization succeeds|


### getInitData

Helper function to encode initialization data for DeployManager


```solidity
function getInitData(address _deployManager, address _token, address _treasury, address _owner)
    external
    pure
    returns (bytes memory);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_deployManager`|`address`|DeployManager address|
|`_token`|`address`|ERC1155 token address|
|`_treasury`|`address`|Treasury address holding tokens|
|`_owner`|`address`|Owner address for this contract|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`bytes`|Encoded data ready to be passed to initialize()|


## Errors
### ReceiversLengthMismatch
*Raised when the receivers array length does not match token IDs array length*


```solidity
error ReceiversLengthMismatch();
```

### AmountsLengthMismatch
*Raised when the amounts array length does not match token IDs array length*


```solidity
error AmountsLengthMismatch();
```

### BatchSizeExceeded
*Raised when trying to airdrop more tokens than the allowed batch size*


```solidity
error BatchSizeExceeded();
```

### NeedToApproveTokens
*Raised when the contract is not approved to transfer tokens from the treasury*


```solidity
error NeedToApproveTokens();
```

