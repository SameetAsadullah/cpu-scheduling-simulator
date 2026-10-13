# Five-state simulator architecture

The project models the classic operating-system process lifecycle as cooperating Unix processes rather than as a single in-memory simulation.

```text
new → ready ⇄ running → exit
        ↑         ↓
        └─ blocked
```

Each state is implemented by a separate C++ executable:

- `new` reads the workload, creates the initial process records, and starts the ready state.
- `ready` maintains the scheduling queue and applies FCFS, SJF, or Round Robin ordering.
- `running` simulates CPU execution and routes completed or blocked processes.
- `blocked` holds processes during simulated I/O and returns them to the ready state.
- `exit` calculates throughput, average waiting time, and average turnaround time.
- `simulator` is the small entry point that launches the state pipeline.

The executables exchange process records through Unix pipes and named FIFOs. `fork`, `exec`, `dup`/`dup2`, file descriptors, and process synchronization are used to demonstrate operating-system primitives directly.
