# IDeployManager
[Git Source](https://github.com/SolidityUniversity/smart-deployer/blob/85c11aeeaafc38269bb5a66ecafac729e84c7b17/src/DeployManager/IDeployManager.sol)

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
|`_utilityContract`|`address`|The address of the utility contract template|
|`_initData`|`bytes`|The initialization data for the utility contract|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`address`|The address of the deployed utility contract|


### addNewContract


```solidity
function addNewContract(address _contractAddress, uint256 _fee, bool _isActive) external;
```

### updateFee


```solidity
function updateFee(address _contractAddress, uint256 _newFee) external;
```

### deactivateContract


```solidity
function deactivateContract(address _contractAddress) external;
```

### activateContract


```solidity
function activateContract(address _contractAddress) external;
```

## Events
### NewContractAdded
Emitted when a new utility contract template is registered.


```solidity
event NewContractAdded(address indexed _contractAddress, uint256 _fee, bool _isActive, uint256 _timestamp);
```

**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_contractAddress`|`address`|Address of the registered utility contract template.|
|`_fee`|`uint256`|Fee (in wei) required to deploy a clone of this contract.|
|`_isActive`|`bool`|Whether the contract is active and deployable.|
|`_timestamp`|`uint256`|Timestamp when the contract was added.|

### ContractFeeUpdated

```solidity
event ContractFeeUpdated(address indexed _contractAddress, uint256 _oldFee, uint256 _newFee, uint256 _timestamp);
```

### ContractStatusUpdated

```solidity
event ContractStatusUpdated(address indexed _contractAddress, bool _isActive, uint256 _timestamp);
```

### NewDeployment

```solidity
event NewDeployment(address indexed _deployer, address indexed _contractAddress, uint256 _fee, uint256 _timestamp);
```

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

