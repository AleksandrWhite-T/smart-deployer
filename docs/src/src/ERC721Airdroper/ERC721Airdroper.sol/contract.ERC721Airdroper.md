# ERC721Airdroper
[Git Source](https://github.com/AleksandrWhite-T/smart-deployer/blob/fcdd7b869ebde1b5181025f4a58f498b7f3fdbbe/src\ERC721Airdroper\ERC721Airdroper.sol)

**Inherits:**
[AbstractUtilityContract](/src\UtilityContract\AbstractUtilityContract.sol\abstract.AbstractUtilityContract.md), Ownable2Step

**Author:**
Solidity University

Allows owner to distribute ERC721 NFTs from treasury to multiple recipients.

*Inherits from AbstractUtilityContract for DeployManager integration and Ownable2Step for ownership control.*


## State Variables
### MAX_AIRDROP_BATCH_SIZE
Maximum number of recipients allowed in a single airdrop batch


```solidity
uint256 public constant MAX_AIRDROP_BATCH_SIZE = 300;
```


### token
The ERC721 token to be distributed


```solidity
IERC721 public token;
```


### treasury
The address from which tokens will be sent


```solidity
address public treasury;
```


## Functions
### constructor

Initializes ownership of the contract


```solidity
constructor() payable Ownable(msg.sender);
```

### airdrop

Distributes ERC721 tokens to multiple recipients in one transaction

*Requires treasury to approve this contract with setApprovalForAll.*


```solidity
function airdrop(address[] calldata receivers, uint256[] calldata tokenIds) external onlyOwner;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`receivers`|`address[]`|List of recipient addresses|
|`tokenIds`|`uint256[]`|List of token IDs for each recipient (must match receivers length)|


### initialize

Initializes the contract with configuration data

*This function can only be called once by the DeployManager during deployment*


```solidity
function initialize(bytes memory _initData) external override notInitialized returns (bool);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_initData`|`bytes`|Encoded data containing deployManager, token, treasury, and owner|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`bool`|True if initialization is successful|


### getInitData

Helper to encode initialization data for deployment


```solidity
function getInitData(address _deployManager, address _token, address _treasury, address _owner)
    external
    pure
    returns (bytes memory);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_deployManager`|`address`|Address of the DeployManager|
|`_token`|`address`|Address of the ERC721 token|
|`_treasury`|`address`|Treasury address holding NFTs|
|`_owner`|`address`|Owner address for this contract|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`bytes`|Encoded data ready for initialization|


## Errors
### ArraysLengthMismatch
*Raised when receivers and tokenIds arrays have different lengths*


```solidity
error ArraysLengthMismatch();
```

### BatchSizeExceeded
*Raised when trying to airdrop to more than MAX_AIRDROP_BATCH_SIZE addresses*


```solidity
error BatchSizeExceeded();
```

### NeedToApproveTokens
*Raised when contract is not approved to transfer all tokens from treasury*


```solidity
error NeedToApproveTokens();
```

