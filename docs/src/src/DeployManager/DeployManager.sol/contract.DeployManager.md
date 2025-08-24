# DeployManager
[Git Source](https://github.com/SolidityUniversity/smart-deployer/blob/85c11aeeaafc38269bb5a66ecafac729e84c7b17/src/DeployManager/DeployManager.sol)

**Inherits:**
[IDeployManager](/src/DeployManager/IDeployManager.sol/interface.IDeployManager.md), Ownable, ERC165

**Author:**
Solidity University

Allows users to deploy utility contracts by cloning registered templates.

*Uses OpenZeppelin's Clones and Ownable; assumes templates implement IUtilityContract.*


## State Variables
### deployedContracts

```solidity
mapping(address => address[]) public deployedContracts;
```


### contractsData

```solidity
mapping(address => ContractInfo) public contractsData;
```


## Functions
### constructor


```solidity
constructor() payable Ownable(msg.sender);
```

### deploy

Deploys a new utility contract

*Emits NewDeployment event*


```solidity
function deploy(address _utilityContract, bytes calldata _initData) external payable override returns (address);
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
function addNewContract(address _contractAddress, uint256 _fee, bool _isActive) external override onlyOwner;
```

### updateFee


```solidity
function updateFee(address _contractAddress, uint256 _newFee) external override onlyOwner;
```

### deactivateContract


```solidity
function deactivateContract(address _address) external override onlyOwner;
```

### activateContract


```solidity
function activateContract(address _address) external override onlyOwner;
```

### supportsInterface


```solidity
function supportsInterface(bytes4 interfaceId) public view virtual override(IERC165, ERC165) returns (bool);
```

## Structs
### ContractInfo

```solidity
struct ContractInfo {
    uint256 fee;
    bool isActive;
    uint256 registredAt;
}
```

