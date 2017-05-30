/++
Authors: Stephan Dilly
License: MIT

Special thanks to:
$(UL
  $(LI David Herberth who is the author of gl3n on which dgm is based on.)
)
+/
module dgm.math;

import std.math:abs;

import dgm.util;
import dgm.linalg.vector;

/// Compares to values and returns true if the difference is epsilon or smaller.
bool almost_equal(T, S)(T a, S b, float epsilon = 0.000001f) if(!is_vector!T && !is_quaternion!T) {
    if(abs(a-b) <= epsilon) {
        return true;
    }
    return abs(a-b) <= epsilon * abs(b);
}

/// ditto
bool almost_equal(T, S)(T a, S b, float epsilon = 0.000001f) if(is_vector!T && is_vector!S && T.dimension == S.dimension) {
    foreach(i; 0..T.dimension) {
        if(!almost_equal(a.vector[i], b.vector[i], epsilon)) {
            return false;
        }
    }
    return true;
}

bool almost_equal(T)(T a, T b, float epsilon = 0.000001f) if(is_quaternion!T) {
    foreach(i; 0..4) {
        if(!almost_equal(a.quaternion[i], b.quaternion[i], epsilon)) {
            return false;
        }
    }
    return true;
}

unittest {
    assert(almost_equal(0, 0));
    assert(almost_equal(1, 1));
    assert(almost_equal(-1, -1));    
    assert(almost_equal(0f, 0.000001f, 0.000001f));
    assert(almost_equal(1f, 1.1f, 0.1f));
    assert(!almost_equal(1f, 1.1f, 0.01f));

    assert(almost_equal(vec2i(0, 0), vec2(0.0f, 0.0f)));
    assert(almost_equal(vec2(0.0f, 0.0f), vec2(0.000001f, 0.000001f)));
    assert(almost_equal(vec3(0.0f, 1.0f, 2.0f), vec3i(0, 1, 2)));

    /+assert(almost_equal(quat(0.0f, 0.0f, 0.0f, 0.0f), quat(0.0f, 0.0f, 0.0f, 0.0f)));
    assert(almost_equal(quat(0.0f, 0.0f, 0.0f, 0.0f), quat(0.000001f, 0.000001f, 0.000001f, 0.000001f)));
    +/
}