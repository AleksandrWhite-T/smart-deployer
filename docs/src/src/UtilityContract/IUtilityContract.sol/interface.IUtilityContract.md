# IUtilityContract
[Git Source](https://github.com/AleksandrWhite-T/smart-deployer/blob/fcdd7b869ebde1b5181025f4a58f498b7f3fdbbe/src\UtilityContract\IUtilityContract.sol)

**Inherits:**
IERC165

**Author:**
Solidity University

This interface defines the core functions and errors for utility contracts.

*Any contract intended to work with the DeployManager must implement this interface.*


## Functions
### initialize

Initializes the utility contract with the provided data

*This function should be called by the DeployManager right after the contract is cloned.*


```solidity
function initialize(bytes memory _initData) external returns (bool);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_initData`|`bytes`|Encoded initialization parameters for the utility contract|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`bool`|True if initialization was successful|


### getDeployManager

Returns the address of the DeployManager linked to this utility contract


```solidity
function getDeployManager() external view returns (address);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`address`|The DeployManager address|


## Errors
### DeployManagerCannotBeZero
*Reverts if the DeployManager address is zero (not set)*


```solidity
error DeployManagerCannotBeZero();
```

### NotDeployManager
*Reverts if a function is called by someone other than the DeployManager*


```solidity
error NotDeployManager();
```

### FailedToDeployManager
*Reverts if setting the DeployManager fails*


```solidity
error FailedToDeployManager();
```

### AlreadyInitialized
*Reverts if the contract has already been initialized*


```solidity
error AlreadyInitialized();
```

