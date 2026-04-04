# Vesting
[Git Source](https://github.com/AleksandrWhite-T/smart-deployer/blob/fcdd7b869ebde1b5181025f4a58f498b7f3fdbbe/src\Vesting\Vesting.sol)

**Inherits:**
[IVesting](/src\Vesting\IVesting.sol\interface.IVesting.md), [AbstractUtilityContract](/src\UtilityContract\AbstractUtilityContract.sol\abstract.AbstractUtilityContract.md), Ownable2Step

Manages token vesting schedules for beneficiaries

*Inherits IVesting, AbstractUtilityContract, Ownable2Step*


## State Variables
### token
The ERC20 token that is being vested


```solidity
IERC20 public token;
```


### allocatedTokens
The total amount of tokens that have been allocated for vesting


```solidity
uint256 public allocatedTokens;
```


### vestings
A mapping of beneficiary addresses to their vesting information


```solidity
mapping(address => IVesting.VestingInfo) public vestings;
```


## Functions
### constructor

Initializes the contract with deploy manager, token, and owner


```solidity
constructor() payable Ownable(msg.sender);
```

### claim

Claims all tokens currently available for the caller according to their vesting schedule


```solidity
function claim() public;
```

### startVesting

Creates a new vesting schedule for a beneficiary


```solidity
function startVesting(IVesting.VestingParams calldata params) external onlyOwner;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`params`|`IVesting.VestingParams`|Struct containing the parameters for the new vesting schedule|


### withdrawUnallocated

Withdraws all unallocated tokens from the contract to the specified address


```solidity
function withdrawUnallocated(address _to) external onlyOwner;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_to`|`address`|Address to receive the withdrawn tokens|


### initialize

Initializes the contract with encoded initialization data

*Typically called by the DeployManager right after deploying the clone*


```solidity
function initialize(bytes memory _initData) external override notInitialized returns (bool);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_initData`|`bytes`|Encoded address of the DeployManager|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`bool`|Returns true if initialization succeeds|


### vestedAmount

Returns the total amount of tokens vested for a beneficiary at the current time


```solidity
function vestedAmount(address _claimer) public view returns (uint256);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_claimer`|`address`|Address of the beneficiary|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`uint256`|Amount of tokens vested|


### claimableAmount

Returns the amount of tokens that can currently be claimed by a beneficiary


```solidity
function claimableAmount(address _claimer) public view returns (uint256);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_claimer`|`address`|Address of the beneficiary|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`uint256`|Amount of tokens claimable|


### getVestingInfo

Returns the information about a vesting schedule for a beneficiary


```solidity
function getVestingInfo(address _claimer) public view returns (IVesting.VestingInfo memory);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_claimer`|`address`|Address of the beneficiary|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`IVesting.VestingInfo`|VestingInfo struct containing the vesting information|


### getInitData

Returns the ABI-encoded initialization data for the contract


```solidity
function getInitData(address _deployManager, address _token, address _owner) external pure returns (bytes memory);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_deployManager`|`address`|Address of the deploy manager|
|`_token`|`address`|Address of the ERC20 token|
|`_owner`|`address`|Address of the contract owner|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`bytes`|ABI-encoded initialization data|


