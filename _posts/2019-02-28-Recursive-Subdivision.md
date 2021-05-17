---
title: Recursive Subdivision 
excerpt: A simple, closed form, equation to recursively subdivide a domain 
tags: colors subdivide recursive distinct math equation 
header:
    teaser: /assets/posts/2019-02-28-Recursive-Subdivision/GoldenSpiralLogarithmic_color_in.png
---
<script src="https://polyfill.io/v3/polyfill.min.js?features=es6"></script>
<script>
MathJax = {
  loader: {load: ['input/asciimath', 'output/chtml', 'ui/menu']},
};
</script>
<script type="text/javascript" id="MathJax-script" async
  src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/startup.js">
</script>

For an infinite discreet series n we want to map to a range [0, 1] such that the values within that range are as
distant (distinct) as possible without recalculating the predecessors (`d(n)`).

This can be done in O(1) time via recursive subdivision of the range.

```
  n  = 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17 ...
d(n) = 0, 1, 0.5, 0.25, 0.75, 0.125, 0.375 ...
     = 0/1, 1/1, 1/2, 1/4, 3/4, 1/8, 3/8, 5/8, 7/8, 1/16, 3/16, ...
```

You can see the numerator and denominator are increasing with a logarithmic pattern. Because we are recursively
subdividing by 2 it is `ceil(log_2(n))`. `log_2(n)` is not defined at n=0, this edge case will be defined
as `log_2(0)=0` for convenience.

```
d(0) = 0
d(n) = g(n-1)/2^f(n)

 f(n) = ceil(log_2(n))
      = 0, 0, 1, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4, 4, 4, 5
2^f(n)= 1, 1, 2, 4, 4, 8, 8, 8, 8, 16, 16, 16, 16, 16, 16, 16, 16, 32
```

The numerator is a little more complicated as it is the integer remainder of `log_2(n)` or `n - 2^floor(log_2(n))`. Once
again, for convenience, we will define the integer remainder of `log_2(0)` to be 0.

```
                      n = 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10,11,12, ...
    2^(floor(log_2(n))) = 0, 1, 2, 2, 4, 4, 4, 4, 8, 8, 8, 8, 8, ...
n - 2^(floor(log_2(n))) = 0, 0, 0, 1, 0, 1, 2, 3, 0, 1, 2, 3, 4, ...
```

This series is `(x-1)/2` away from the series we want, and shifted left on `n` so we adjust by `*2+1` and
substitute `n=n-1`

```
  g(-1)= 0
  g(0) = 1
     n = 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10,11,12, ...
  g(n) = (n - 2^(floor(log_2(n)))) * 2 + 1
       = 1, 1, 1, 3, 1, 3, 5, 7, 1, 3, 5, 7, 9, 11, 13, 15, 1, ...
g(n-1) = (n - 1 - 2^(floor(log_2(n - 1)))) * 2 + 1
       = 2n - 2*2^(floor(log_2(n - 1))) - 1
       = (n - 2^(floor(log_2(n - 1)))) * 2 - 1
       = 0, 1, 1, 1, 3, 1, 3, 5, 7, 1, 3, 5, 7, 9, 11, 13, 15, 1, ...
```

It is worth noting that `floor(log_2())` can be optimised using bitwise operations and intermediate values can be
exploited to avoid the `2^(log_2())` silliness:

```
floor(log_2(n)) = intlog(n) = count(while ( n >>= 1 ))
2^(floor(log_2(n)))) = expfloor(n) = 1 << intlog(n)
(n - 2^(floor(log_2(n)))) = logrem(n) = (expfloor(n) - 1) & n
2^(ceil(log_2(n))) = logrem ? expfloor(n) << 1 : expfloor(n)
```

Rather than calculating `floor(log_2(n))` and `floor(log_2(n-1))`, you can observe that `logrem(n)` (log_2 remainder) is
one greater than `logrem(n-1)`, except when `logrem(n) == 0`. For that case `logrem(n-1) = expfloor(n-1) - 1`. The
optimisations for `logrem(n-1)` and calculating `2^f(n)` can be combined under a single conditional. This also allows
for significant factoring of `g(n-1)` to take place. Consider the following when `logrem(n) == 0`:

```
g(n-1) = ((n - 1) - 2^(floor(log_2(n - 1)))) * 2 + 1
       = logrem(n-1) * 2 + 1
       = (expfloor(n-1) - 1) * 2 + 1
       = expfloor(n-1) << 1 - 1          // x << 1 = x * 2
       = ((expfloor(n) >> 1) << 1) - 1  // expfloor(n-1) = expfloor(n) >> 1
       = expfloor(n) - 1
d(n)   = g(n-1)/2^f(n)  [logrem(n) == 0]
       = expfloor(n) - 1 / expfloor(n)
```

With the `logrem(n) == 0` condition solved, the remaining can be calculated as:

```
g(n-1) = ((n - 1) - 2^(floor(log_2(n - 1)))) * 2 + 1
       = logrem(n-1) * 2 + 1
       = (logrem(n) - 1) * 2 + 1
       = logrem(n) * 2 - 1
d(n)   = g(n-1)/2^f(n)  [logrem(n) != 0]
       = (logrem(n) * 2 - 1) / (expfloor(n) << 1)
       = ((logrem(n) - 0.5) * 2) / (expfloor(n) * 2)  // x << 1 = x * 2
       = (logrem(n) - 0.5) / expfloor(n)
```

For example, in C++ this would be written:

```c++
double d(unsigned int n) {
    if (n < 2) return n;
    unsigned int intlog = 0;
    for (auto tmp = n ^ 1; tmp >>= 1; ++intlog);
    const auto expfloor = 1 << intlog;
    const auto logrem = (expfloor - 1) & n;
    return (double)(logrem ? logrem - 0.5 : expfloor - 1) / expfloor;
}
```

A visual demonstration of the algorithm in action:

<div>
    0
    <canvas id="subdivision" style="height: 1em; width: 100%; display: inline-block;">
    Your browser is unable to support the visual demonstration of this algorithm
    </canvas>
    1
</div>
<script type="javascript">
const canvas = document.getElementById('subdivision');
if (canvas.getContext){
    const ctx = canvas.getContext('2d');
    ctx.lineWidth = 1;
    ctx.fillStyle = 'black';
    let n = 0;
    setInterval(function() {
        if (n > canvas.width) {
            n = 0;
            ctx.clearRect(0, 0, canvas.width, canvas.height);
        } else {
            let d;
            if (n < 2) d = n;
            else {
                let intlog = 0;
                for (let tmp = n ^ 1; tmp >>>= 1; ++intlog);
                const expfloor = 1 << intlog;
                const logrem = (expfloor - 1) & n;
                d = (logrem === 0 ? logrem - 0.5 : expfloor - 1) / expfloor;
            }
            d = Math.floor( d * canvas.width );
            ctx.beginPath();
            ctx.moveTo(d, 0);
            ctx.lineTo(d, canvas.height);
            ctx.stroke();
            ++n;
        }
    }, 500);
}
</script>

If you are having to calculate this A LOT then check out
the [x86 BSR operation](https://c9x.me/x86/html/file_module_x86_id_20.html)
that many programming languages expose via one library or another. You probably shouldn't bother with this optimisation
in most cases as it just makes for hard to read code. See
also [Round up to the next highest power of 2](https://graphics.stanford.edu/~seander/bithacks.html#RoundUpPowerOf2)
for an alternative bit twiddling hack. 

