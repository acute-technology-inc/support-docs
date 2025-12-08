# Logic Analyzer Application User Guide

## Setup Environment

Then install the dependencies by the lock file using the following command:

```bash
pip install -r requirements.txt
```

## Run the server

We use `Makefile` to manage our commands.

To serve the documentation on a local server, accessible at http://localhost:8000, run the following command:

```bash
make serve
```

To build the documentation into the specified site directory, run the following command:

```bash
make build
```

To clean the output directory, run the following command:

```bash
make clean
```
