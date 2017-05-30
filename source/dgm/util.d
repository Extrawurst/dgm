/++
Authors: Stephan Dilly
License: MIT

Special thanks to:
$(UL
  $(LI David Herberth who is the author of gl3n on which dgm is based on.)
)
+/
module dgm.util;

static import std.compiler;

static if (std.compiler.version_major > 2 ||
            std.compiler.version_minor > 68)
{
    import std.meta : AliasSeq;
    alias TypeTuple = AliasSeq;
}
else {
    import std.typetuple : TypeTuple;
}

import dgm.linalg.vector;
import dgm.linalg.matrix;
import dgm.linalg.quaternion;

template TupleRange(int from, int to) if (from <= to) {
    static if (from >= to) {
        alias TupleRange = TypeTuple!();
    } else {
        alias TupleRange = TypeTuple!(from, TupleRange!(from + 1, to));
    }
}

private void is_vector_impl(T, int d)(Vector!(T, d) vec) {}

/// If T is a vector, this evaluates to true, otherwise false.
template is_vector(T) {
    enum is_vector = is(typeof(is_vector_impl(T.init)));
}

private void is_matrix_impl(T, int r, int c)(Matrix!(T, r, c) mat) {}

/// If T is a matrix, this evaluates to true, otherwise false.
template is_matrix(T) {
    enum is_matrix = is(typeof(is_matrix_impl(T.init)));
}

private void is_quaternion_impl(T)(Quaternion!(T) qu) {}

/// If T is a quaternion, this evaluates to true, otherwise false.
template is_quaternion(T) {
    enum is_quaternion = is(typeof(is_quaternion_impl(T.init)));
}