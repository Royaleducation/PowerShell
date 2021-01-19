function foo {
    $a = "Hello"
    return $a
}
foo

function bar {
    $a = "Hello"
    $a
    return
} 
bar

function quux {
    $a = "Hello"
    $a
} 
quux

function earlyexit {
    "Hello"
    return
    "World"
}
earlyexit