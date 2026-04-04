// SPDX-License-Identifier: MIT
pragma solidity ^0.8.29;

import "../UtilityContract/AbstractUtilityContract.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/access/Ownable2Step.sol";

/// @title ERC721Airdroper - Airdrop utility contract for ERC721 tokens
/// @author Solidity University
/// @notice Allows owner to distribute ERC721 NFTs from treasury to multiple recipients.
/// @dev Inherits from AbstractUtilityContract for DeployManager integration and Ownable2Step for ownership control.
contract ERC721Airdroper is AbstractUtilityContract, Ownable2Step {
    /// @notice Initializes ownership of the contract
    constructor() payable Ownable(msg.sender) {}

    /// @notice Maximum number of recipients allowed in a single airdrop batch
    uint256 public constant MAX_AIRDROP_BATCH_SIZE = 300;

    /// @notice The ERC721 token to be distributed
    IERC721 public token;

    /// @notice The address from which tokens will be sent
    address public treasury;

    /// @dev Raised when receivers and tokenIds arrays have different lengths
    error ArraysLengthMismatch();

    /// @dev Raised when trying to airdrop to more than MAX_AIRDROP_BATCH_SIZE addresses
    error BatchSizeExceeded();

    /// @dev Raised when contract is not approved to transfer all tokens from treasury
    error NeedToApproveTokens();

    /// @notice Distributes ERC721 tokens to multiple recipients in one transaction
    /// @param receivers List of recipient addresses
    /// @param tokenIds List of token IDs for each recipient (must match receivers length)
    /// @dev Requires treasury to approve this contract with setApprovalForAll.
    function airdrop(address[] calldata receivers, uint256[] calldata tokenIds) external onlyOwner {
        require(receivers.length <= MAX_AIRDROP_BATCH_SIZE, BatchSizeExceeded());
        require(receivers.length == tokenIds.length, ArraysLengthMismatch());
        require(token.isApprovedForAll(treasury, address(this)), NeedToApproveTokens());

        address treasuryAddress = treasury;
        IERC721 tokenAddress = token;

        for (uint256 i = 0; i < receivers.length;) {
            tokenAddress.safeTransferFrom(treasuryAddress, receivers[i], tokenIds[i]);
            unchecked {
                ++i;
            }
        }
    }

    /// @notice Initializes the contract with configuration data
    /// @param _initData Encoded data containing deployManager, token, treasury, and owner
    /// @return True if initialization is successful
    /// @dev This function can only be called once by the DeployManager during deployment
    function initialize(bytes memory _initData) external override notInitialized returns (bool) {
        (address _deployManager, address _token, address _treasury, address _owner) =
            abi.decode(_initData, (address, address, address, address));

        setDeployManager(_deployManager);
        token = IERC721(_token);
        treasury = _treasury;
        _transferOwnership(_owner);
        initialized = true;

        return true;
    }

    /// @notice Helper to encode initialization data for deployment
    /// @param _deployManager Address of the DeployManager
    /// @param _token Address of the ERC721 token
    /// @param _treasury Treasury address holding NFTs
    /// @param _owner Owner address for this contract
    /// @return Encoded data ready for initialization
    function getInitData(address _deployManager, address _token, address _treasury, address _owner)
        external
        pure
        returns (bytes memory)
    {
        return abi.encode(_deployManager, _token, _treasury, _owner);
    }
}
