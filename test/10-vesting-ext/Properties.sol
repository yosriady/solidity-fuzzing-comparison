// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import { Setup } from "./Setup.sol";
import { Asserts } from "@chimera/Asserts.sol";

abstract contract Properties is Setup, Asserts {

    function property_users_points_sum_eq_total_points() public view returns(bool result) {
        uint24 totalPoints;

        // sum up all user points
        for(uint256 i; i<recipients.length; i++) {
            (uint24 points, , , ) = vesting.allocations(recipients[i]);

            totalPoints += points;
        }

        // true if invariant held, false otherwise
        if(totalPoints == TOTAL_POINTS) result = true;

        // note: Solidity always initializes to default values
        // so no need to explicitly set result = false as false
        // is the default value for bool
    }

    // TODO: write an additional invariant. If you need to track additional
    // ghost variables, add them to `Setup` storage
    function property_preclaimed_tokens_sum_eq_max_reclaimable_tokens() public view returns(bool result) {
        result = totalPreclaimed == MAX_RECLAIMABLE;
    }
}