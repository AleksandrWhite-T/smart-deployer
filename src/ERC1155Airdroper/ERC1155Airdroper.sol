// SPDX-License-Identifier: MIT
pragma solidity ^0.8.29;

import "../UtilityContract/AbstractUtilityContract.sol";
import "@openzeppelin/contracts/token/ERC1155/IERC1155.sol";
import "@openzeppelin/contracts/access/Ownable2Step.sol";

/// @title ERC1155Airdroper - Airdrop utility for ERC1155 tokens
/// @author ...
/// @notice Allows the contract owner to distribute ERC1155 tokens to multiple recipients in a single transaction.
/// @dev Inherits from AbstractUtilityContract for DeployManager integration and Ownable2Step for access control.
contract ERC1155Airdroper is AbstractUtilityContract, Ownable2Step {
    // ------------------------------------------------------------------------
    // Constructor
    // ------------------------------------------------------------------------

    /// @notice Initializes ownership of the contract
    /// @dev In OpenZeppelin v5, `Ownable` constructor takes no parameters and should be `Ownable()`.
    constructor() payable Ownable(msg.sender) {}

    // ------------------------------------------------------------------------
    // Constants
    // ------------------------------------------------------------------------

    /// @notice Maximum number of recipients in a single airdrop batch
    uint256 public constant MAX_AIRDROP_BATCH_SIZE = 10;

    // ------------------------------------------------------------------------
    // State variables
    // ------------------------------------------------------------------------

    /// @notice ERC1155 token to distribute
    IERC1155 public token;

    /// @notice Treasury address that holds the tokens to be distributed
    address public treasury;

    // ------------------------------------------------------------------------
    // Custom errors
    // ------------------------------------------------------------------------

    /// @dev Raised when the receivers array length does not match token IDs array length
    error ReceiversLengthMismatch();

    /// @dev Raised when the amounts array length does not match token IDs array length
    error AmountsLengthMismatch();

    /// @dev Raised when trying to airdrop more tokens than the allowed batch size
    error BatchSizeExceeded();

    /// @dev Raised when the contract is not approved to transfer tokens from the treasury
    error NeedToApproveTokens();

    // ------------------------------------------------------------------------
    // Public functions
    // ------------------------------------------------------------------------

    /// @notice Airdrop ERC1155 tokens to multiple addresses in a single batch
    /// @param receivers List of recipient addresses
    /// @param amounts List of token amounts to send to each recipient
    /// @param tokenIds List of token IDs corresponding to each recipient
    /// @dev Requires the treasury to approve this contract with `setApprovalForAll`.
    function airdrop(address[] calldata receivers, uint256[] calldata amounts, uint256[] calldata tokenIds)
        external
        onlyOwner
    {
        // Ensure the batch size does not exceed the maximum allowed
        require(tokenIds.length <= MAX_AIRDROP_BATCH_SIZE, BatchSizeExceeded());

        // Ensure the receivers and token IDs arrays have the same length
        require(receivers.length == tokenIds.length, ReceiversLengthMismatch());

        // Ensure the amounts and token IDs arrays have the same length
        require(amounts.length == tokenIds.length, AmountsLengthMismatch());

        address treasuryAddress = treasury;
        IERC1155 token_ = token;

        // Ensure the treasury has approved this contract to transfer tokens
        require(token_.isApprovedForAll(treasuryAddress, address(this)), NeedToApproveTokens());

        // Distribute tokens to each recipient
        for (uint256 i = 0; i < amounts.length;) {
            token_.safeTransferFrom(treasuryAddress, receivers[i], tokenIds[i], amounts[i], "");
            unchecked {
                ++i; // Safe increment without overflow checks
            }
        }
    }

    // ------------------------------------------------------------------------
    // Initialization
    // ------------------------------------------------------------------------

    /// @notice Initializes the contract with configuration data
    /// @param _initData Encoded data containing deployManager, token, treasury, and owner addresses
    /// @return Returns true if initialization succeeds
    /// @dev This function can only be called once by the DeployManager during deployment.
    function initialize(bytes memory _initData) external override notInitialized returns (bool) {
        (address _deployManager, address _token, address _treasury, address _owner) =
            abi.decode(_initData, (address, address, address, address));

        // Set and validate the DeployManager
        setDeployManager(_deployManager);

        // Assign token and treasury addresses
        token = IERC1155(_token);
        treasury = _treasury;

        // Transfer contract ownership to the provided owner (direct; avoids pending state from Ownable2Step.transferOwnership)
        _transferOwnership(_owner);

        // Mark contract as initialized
        initialized = true;
        return true;
    }

    // ------------------------------------------------------------------------
    // Utility functions
    // ------------------------------------------------------------------------

    /// @notice Helper function to encode initialization data for DeployManager
    /// @param _deployManager DeployManager address
    /// @param _token ERC1155 token address
    /// @param _treasury Treasury address holding tokens
    /// @param _owner Owner address for this contract
    /// @return Encoded data ready to be passed to initialize()
    function getInitData(address _deployManager, address _token, address _treasury, address _owner)
        external
        pure
        returns (bytes memory)
    {
        return abi.encode(_deployManager, _token, _treasury, _owner);
    }
}
