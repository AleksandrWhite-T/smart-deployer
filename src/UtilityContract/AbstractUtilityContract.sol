// SPDX-License-Identifier: MIT
pragma solidity ^0.8.29;

import "@openzeppelin/contracts/utils/introspection/ERC165.sol";

import {IDeployManager} from "../DeployManager/IDeployManager.sol";
import {IUtilityContract} from "./IUtilityContract.sol";

/// @title AbstractUtilityContract - Base implementation for utility contracts
/// @author Solidity University
/// @notice Provides common logic for utility contracts to interact with the DeployManager.
/// @dev Inherit this abstract contract in custom utility contracts and override `initialize` if needed.
abstract contract AbstractUtilityContract is IUtilityContract, ERC165 {
    // ------------------------------------------------------------------------
    // State variables
    // ------------------------------------------------------------------------

    /// @notice Flag indicating if the contract has already been initialized
    bool public initialized;

    /// @notice Address of the DeployManager that deployed or manages this contract
    address public deployManager;

    // ------------------------------------------------------------------------
    // Modifiers
    // ------------------------------------------------------------------------

    /// @dev Ensures that the function can only be called before the contract is initialized
    modifier notInitialized() {
        require(!initialized, AlreadyInitialized());
        _;
    }

    // ------------------------------------------------------------------------
    // Initialization
    // ------------------------------------------------------------------------

    /// @notice Initializes the contract with encoded initialization data
    /// @param _initData Encoded address of the DeployManager
    /// @return Returns true if initialization succeeds
    /// @dev Typically called by the DeployManager right after deploying the clone
    function initialize(bytes memory _initData) external virtual override returns (bool) {
        deployManager = abi.decode(_initData, (address));
        setDeployManager(deployManager);
        return true;
    }

    // ------------------------------------------------------------------------
    // Internal helpers
    // ------------------------------------------------------------------------

    /// @dev Sets the DeployManager address after validation
    /// @param _deployManager The DeployManager address
    function setDeployManager(address _deployManager) internal virtual {
        if (!validateDeployManager(_deployManager)) {
            revert FailedToDeployManager();
        }
        deployManager = _deployManager;
    }

    /// @dev Validates the DeployManager by checking its interface support
    /// @param _deployManager The address to validate
    /// @return True if the address implements IDeployManager
    function validateDeployManager(address _deployManager) internal view returns (bool) {
        // Ensure address is not zero
        if (_deployManager == address(0)) {
            revert DeployManagerCannotBeZero();
        }

        // Check if the provided address supports the IDeployManager interface
        bytes4 interfaceId = type(IDeployManager).interfaceId;
        if (!IDeployManager(_deployManager).supportsInterface(interfaceId)) {
            revert NotDeployManager();
        }

        return true;
    }

    // ------------------------------------------------------------------------
    // Getters
    // ------------------------------------------------------------------------

    /// @notice Returns the stored DeployManager address
    /// @return The DeployManager address
    function getDeployManager() external view virtual override returns (address) {
        return deployManager;
    }

    // ------------------------------------------------------------------------
    // ERC165 Support
    // ------------------------------------------------------------------------

    /// @notice Indicates support for IUtilityContract and ERC165 interfaces
    /// @param interfaceId The interface identifier to check
    /// @return True if the contract supports the provided interface
    function supportsInterface(bytes4 interfaceId)
        public
        view
        virtual
        override(IERC165, ERC165)
        returns (bool)
    {
        return interfaceId == type(IUtilityContract).interfaceId || super.supportsInterface(interfaceId);
    }
}
