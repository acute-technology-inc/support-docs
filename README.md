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

## Folder Structure

In our case, we are using i18n to localize the documentation. [Link](https://ultrabug.github.io/mkdocs-static-i18n/getting-started/quick-start/#the-folder-docs-structure)

So we structure the documentation as follows:

```
./docs
├── assets
│   └── image_non_localized.png
├── en
│   ├── image_localized.png
│   ├── index.md
│   ├── topic1
│   │   └── index.md
│   └── topic2
│       └── index.md
└── zh
    ├── image_localized.png
    ├── index.md
    ├── topic1
    │   └── index.md
    └── topic2
        └── index.md
```

- Keep all filenames in English, accept only dashes (i.e. no spaces, no underscores, no special characters).
