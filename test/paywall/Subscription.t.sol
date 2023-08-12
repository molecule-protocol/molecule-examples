// SPDX-License-Identifier: None
pragma solidity 0.8.17;

import "forge-std/Test.sol";
import "forge-std/Vm.sol";
import "forge-std/console.sol";

import "../../src/paywall/Subscription.sol";
import "@molecule-protocol/v2/MoleculeController.sol";
import "@molecule-protocol/v2/MoleculeLogicList.sol";

contract SubscriptionTest is Test {
    event ListAdded(address[] addresses);
    event Subscribed(address indexed user, uint64 expiration);
    event MoleculeUpdated(address molecule);
    event Selected(uint32[] ids);
    event LogicAdded(
        uint32 indexed id,
        address indexed logicContract,
        bool isAllowList,
        string name,
        bool reverseLogic
    );
    event Transfer(address indexed from, address indexed to, uint256 amount);
    enum Status {
        Gated,
        Blocked,
        Bypassed
    }
    enum MoleculeType {
        Approve,
        Burn,
        Mint,
        Transfer
    }

    Subscription public subToMultipleFans;
    MoleculeController public molecule;
    MoleculeLogicList public logicList;

    address alice = makeAddr("alice");
    address bob = makeAddr("bob");
    address charlie = makeAddr("charlie");
    address daisy = makeAddr("daisy");
    address eric = makeAddr("eric");

    function setUp() public {
        subToMultipleFans = new Subscription();
        molecule = new MoleculeController("molecule controller");

        // true means it's an allow-list, only those addresses can access the functionality
        logicList = new MoleculeLogicList("booyah", true);
    }

    function testSubscriptionAllowlist() public {
        // list of addresses
        address[] memory allowList = new address[](3);
        allowList[0] = alice;
        allowList[1] = bob;
        allowList[2] = charlie;

        uint32 logicId = 1;
        uint32[] memory ids = new uint32[](1);
        ids[0] = logicId;

        // add batch to logic contract
        vm.expectEmit(true, false, false, false);
        emit ListAdded(allowList);
        bool batchAdded = logicList.addBatch(allowList);
        assertEq(batchAdded, true);

        // add logic contract to Molecule for access control
        vm.expectEmit(true, true, true, true);
        // 3rd param: true means we're setting an allowlist
        emit LogicAdded(logicId, address(logicList), true, "test", false);
        molecule.addLogic(logicId, address(logicList), "test", false);

        vm.expectEmit(true, false, false, false);
        emit Selected(ids);
        molecule.select(ids);
        // vm.expectEmit(true, true, false, false);
        // emit Subscribed(daisy, block.timestamp + 30days);
        vm.expectEmit(true, true, false, false);
        emit MoleculeUpdated(address(molecule));
        subToMultipleFans.updateMolecule(address(molecule));

        vm.startPrank(daisy);
        vm.deal(daisy, 1 ether);

        // daisy isn't a part of the allowlist - boo daisy
        vm.expectRevert(bytes("User is sanctioned"));
        subToMultipleFans.subscribe{value: 0.001 ether}(daisy);
        vm.stopPrank();
    }
}
