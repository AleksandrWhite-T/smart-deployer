# DeployManager
[Git Source](https://github.com/AleksandrWhite-T/smart-deployer/blob/fcdd7b869ebde1b5181025f4a58f498b7f3fdbbe/src\DeployManager\DeployManager.sol)

**Inherits:**
[IDeployManager](/src\DeployManager\IDeployManager.sol\interface.IDeployManager.md), Ownable2Step, ERC165

**Author:**
Solidity University

Allows users to deploy utility contracts by cloning registered templates.

*Uses OpenZeppelin's Clones and Ownable2Step; assumes templates implement IUtilityContract.*


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
|`_utilityContract`|`address`|The address of the registered utility contract|
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
    bool isDeployablel;
    uint256 registredAt;
}
```

