// SPDX-License-Identifier: MIT
pragma solidity ^0.8.29;

// Import the standard IERC165 interface for interface detection support
import "@openzeppelin/contracts/interfaces/IERC165.sol";

/// @title IUtilityContract - Interface for utility contracts
/// @author Solidity University
/// @notice This interface defines the core functions and errors for utility contracts.
/// @dev Any contract intended to work with the DeployManager must implement this interface.
interface IUtilityContract is IERC165 {
    // ------------------------------------------------------------------------
    // Errors
    // ------------------------------------------------------------------------

    /// @dev Reverts if the DeployManager address is zero (not set)
    error DeployManagerCannotBeZero();

    /// @dev Reverts if a function is called by someone other than the DeployManager
    error NotDeployManager();

    /// @dev Reverts if setting the DeployManager fails
    error FailedToDeployManager();

    /// @dev Reverts if the contract has already been initialized
    error AlreadyInitialized();

    // ------------------------------------------------------------------------
    // Functions
    // ------------------------------------------------------------------------

    /// @notice Initializes the utility contract with the provided data
    /// @param _initData Encoded initialization parameters for the utility contract
    /// @return True if initialization was successful
    /// @dev This function should be called by the DeployManager right after the contract is cloned.
    function initialize(bytes memory _initData) external returns (bool);

    /// @notice Returns the address of the DeployManager linked to this utility contract
    /// @return The DeployManager address
    function getDeployManager() external view returns (address);
}
