
# Anki xiehanzi Offline Utility Deck

This repository is for generating the necessary data for the xiehanzi offline utility deck. If you prefer to download a pre-generated deck with all data included, please download the "Anki-xiehanzi-offline-utility-deck.apkg" from this repository.

## Overview

The xiehanzi tool (found [here](https://krmanik.github.io/Anki-xiehanzi/)) requires specific data files to work offline. This repository provides scripts to automate the generation of a TSV deck file containing these data files, making it easy to setup and use xiehanzi offline in Anki.

## Repository Contents

- **generate-deck-tsv.sh**: A shell script to download the necessary JSON data, process it, and compile it into a TSV file stored in a 'data' directory.
- **README.md**: This file, which provides documentation on how to use the scripts and resources provided.

## Prerequisites

- [Anki](https://apps.ankiweb.net/) installed on your computer.
- Access to a terminal or command line interface.

## Setup and Usage Instructions

### 1. Run the Script

Execute the script to generate the TSV file and download the JSON data:

```bash
./generate-deck-tsv.sh
```

This script will create a `data` directory containing the `xiehanzi_offline_data.tsv` file and a `json_files` directory with the necessary JSON files, along with a `front.html` file that includes image tags for each character.

### 2. Copy JSON Files into Anki's Collection Media Folder

To ensure the xiehanzi tool functions correctly offline, copy the JSON files from the `json_files` directory to your Anki collection's media folder. You can find the location of this folder by following the instructions [here](https://docs.ankiweb.net/files.html#file-locations). This step is crucial for the proper functioning of the deck.

### 3. Import TSV File into Anki

Follow these steps to import the generated TSV file into Anki:

- Open Anki.
- Select `File > Import` from the menu.
- Choose the `xiehanzi_offline_data.tsv` file located in the `data` directory.
- Import this file into a new or existing deck as required.

### 4. Update the Card Template

After importing, open the card template for the deck and paste the content of `front.html` into the front template of your card. This is essential for displaying the character data correctly. You can find more about editing card templates [here](https://docs.ankiweb.net/templates/intro.html).

### 5. Renaming the Deck (if necessary)

After importing, you may rename the deck to better reflect its purpose or to organize your study materials:

- Click on the deck name in Anki.
- Select `Rename` from the options.

### 6. Update Deck Settings

Since this deck is intended for utility purposes and not daily study, update the deck settings to set the daily new cards to 0 "for this deck only":

- Select the deck.
- Click on `Options`.
- Adjust `New Cards/Day` to `0` under `Daily Limits`, ensuring you select "for this deck only".

## Additional Resources

- **xiehanzi Tool**: [Anki xiehanzi](https://krmanik.github.io/Anki-xiehanzi/)
- **Hanzi Writer Project**: [Hanzi Writer](https://hanziwriter.org/), the open-source library used for rendering interactive Chinese character animations.

## Contributions

Contributions to this project are welcome! Please consider enhancing scripts, documentation, or adding new features to help improve the use of xiehanzi offline.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
