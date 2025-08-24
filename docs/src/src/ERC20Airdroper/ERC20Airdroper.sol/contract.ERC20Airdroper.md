# ERC20Airdroper
[Git Source](https://github.com/SolidityUniversity/smart-deployer/blob/85c11aeeaafc38269bb5a66ecafac729e84c7b17/src/ERC20Airdroper/ERC20Airdroper.sol)

**Inherits:**
[AbstractUtilityContract](/src/UtilityContract/AbstractUtilityContract.sol/abstract.AbstractUtilityContract.md), Ownable

**Author:**
Solidity University

This contract allows the owner to airdrop ERC20 tokens to multiple addresses.

*Inherits from AbstractUtilityContract and Ownable*


## State Variables
### MAX_AIRDROP_BATCH_SIZE

```solidity
uint256 public constant MAX_AIRDROP_BATCH_SIZE = 300;
```


### token

```solidity
IERC20 public token;
```


### amount

```solidity
uint256 public amount;
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
function airdrop(address[] calldata receivers, uint256[] calldata amounts) external onlyOwner;
```

### initialize


```solidity
function initialize(bytes memory _initData) external override notInitialized returns (bool);
```

### getInitData


```solidity
function getInitData(address _deployManager, address _token, uint256 _amount, address _treasury, address _owner)
    external
    pure
    returns (bytes memory);
```

## Errors
### ArraysLengthMismatch

```solidity
error ArraysLengthMismatch();
```

### NotEnoughApprovedTokens

```solidity
error NotEnoughApprovedTokens();
```

### TransferFailed

```solidity
error TransferFailed();
```

### BatchSizeExceeded

```solidity
error BatchSizeExceeded();
```

