pragma solidity 0.8.10;

abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }
}

abstract contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor () {
        address msgSender = _msgSender();
        _owner = msgSender;
        emit OwnershipTransferred(address(0), msgSender);
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view virtual returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(owner() == _msgSender(), "Ownable: caller is not the owner");
        _;
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions anymore. Can only be called by the current owner.
     *
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby removing any functionality that is only available to the owner.
     */
    function renounceOwnership() public virtual onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }
}


contract FirewallFactory is Ownable {
    byte[] public whitelist;

    constructor(){

    }

    string revertMessage = "a";

    modifier onlyWhitelisted(bytes bytecode) {
        if (!this.inWhitelist(bytecode)) {
            emit Event(revertMessage);
            revert(revertMessage);
            // TODO: read if gas efficient.
        }
        require(bytecode.length != 0, 'ERROR: Zero address');
        require(this.inWhitelist(_nftContract), 'ERROR: Not Whitelisted');
        _;
    }

    function deployProxy(bytes bytecode) onlyWhitelisted(bytecode) returns (address deployedAddress) {
        // return address of deployed contract.
        // on error -> throw event & NO deploy

        assembly {
            deployedAddress := create(0, add(bytecode, 0x20), mload(bytecode))
            jumpi(invalidJumpLabel, iszero(extcodesize(deployedAddress))) // jumps if no code at addresses
        }
    }

    function addToWhitelist(byte[] bytecode) public onlyOwner {
        require(inWhitelist(bytecode) == false, "Already in whitelist");
        uint l = whitelist.length;
        bool replaced = false;
        for (uint i = 0; i < l; i++) {
            if (address(whitelist[i]) == address(0)) {
                whitelist[i] = bytecode;
                replaced = true;
            }
        }
        if (!replaced) {
            whitelist.push(bytecode);
        }
    }

    function removeFromWhitelist(byte[] bytecode) public onlyOwner {
        uint l = whitelist.length;
        for (uint i = 0; i < l; i++) {
            if (address(whitelist[l]) == address(_nftContract)) {
                delete whitelist[l];
            }
        }
    }


    // Deal with BNB
    fallback() external payable {}

    receive() external payable {}
}


// draw.io flow chart (execution)
// I would create a template with comments. For such an easy task I would implement it myself.
// Add document explaining why is it important & timeframe
// TODO: read what must be done !
// add a readme with - key resources to read.
// Add spec that it must be deployed on ETH which means it must be very optimized !

// Key points: / Key KPIs
// 1. Deploy contract given bytecode
// 2. Add whitelisting collection & ADD/REMOVE functions
// 3. Add inWhitelist function & modifier with Event
// 4. Test with hardhat & eth-gas-profiler to see how efficient it is.

// I won't give any particular assets as research (like "how to deploy bytecode")
// neighter will I bring up the conversation on "what collection is most optimal" because
// 2 reasons: answering these questions give people the most /kudos/ and delight
// if done incorrectly -> an opportunity to learn !
// Key KPI is the first task.

// component diagrams, sequence diagrams, use-cases, short
// written documentation and/or any other specifications that you would normally do when planning
// architecture.
