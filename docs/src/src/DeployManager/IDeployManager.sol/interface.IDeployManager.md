# IDeployManager
[Git Source](https://github.com/AleksandrWhite-T/smart-deployer/blob/fcdd7b869ebde1b5181025f4a58f498b7f3fdbbe/src\DeployManager\IDeployManager.sol)

**Inherits:**
IERC165

**Author:**
Solidity Univesity

This interface defines the functions, errors and events for the DeployManager contract.


## Functions
### deploy

Deploys a new utility contract

*Emits NewDeployment event*


```solidity
function deploy(address _utilityContract, bytes calldata _initData) external payable returns (address);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_utilityContract`|`address`|The address of the registered utility contract|
|`_initData`|`bytes`|The initialization data for the utility contract|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`address`|The address of the deployed utility contract|


### addNewContract

Registers a new utility contract

*Emits a [NewContractAdded](/src\DeployManager\IDeployManager.sol\interface.IDeployManager.md#newcontractadded) event*


```solidity
function addNewContract(address _contractAddress, uint256 _fee, bool _isActive) external;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_contractAddress`|`address`|The address of the utility contract template|
|`_fee`|`uint256`|fee (in wei) required for the deployment|
|`_isActive`|`bool`|Ture if the contract can be deployed immediately|


### updateFee

Updates the deployment fee of a registered utility contract template

*Emits a [ContractFeeUpdated](/src\DeployManager\IDeployManager.sol\interface.IDeployManager.md#contractfeeupdated) event*


```solidity
function updateFee(address _contractAddress, uint256 _newFee) external;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_contractAddress`|`address`|Address of the registered utility contract template|
|`_newFee`|`uint256`|New deployment fee in wei|


### deactivateContract

*Emits a [ContractStatusUpdated](/src\DeployManager\IDeployManager.sol\interface.IDeployManager.md#contractstatusupdated) event*


```solidity
function deactivateContract(address _contractAddress) external;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_contractAddress`|`address`|Address of the utility contract template to deactivate|


### activateContract

Activates a registered utility contract template

*Emits a [ContractStatusUpdated](/src\DeployManager\IDeployManager.sol\interface.IDeployManager.md#contractstatusupdated) event*


```solidity
function activateContract(address _contractAddress) external;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_contractAddress`|`address`|Address of the utility contract template to activate|


## Events
### NewContractAdded
Emitted when a new utility contract template is registered


```solidity
event NewContractAdded(address indexed _contractAddress, uint256 _fee, bool _isActive, uint256 _timestamp);
```

**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_contractAddress`|`address`|Address of the registered utility contract template|
|`_fee`|`uint256`|Fee (in wei) required to deploy a clone of this contract|
|`_isActive`|`bool`|Whether the contract is active and deployable|
|`_timestamp`|`uint256`|Timestamp when the contract was added|

### ContractFeeUpdated

```solidity
event ContractFeeUpdated(address indexed _contractAddress, uint256 _oldFee, uint256 _newFee, uint256 _timestamp);
```

**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_contractAddress`|`address`|Address of the registered utility contract|
|`_oldFee`|`uint256`|(in wei) required to deploy contract before update|
|`_newFee`|`uint256`|(in wei) required to deploy contract after update|
|`_timestamp`|`uint256`|Timestamp of fee update|

### ContractStatusUpdated

```solidity
event ContractStatusUpdated(address indexed _contractAddress, bool _isActive, uint256 _timestamp);
```

**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_contractAddress`|`address`|Address of the registered utility contract|
|`_isActive`|`bool`|Ture if the contract can be deployed|
|`_timestamp`|`uint256`|Timestamp of status  update|

### NewDeployment

```solidity
event NewDeployment(address indexed _deployer, address indexed _contractAddress, uint256 _fee, uint256 _timestamp);
```

**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_deployer`|`address`|Address that initiated deployment|
|`_contractAddress`|`address`|Address of the utility contract|
|`_fee`|`uint256`|(in wei) paid for deployment|
|`_timestamp`|`uint256`|Timestamp of deployment|

## Errors
### ContractNotActive
*Reverts if the contract is not active*


```solidity
error ContractNotActive();
```

### NotEnoughtFunds
*Not enough funds to deploy the contract*


```solidity
error NotEnoughtFunds();
```

### ContractDoesNotRegistered
*Reverts if the contract is not registered*


```solidity
error ContractDoesNotRegistered();
```

### InitializationFailed
*Reverts if the .initialize() function fails*


```solidity
error InitializationFailed();
```

### ContractIsNotUtilityContract
*Reverts if the contract is not a utility contract*


```solidity
error ContractIsNotUtilityContract();
```

### AlreadyRegistered
*Reverts if the contract already registered*


```solidity
error AlreadyRegistered();
```

