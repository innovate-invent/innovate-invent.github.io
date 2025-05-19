---
title: Subprocess calls and why you should never do them
excerpt: Subprocess calls are non-trivial, especially when calling arbitrary executables
published: false  
tags: [subprocess, process, system, execution, IPC, dependency management]
at_url: at://did:plc:gdfkbwgnydyn4xgea7e7e6ht/app.bsky.feed.post/
---

- process quotas/isolation
  - cpu utilisation/limits
    - subprocesses inherit thread priority
  - memory utilization/limits
  - disk space utilization/limits/access
- ipc limitations
  - many copies/pickling/serialization
  - parsing stdout and stderr
  - string building for stdin
  - no typing
- limited error handling
  - return codes vs rich exception handling
    - most programs do not implement consistent return codes, if they even ever return non-zero
  - in-memory debugging
  - error recovery
    - what happens to your code when the subprocess crashes or locks up
- permissions
- closure/dependency management
  - filesystem assumptions
  - system mutations may cause failures
    - $PATH
    - LD_LIBRARY_PATH
    - shell scripts pretending to be binaries and shebang /usr/bin/sh is often a symlink
    - PWD
  - versioning
  - breaking CLI changes
  - no free runtime version/compat/linking checks
  - TOCTOU attacks swapping binaries vs loading libraries into protected memory on startup
- asynchronous with no free sync mechanisms
  - stdin/out blocking on read
- process lifetime
  - orphan processes
- depending on how you do it you might be executing via a shell
  - shell command injection attacks
  - command length limits
  - parameter encoding
- communicating with system processes
  - kernel communication
  - networking
  - systemctl
- maintainability
  - command line commands shotgunned throughout code
  - even if commands are consolidated into a single location, it is common for aspects of the underlying command to 
    leak through any wrapping abstraction
  - deployment migration


The arguments here are split between web services/distributed computing and standalone applications


[Python](https://docs.python.org/3/library/subprocess.html)
```python
os.system("/usr/bin/git commit -m Fixes a bug.")
# or
Popen(["/usr/bin/git", "commit", "-m", "Fixes a bug."])
```

[Go](https://pkg.go.dev/os/exec#Command)
```golang
cmd := exec.Command("/usr/bin/git", "commit", "-m", "Fixes a bug.")
```

[C](https://www.man7.org/linux/man-pages/man3/execl.3.html)
```C
int ret = system("/usr/bin/git", "commit", "-m", "Fixes a bug.");
```

[Java](https://docs.oracle.com/javase/8/docs/api/java/lang/ProcessBuilder.html)
```java
Process p = new ProcessBuilder("/usr/bin/git", "commit", "-m", "Fixes a bug.").start();
```

[Rust](https://doc.rust-lang.org/std/process/struct.Command.html)
```rust
let result = Command::new("/usr/bin/git").arg("commit").arg("-m").arg("Fixes a bug.").spawn()
```

[NodeJS](https://nodejs.org/api/child_process.html)
```nodejs
let p = execFile("/usr/bin/git", "commit", "-m", "Fixes a bug.")
```

TODO system config libraries or sysfs/procfs paths as alternatives

TODO process manager solutions