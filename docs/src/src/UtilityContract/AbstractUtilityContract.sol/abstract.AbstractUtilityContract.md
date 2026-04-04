# AbstractUtilityContract
[Git Source](https://github.com/AleksandrWhite-T/smart-deployer/blob/fcdd7b869ebde1b5181025f4a58f498b7f3fdbbe/src\UtilityContract\AbstractUtilityContract.sol)

**Inherits:**
[IUtilityContract](/src\UtilityContract\IUtilityContract.sol\interface.IUtilityContract.md), ERC165

**Author:**
Solidity University

Provides common logic for utility contracts to interact with the DeployManager.

*Inherit this abstract contract in custom utility contracts and override `initialize` if needed.*


## State Variables
### initialized
Flag indicating if the contract has already been initialized


```solidity
bool public initialized;
```


### deployManager
Address of the DeployManager that deployed or manages this contract


```solidity
address public deployManager;
```


## Functions
### notInitialized

*Ensures that the function can only be called before the contract is initialized*


```solidity
modifier notInitialized();
```

### initialize

Initializes the contract with encoded initialization data

*Typically called by the DeployManager right after deploying the clone*


```solidity
function initialize(bytes memory _initData) external virtual override returns (bool);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_initData`|`bytes`|Encoded address of the DeployManager|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`bool`|Returns true if initialization succeeds|


### setDeployManager

*Sets the DeployManager address after validation*


```solidity
function setDeployManager(address _deployManager) internal virtual;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_deployManager`|`address`|The DeployManager address|


### validateDeployManager

*Validates the DeployManager by checking its interface support*


```solidity
function validateDeployManager(address _deployManager) internal view returns (bool);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_deployManager`|`address`|The address to validate|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`bool`|True if the address implements IDeployManager|


### getDeployManager

Returns the stored DeployManager address


```solidity
function getDeployManager() external view virtual override returns (address);
```
**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`address`|The DeployManager address|


### supportsInterface

Indicates support for IUtilityContract and ERC165 interfaces


```solidity
function supportsInterface(bytes4 interfaceId) public view virtual override(IERC165, ERC165) returns (bool);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`interfaceId`|`bytes4`|The interface identifier to check|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`bool`|True if the contract supports the provided interface|


