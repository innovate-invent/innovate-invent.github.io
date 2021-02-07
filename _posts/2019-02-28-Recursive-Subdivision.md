---
title: Recursive Subdivision
excerpt: A simple, closed form, equation to recursively subdivide a domain
tags: colors subdivide recursive distinct math equation
header:
    og_image: assets/posts/2019-02-28-Recursive-Subdivision/GoldenSpiralLogarithmic_color_in.gif
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

For an infinite discreet series n we want to map to a range [0, 1] such that the values within that 
range are as distant (distinct) as possible without recalculating the predecessors (`d(n)`).

This can be done in O(1) time via recursive subdivision of the range.
```
  n  = 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17 ...
d(n) = 0, 1, 0.5, 0.25, 0.75, 0.125, 0.375 ...
     = 0/1, 1/1, 1/2, 1/4, 3/4, 1/8, 3/8, 5/8, 7/8, 1/16, 3/16, ...
```
You can see the numerator and denominator are increasing with a logarithmic pattern.
Because we are recursively subdividing by 2 it is `ceil(log_2(n))`.
```
d(n) = g(n)/2^f(n)
g(0) = 0
f(0) = 0

 f(n) = ceil(log_2(n))
      = 0, 0, 1, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4, 4, 4, 5
2^f(n)= 1, 1, 2, 4, 4, 8, 8, 8, 8, 16, 16, 16, 16, 16, 16, 16, 16, 32
```

The numerator is a little more complicated as it is the integer remainder of `log_2(n)` or `n - 2^floor(log_2(n))`
```
n - 2^(floor(log_2(n))) = 0, 0, 0, 1, 0, 1, 0, 1, 2, 0, 1, 2, 3, ...
```
This series is `(x-1)/2` away from the series we want so we adjust by `*2+1`
```
g(n) = (n - 2^(floor(log_2(n)))) * 2 + 1
     = 0, 1, 1, 1, 3, 1, 3, 5, 7, 1, 3, 5, 7, 9, 11, 13, 15, 1, ...
```
It is worth noting that `floor(log_2())` can be optimised using bitwise operations and intermediate values can be
exploited to avoid the `2^(log_2())` sillyness.

