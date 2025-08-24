# ERC1155Airdroper
[Git Source](https://github.com/SolidityUniversity/smart-deployer/blob/85c11aeeaafc38269bb5a66ecafac729e84c7b17/src/ERC1155Airdroper/ERC1155Airdroper.sol)

**Inherits:**
[AbstractUtilityContract](/src/UtilityContract/AbstractUtilityContract.sol/abstract.AbstractUtilityContract.md), Ownable


## State Variables
### MAX_AIRDROP_BATCH_SIZE

```solidity
uint256 public constant MAX_AIRDROP_BATCH_SIZE = 10;
```


### token

```solidity
IERC1155 public token;
```


### treasury

```solidity
address public treasury;
```


## Functions
### constructor


```solidity
constructor() payable Ownable(msg.sender);
```

### airdrop


```solidity
function airdrop(address[] calldata receivers, uint256[] calldata amounts, uint256[] calldata tokenIds)
    external
    onlyOwner;
```

### initialize


```solidity
function initialize(bytes memory _initData) external override notInitialized returns (bool);
```

### getInitData


```solidity
function getInitData(address _deployManager, address _token, address _treasury, address _owner)
    external
    pure
    returns (bytes memory);
```

## Errors
### ReceiversLengthMismatch

```solidity
error ReceiversLengthMismatch();
```

### AmountsLengthMismatch

```solidity
error AmountsLengthMismatch();
```

### BatchSizeExceeded

```solidity
error BatchSizeExceeded();
```

### NeedToApproveTokens

```solidity
error NeedToApproveTokens();
```

