# TAP Input/Output Test Suite

Definition of input/output tests for `library(date_time)` following the [Test Anything
Protocol](http://testanything.org/) (TAP).

## Run Tests

The defined tests can be run using the following command:

```shell
swipl -q -g main -t halt -s test/test.pl
```
Or

```shell
prove -v -e 'swipl -q -t main -s' test/test.p
```

This produces a TAP compatible output like the following:

```prolog
test/test.pl .. 
TAP version 13
1..1
ok 1 - phrase(digraph(_19766),[100,105,103,114,97,112,104,32,100,105,103,32,123,10,10,32,103,114,97,112,104,32,91,103,114,97,61,97,112,104,93,59,10,32,34,67,108,97,115,34,32,91,99,108,97,115,61,34,99,108,97,115,34,93,59,10,32,34,82,101,108,97,34,32,45,62,32,34,116,105,111,110,34,32,91,114,101,108,61,97,116,105,93,59,10,32,125]) -> _19766=digraph([100,105,103],[graph([attribute([103,114,97],[97,112,104])]),class([67,108,97,115],[attribute([99,108,97,115],[99,108,97,115])]),relationship([82,101,108,97],[116,105,111,110],[attribute([114,101,108],[97,116,105])])])

# time=0.2ms
# tests 1
# pass  1
ok
All tests successful.
Files=1, Tests=1,  0 wallclock secs ( 0.03 usr  0.00 sys +  0.03 cusr  0.00 csys =  0.06 CPU)
Result: PASS
```

## Define Tests

Tests are defined in the `test.pl` file after the call of `:- use_module(library(tap))`.
