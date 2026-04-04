// SPDX-License-Identifier: MIT
pragma solidity ^0.8.29;

import "../UtilityContract/AbstractUtilityContract.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable2Step.sol";

/// @title ERC20Airdroper - Airdrop utility contract for ERC20 tokens
/// @author Solidity University
/// @notice This contract allows the owner to distribute (airdrop) ERC20 tokens to multiple recipients.
/// @dev Inherits from AbstractUtilityContract for DeployManager integration and Ownable2Step for ownership control.
contract ERC20Airdroper is AbstractUtilityContract, Ownable2Step {
    // ------------------------------------------------------------------------
    // Constructor
    // ------------------------------------------------------------------------

    /// @notice Initializes ownership of the contract
    /// @dev Ownable in OpenZeppelin v5 accepts no parameters; if using v4, passing msg.sender is correct
    constructor() payable Ownable(msg.sender) {}

    // ------------------------------------------------------------------------
    // Constants
    // ------------------------------------------------------------------------

    /// @notice Maximum number of recipients allowed in a single airdrop batch
    uint256 public constant MAX_AIRDROP_BATCH_SIZE = 300;

    // ------------------------------------------------------------------------
    // State variables
    // ------------------------------------------------------------------------

    /// @notice The ERC20 token to be distributed
    IERC20 public token;

    /// @notice The amount expected to be approved for transfer by the treasury
    uint256 public amount;

    /// @notice The address from which tokens will be sent
    address public treasury;

    // ------------------------------------------------------------------------
    // Custom errors
    // ------------------------------------------------------------------------

    /// @dev Raised when receivers and amounts arrays have different lengths
    error ArraysLengthMismatch();

    /// @dev Raised when the contract doesn't have enough approved tokens to complete the airdrop
    error NotEnoughApprovedTokens();

    /// @dev Raised if a token transfer fails
    error TransferFailed();

    /// @dev Raised when trying to airdrop to more than MAX_AIRDROP_BATCH_SIZE addresses
    error BatchSizeExceeded();

    // ------------------------------------------------------------------------
    // Public functions
    // ------------------------------------------------------------------------

    /// @notice Distributes tokens to multiple recipients in one transaction
    /// @param receivers List of recipient addresses
    /// @param amounts List of token amounts for each recipient (must match receivers length)
    /// @dev Requires the treasury to approve this contract to transfer at least `amount`
    function airdrop(address[] calldata receivers, uint256[] calldata amounts) external onlyOwner {
        // Check batch size limit
        require(receivers.length <= MAX_AIRDROP_BATCH_SIZE, BatchSizeExceeded());

        // Ensure both arrays match in length
        require(receivers.length == amounts.length, ArraysLengthMismatch());

        address treasuryAddress = treasury;
        IERC20 token_ = token;

        // Ensure sufficient allowance is approved
        require(token_.allowance(treasuryAddress, address(this)) >= amount, NotEnoughApprovedTokens());

        // Loop through all recipients and transfer tokens
        for (uint256 i = 0; i < receivers.length;) {
            require(token_.transferFrom(treasuryAddress, receivers[i], amounts[i]), TransferFailed());
            unchecked {
                ++i;
            }
        }
    }

    // ------------------------------------------------------------------------
    // Initialization
    // ------------------------------------------------------------------------

    /// @notice Initializes the contract with configuration data
    /// @param _initData Encoded data containing deployManager, token, amount, treasury, and owner
    /// @return True if initialization is successful
    /// @dev This function can only be called once by the DeployManager during deployment
    function initialize(bytes memory _initData) external override notInitialized returns (bool) {
        (address _deployManager, address _token, uint256 _amount, address _treasury, address _owner) =
            abi.decode(_initData, (address, address, uint256, address, address));

        // Validate and set the DeployManager
        setDeployManager(_deployManager);

        // Set token, amount, and treasury address
        token = IERC20(_token);
        amount = _amount;
        treasury = _treasury;

        // Transfer contract ownership to specified owner
        _transferOwnership(_owner);

        // Mark the contract as initialized
        initialized = true;
        return true;
    }

    // ------------------------------------------------------------------------
    // Utility functions
    // ------------------------------------------------------------------------

    /// @notice Helper to encode initialization data for deployment
    /// @param _deployManager Address of the DeployManager
    /// @param _token Address of the ERC20 token
    /// @param _amount Amount to be approved by treasury
    /// @param _treasury Treasury address holding the tokens
    /// @param _owner Owner address for this contract
    /// @return Encoded data ready for initialization
    function getInitData(address _deployManager, address _token, uint256 _amount, address _treasury, address _owner)
        external
        pure
        returns (bytes memory)
    {
        return abi.encode(_deployManager, _token, _amount, _treasury, _owner);
    }
}
